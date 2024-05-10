/**
 * Datumized Storage
 * Eliminates the need for custom signals specifically for the storage component, and attaches a storage variable (atom_storage) to every atom.
 * The parent and real_location variables are both weakrefs, so they must be resolved before they can be used.
 * If you're looking to create custom storage type behaviors, check ../subtypes
 */
/datum/storage
	/**
	 * A reference to the atom linked to this storage object
	 * If the parent goes, we go. Will never be null.
	 */
	VAR_FINAL/atom/parent
	/**
	 * A reference to the atom where the items are actually stored.
	 * By default this is parent. Should generally never be null.
	 * Sometimes it's not the parent, that's what is called "dissassociated storage".
	 *
	 * Do NOT set this directly, use set_real_location.
	 */
	VAR_FINAL/atom/real_location

	/// List of all the mobs currently viewing the contents of this storage.
	VAR_PRIVATE/list/mob/is_using = list()

	/// The storage display screen object.
	VAR_PRIVATE/atom/movable/screen/storage/boxes
	/// The 'close button' screen object.
	VAR_PRIVATE/atom/movable/screen/close/closer

	/// Typecache of items that can be inserted into this storage.
	/// By default, all item types can be inserted (assuming other conditions are met).
	/// Do not set directly, use set_holdable
	VAR_FINAL/list/obj/item/can_hold
	/// Typecache of items that cannot be inserted into this storage.
	/// By default, no item types are barred from insertion.
	/// Do not set directly, use set_holdable
	VAR_FINAL/list/obj/item/cant_hold
	/// Typecache of items that can always be inserted into this storage, regardless of size.
	VAR_FINAL/list/obj/item/exception_hold
	/// For use with an exception typecache:
	/// The maximum amount of items of the exception type that can be inserted into this storage.
	var/exception_max = INFINITY

	/// Determines whether we play a rustle animation when inserting/removing items.
	var/animated = TRUE
	/// Determines whether we play a rustle sound when inserting/removing items.
	var/rustle_sound = TRUE

	/// The maximum amount of items that can be inserted into this storage.
	var/max_slots = 7
	/// The largest weight class that can be inserted into this storage, inclusive.
	var/max_specific_storage = WEIGHT_CLASS_NORMAL
	/// Determines the maximum amount of weight that can be inserted into this storage.
	/// Weight is calculated by the sum of all of our content's weight classes.
	var/max_total_storage = WEIGHT_CLASS_SMALL * 7

	/// Whether the storage is currently locked (inaccessible). See [code/__DEFINES/storage.dm]
	var/locked = STORAGE_NOT_LOCKED

	/// Whether we open when attack_handed (clicked on with an empty hand).
	var/attack_hand_interact = TRUE

	/// Whether we allow storage objects of the same size inside.
	var/allow_big_nesting = FALSE

	/// If TRUE, we can click on items with the storage object to pick them up and insert them.
	var/allow_quick_gather = FALSE
	/// The mode for collection when allow_quick_gather is enabled. See [code/__DEFINES/storage.dm]
	var/collection_mode = COLLECT_EVERYTHING

	/// If TRUE, we can use-in-hand the storage object to dump all of its contents.
	var/allow_quick_empty = FALSE

	/// If we support smartly removing/inserting things from ourselves
	var/supports_smart_equip = TRUE

	/// An additional description shown on double-examine.
	/// Is autogenerated to the can_hold list if not set.
	var/can_hold_description

	/// The preposition used when inserting items into this storage.
	/// IE: You put things *in* a bag, but *on* a plate.
	var/insert_preposition = "in"

	/// If TRUE, chat messages for inserting/removing items will not be shown.
	var/silent = FALSE
	/// Same as above but only for the user.
	/// Useful to cut on chat spam without removing feedback for other players.
	var/silent_for_user = FALSE

	/// if TRUE, alt-click takes an item out instantly rather than opening up storage.
	var/quickdraw = FALSE

	/// Instead of displaying multiple items of the same type, display them as numbered contents.
	var/numerical_stacking = FALSE

	/// Maximum amount of columns a storage object can have
	var/screen_max_columns = 7
	/// Maximum amount of rows a storage object can have
	var/screen_max_rows = INFINITY
	/// X-pixel location of the boxes and close button
	var/screen_pixel_x = 16
	/// Y-pixel location of the boxes and close button
	var/screen_pixel_y = 16
	/// Where storage starts being rendered, x-screen_loc wise
	var/screen_start_x = 4
	/// Where storage starts being rendered, y-screen_loc wise
	var/screen_start_y = 2

	/// Ref to the item action that toggles collectmode.
	VAR_PRIVATE/datum/action/item_action/storage_gather_mode/modeswitch_action

	/// If TRUE, shows the contents of the storage in open_storage
	var/display_contents = TRUE

	/// Switch this off if you want to handle click_alt in the parent atom
	var/click_alt_open = TRUE


/datum/storage/New(
	atom/parent,
	max_slots = src.max_slots,
	max_specific_storage = src.max_specific_storage,
	max_total_storage = src.max_total_storage,
)
	if(!istype(parent))
		stack_trace("Storage datum ([type]) created without a [isnull(parent) ? "null parent" : "invalid parent ([parent.type])"]!")
		qdel(src)
		return

	boxes = new(null, null, src)
	closer = new(null, null, src)

	set_parent(parent)
	set_real_location(parent)

	src.max_slots = max_slots
	src.max_specific_storage = max_specific_storage
	src.max_total_storage = max_total_storage

	orient_to_hud()

/datum/storage/Destroy()
	parent = null
	real_location = null

	for(var/mob/person in is_using)
		if(person.active_storage == src)
			person.active_storage = null
			person.client?.screen -= boxes
			person.client?.screen -= closer

	QDEL_NULL(boxes)
	QDEL_NULL(closer)

	is_using.Cut()

	return ..()

/datum/storage/proc/on_deconstruct()
	SIGNAL_HANDLER

	remove_all()

/// Automatically ran on all object insertions: flag marking and view refreshing.
/datum/storage/proc/handle_enter(datum/source, obj/item/arrived)
	SIGNAL_HANDLER

	if(!istype(arrived))
		return

	arrived.item_flags |= IN_STORAGE
	refresh_views()
	arrived.on_enter_storage(src)
	SEND_SIGNAL(arrived, COMSIG_ITEM_STORED, src)
	parent.update_appearance()

/// Automatically ran on all object removals: flag marking and view refreshing.
/datum/storage/proc/handle_exit(datum/source, obj/item/gone)
	SIGNAL_HANDLER

	if(!istype(gone))
		return

	gone.item_flags &= ~IN_STORAGE
	remove_and_refresh(gone)
	gone.on_exit_storage(src)
	SEND_SIGNAL(gone, COMSIG_ITEM_UNSTORED, src)
	parent.update_appearance()

/// Set the passed atom as the parent
/datum/storage/proc/set_parent(atom/new_parent)
	PRIVATE_PROC(TRUE)

	ASSERT(isnull(parent))

	parent = new_parent
	// a few of theses should probably be on the real_location rather than the parent
	RegisterSignals(parent, list(COMSIG_ATOM_ATTACK_PAW, COMSIG_ATOM_ATTACK_HAND), PROC_REF(on_attack))
	RegisterSignal(parent, COMSIG_MOUSEDROP_ONTO, PROC_REF(on_mousedrop_onto))
	RegisterSignal(parent, COMSIG_MOUSEDROPPED_ONTO, PROC_REF(on_mousedropped_onto))
	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(parent, COMSIG_ITEM_PRE_ATTACK, PROC_REF(on_preattack))
	RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF, PROC_REF(mass_empty))
	RegisterSignals(parent, list(COMSIG_ATOM_ATTACK_GHOST, COMSIG_ATOM_ATTACK_HAND_SECONDARY), PROC_REF(open_storage_on_signal))
	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY_SECONDARY, PROC_REF(open_storage_attackby_secondary))
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(close_distance))
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(update_actions))
	RegisterSignal(parent, COMSIG_TOPIC, PROC_REF(topic_handle))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(handle_examination))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE_MORE, PROC_REF(handle_extra_examination))
	RegisterSignal(parent, COMSIG_OBJ_DECONSTRUCT, PROC_REF(on_deconstruct))
	RegisterSignal(parent, COMSIG_ATOM_EMP_ACT, PROC_REF(on_emp_act))
	RegisterSignal(parent, COMSIG_ATOM_CONTENTS_WEIGHT_CLASS_CHANGED, PROC_REF(contents_changed_w_class))
	RegisterSignal(parent, COMSIG_CLICK_ALT, PROC_REF(on_click_alt))

/**
 * Sets where items are physically being stored in the case it shouldn't be on the parent.
 *
 * Does not handle moving any existing items, that must be done manually.
 *
 * Arguments
 * * atom/new_real_location - the new real location of the datum
 * * should_drop - if TRUE, all the items in the old real location will be dropped.
 */
/datum/storage/proc/set_real_location(atom/new_real_location, should_drop = FALSE)
	if(!isnull(real_location))
		UnregisterSignal(real_location, list(
			COMSIG_ATOM_ENTERED,
			COMSIG_ATOM_EXITED,
			COMSIG_QDELETING,
			COMSIG_ATOM_EMP_ACT,
		))
		real_location.flags_1 &= ~HAS_DISASSOCIATED_STORAGE_1
		if(should_drop)
			remove_all()

	if(isnull(new_real_location))
		return

	real_location = new_real_location
	if(real_location != parent)
		real_location.flags_1 |= HAS_DISASSOCIATED_STORAGE_1
	RegisterSignal(real_location, COMSIG_ATOM_ENTERED, PROC_REF(handle_enter))
	RegisterSignal(real_location, COMSIG_ATOM_EXITED, PROC_REF(handle_exit))
	RegisterSignal(real_location, COMSIG_QDELETING, PROC_REF(real_location_deleted))

/// Signal handler for when the real location is deleted.
/datum/storage/proc/real_location_deleted(datum/deleting_real_location)
	SIGNAL_HANDLER

	set_real_location(null)

/datum/storage/proc/topic_handle(datum/source, user, href_list)
	SIGNAL_HANDLER

	if(isnull(can_hold_description))
		return

	if(href_list["show_valid_pocket_items"])
		to_chat(user, span_notice("[source] can hold: [can_hold_description]"))

/datum/storage/proc/handle_examination(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(isnull(can_hold_description))
		return

	examine_list += span_notice("You can examine this further to check what kind of extra items it can hold.")

/datum/storage/proc/handle_extra_examination(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(isnull(can_hold_description))
		return

	examine_list += span_notice("[source] can hold: [can_hold_description]")

/// Almost 100% of the time the lists passed into set_holdable are reused for each instance
/// Just fucking cache it 4head
/// Yes I could generalize this, but I don't want anyone else using it. in fact, DO NOT COPY THIS
/// If you find yourself needing this pattern, you're likely better off using static typecaches
/// I'm not because I do not trust implementers of the storage component to use them, BUT
/// IF I FIND YOU USING THIS PATTERN IN YOUR CODE I WILL BREAK YOU ACROSS MY KNEES
/// ~Lemon
GLOBAL_LIST_EMPTY(cached_storage_typecaches)

/datum/storage/proc/set_holdable(list/can_hold_list, list/cant_hold_list)
	if(!isnull(can_hold_list) && !islist(can_hold_list))
		can_hold_list = list(can_hold_list)
	if(!isnull(cant_hold_list) && !islist(cant_hold_list))
		cant_hold_list = list(cant_hold_list)

	if (!isnull(can_hold_list))
		if(isnull(can_hold_description))
			can_hold_description = generate_hold_desc(can_hold_list)

		var/unique_key = can_hold_list.Join("-")
		if(!GLOB.cached_storage_typecaches[unique_key])
			GLOB.cached_storage_typecaches[unique_key] = typecacheof(can_hold_list)
		can_hold = GLOB.cached_storage_typecaches[unique_key]

	if (!isnull(cant_hold_list))
		var/unique_key = cant_hold_list.Join("-")
		if(!GLOB.cached_storage_typecaches[unique_key])
			GLOB.cached_storage_typecaches[unique_key] = typecacheof(cant_hold_list)
		cant_hold = GLOB.cached_storage_typecaches[unique_key]

/// Generates a description, primarily for clothing storage.
/datum/storage/proc/generate_hold_desc(can_hold_list)
	var/list/desc = list()

	for(var/obj/item/valid_item as anything in can_hold_list)
		desc += "\a [initial(valid_item.name)]"

	return "\n\t[span_notice("[desc.Join("\n\t")]")]"

/// Updates the action button for toggling collectmode.
/datum/storage/proc/update_actions(atom/source, mob/equipper, slot)
	SIGNAL_HANDLER

	if(!allow_quick_gather)
		QDEL_NULL(modeswitch_action)
		return
	if(!isnull(modeswitch_action))
		return
	if(!isitem(parent))
		return

	var/obj/item/item_parent = parent
	modeswitch_action = item_parent.add_item_action(/datum/action/item_action/storage_gather_mode)
	RegisterSignal(modeswitch_action, COMSIG_ACTION_TRIGGER, PROC_REF(action_trigger))
	RegisterSignal(modeswitch_action, COMSIG_QDELETING, PROC_REF(action_deleted))

/// Refreshes and item to be put back into the real world, out of storage.
/datum/storage/proc/reset_item(obj/item/thing)
	thing.layer = initial(thing.layer)
	SET_PLANE_IMPLICIT(thing, initial(thing.plane))
	thing.mouse_opacity = initial(thing.mouse_opacity)
	thing.screen_loc = null
	if(thing.maptext)
		thing.maptext = ""

/**
 * Checks if an item is capable of being inserted into the storage.
 *
 * Arguments
 * * obj/item/to_insert - the item we're checking
 * * messages - if TRUE, will print out a message if the item is not valid
 * * force - bypass locked storage up to a certain level. See [code/__DEFINES/storage.dm]
 */
/datum/storage/proc/can_insert(obj/item/to_insert, mob/user, messages = TRUE, force = STORAGE_NOT_LOCKED)
	if(QDELETED(to_insert) || !istype(to_insert))
		return FALSE

	//stops you from putting stuff like off-hand thingy inside. Hologram storages can accept only hologram items
	if(to_insert.item_flags & ABSTRACT)
		return FALSE
	if(parent.flags_1 & HOLOGRAM_1)
		if(!(to_insert.flags_1 & HOLOGRAM_1))
			return FALSE
	else if(to_insert.flags_1 & HOLOGRAM_1)
		return FALSE

	if(locked > force)
		if(messages && user)
			user.balloon_alert(user, "closed!")
		return FALSE

	if((to_insert == parent) || (to_insert == real_location))
		return FALSE

	if(to_insert.w_class > max_specific_storage)
		if(!is_type_in_typecache(to_insert, exception_hold))
			if(messages && user)
				user.balloon_alert(user, "too big!")
			return FALSE
		if(exception_max <= get_exception_count())
			if(messages && user)
				user.balloon_alert(user, "no room!")
			return FALSE

	if(real_location.contents.len >= max_slots)
		if(messages && user && !silent_for_user)
			user.balloon_alert(user, "no room!")
		return FALSE

	if(to_insert.w_class + get_total_weight() > max_total_storage)
		if(messages && user && !silent_for_user)
			user.balloon_alert(user, "no room!")
		return FALSE

	var/can_hold_it = isnull(can_hold) || is_type_in_typecache(to_insert, can_hold)
	var/cant_hold_it = is_type_in_typecache(to_insert, cant_hold)
	var/trait_says_no = HAS_TRAIT(to_insert, TRAIT_NO_STORAGE_INSERT)
	if(!can_hold_it || cant_hold_it || trait_says_no)
		if(messages && user)
			user.balloon_alert(user, "can't hold!")
		return FALSE

	if(HAS_TRAIT(to_insert, TRAIT_NODROP))
		if(messages && user)
			user.balloon_alert(user, "stuck on your hand!")
		return FALSE

	// this is valid if the container our location is being held in is a storage item
	var/datum/storage/bigger_fish = parent.loc.atom_storage
	if(bigger_fish && bigger_fish.max_specific_storage < max_specific_storage)
		if(messages && user)
			user.balloon_alert(user, "[LOWER_TEXT(parent.loc.name)] is in the way!")
		return FALSE

	if(isitem(parent))
		var/obj/item/item_parent = parent
		var/datum/storage/smaller_fish = to_insert.atom_storage
		if(smaller_fish && !allow_big_nesting && to_insert.w_class >= item_parent.w_class)
			if(messages && user)
				user.balloon_alert(user, "too big!")
			return FALSE

	return TRUE

/// Returns a count of how many items held due to exception_hold we have
/datum/storage/proc/get_exception_count()
	var/count = 0
	for(var/obj/item/thing in real_location)
		if(thing.w_class > max_specific_storage && is_type_in_typecache(thing, exception_hold))
			count += 1
	return count

/// Returns a sum of all of our content's weight classes
/datum/storage/proc/get_total_weight()
	var/total_weight = 0
	for(var/obj/item/thing in real_location)
		total_weight += thing.w_class
	return total_weight

/**
 * Attempts to insert an item into the storage
 *
 * Arguments
 * * obj/item/to_insert - the item we're inserting
 * * mob/user - (optional) the user who is inserting the item.
 * * override - see item_insertion_feedback()
 * * force - bypass locked storage up to a certain level. See [code/__DEFINES/storage.dm]
 * * messages - if TRUE, we will create balloon alerts for the user.
 */
/datum/storage/proc/attempt_insert(obj/item/to_insert, mob/user, override = FALSE, force = STORAGE_NOT_LOCKED, messages = TRUE)
	SHOULD_NOT_SLEEP(TRUE)

	if(!can_insert(to_insert, user, messages = messages, force = force))
		return FALSE

	SEND_SIGNAL(parent, COMSIG_STORAGE_STORED_ITEM, to_insert, user, force)
	to_insert.forceMove(real_location)
	item_insertion_feedback(user, to_insert, override)
	parent.update_appearance()
	return TRUE

/**
 * Inserts every item in a given list, with a progress bar
 *
 * Arguments
 * * mob/user - the user who is inserting the items
 * * list/things - the list of items to insert
 * * atom/thing_loc - the location of the items (used to make sure an item hasn't moved during pickup)
 * * list/rejections - a list used to make sure we only complain once about an invalid insertion
 * * datum/progressbar/progress - the progressbar used to show the progress of the insertion
 */
/datum/storage/proc/handle_mass_pickup(mob/user, list/things, atom/thing_loc, list/rejections, datum/progressbar/progress)
	for(var/obj/item/thing in things)
		things -= thing
		if(thing.loc != thing_loc)
			continue
		if(thing.type in rejections) // To limit bag spamming: any given type only complains once
			continue
		if(!attempt_insert(thing, user, override = TRUE)) // Note can_be_inserted still makes noise when the answer is no
			if(real_location.contents.len >= max_slots)
				break
			rejections += thing.type // therefore full bags are still a little spammy
			continue

		if (TICK_CHECK)
			progress.update(progress.goal - things.len)
			return TRUE

	progress.update(progress.goal - things.len)
	return FALSE

/**
 * Provides visual feedback in chat for an item insertion
 *
 * Arguments
 * * mob/user - the user who is inserting the item
 * * obj/item/thing - the item we're inserting
 * * override - skip feedback, only do animation check
 */
/datum/storage/proc/item_insertion_feedback(mob/user, obj/item/thing, override = FALSE)
	if(animated)
		animate_parent()

	if(override)
		return

	if(silent)
		return

	if(rustle_sound)
		playsound(parent, SFX_RUSTLE, 50, TRUE, -5)

	if(!silent_for_user)
		to_chat(user, span_notice("You put [thing] [insert_preposition]to [parent]."))

	for(var/mob/viewing in oviewers(user))
		if(in_range(user, viewing) || (thing?.w_class >= WEIGHT_CLASS_NORMAL))
			viewing.show_message(span_notice("[user] puts [thing] [insert_preposition]to [parent]."), MSG_VISUAL)


/**
 * Attempts to remove an item from the storage
 * Ignores removal do_afters. Only use this if you're doing it as part of a dumping action
 *
 * Arguments
 * * obj/item/thing - the object we're removing
 * * atom/remove_to_loc - where we're placing the item
 * * silent - if TRUE, we won't play any exit sounds
 */
/datum/storage/proc/attempt_remove(obj/item/thing, atom/remove_to_loc, silent = FALSE)
	SHOULD_NOT_SLEEP(TRUE)

	if(istype(thing) && ismob(parent.loc))
		var/mob/mob_parent = parent.loc
		thing.dropped(mob_parent, /*silent = */TRUE)

	if(remove_to_loc)
		reset_item(thing)
		thing.forceMove(remove_to_loc)

		if(rustle_sound && !silent)
			playsound(parent, SFX_RUSTLE, 50, TRUE, -5)
	else
		thing.moveToNullspace()

	if(animated)
		animate_parent()

	refresh_views()
	parent.update_appearance()
	return TRUE

/**
 * Removes everything inside of our storage
 *
 * Arguments
 * * atom/drop_loc - where we're placing the item
 */
/datum/storage/proc/remove_all(atom/drop_loc = parent.drop_location())
	for(var/obj/item/thing in real_location)
		if(!attempt_remove(thing, drop_loc, silent = TRUE))
			continue
		thing.pixel_x = thing.base_pixel_x + rand(-8, 8)
		thing.pixel_y = thing.base_pixel_y + rand(-8, 8)

/**
 * Allows a mob to attempt to remove a single item from the storage
 * Allows for hooks into things like removal delays
 *
 * Arguments
 * * mob/removing - the mob doing the removing
 * * obj/item/thing - the object we're removing
 * * atom/remove_to_loc - where we're placing the item
 * * silent - if TRUE, we won't play any exit sounds
 */
/datum/storage/proc/remove_single(mob/removing, obj/item/thing, atom/remove_to_loc, silent = FALSE)
	return attempt_remove(thing, remove_to_loc, silent)

/**
 * Removes only a specific type of item from our storage
 *
 * Arguments
 * * type - the type of item to remove
 * * amount - how many we should attempt to pick up at one time
 * * check_adjacent - if TRUE, we'll check adjacent locations for the item type
 * * force - if TRUE, we'll bypass the check_adjacent check all together
 * * mob/user - the user who is removing the items
 * * list/inserted - (optional) allows consumers to pass a list to be filled with all removed items.
 */
/datum/storage/proc/remove_type(type, atom/destination, amount = INFINITY, check_adjacent = FALSE, force = FALSE, mob/user, list/inserted)
	if(!force && check_adjacent)
		if(isnull(user) || !user.CanReach(destination) || !user.CanReach(parent))
			return FALSE

	var/list/taking = typecache_filter_list(real_location.contents, typecacheof(type))
	if(taking.len > amount)
		taking.len = amount

	if(inserted) //duplicated code for performance, don't bother checking retval/checking for list every item.
		for(var/i in taking)
			if(attempt_remove(i, destination))
				inserted |= i
	else
		for(var/i in taking)
			attempt_remove(i, destination)

	return TRUE

/// Signal handler for remove_all()
/datum/storage/proc/mass_empty(datum/source, mob/user)
	SIGNAL_HANDLER

	if(!allow_quick_empty)
		return

	remove_all(user.drop_location())

/**
 * Recursive proc to get absolutely EVERYTHING inside a storage item, including the contents of inner items.
 *
 * Arguments
 * * recursive - whether or not we're checking inside of inner items
 */
/datum/storage/proc/return_inv(recursive = TRUE)
	var/list/ret = list()

	for(var/atom/found_thing as anything in real_location)
		ret |= found_thing
		if(recursive && found_thing.atom_storage)
			ret |= found_thing.atom_storage.return_inv(recursive = TRUE)

	return ret

/**
 * Resets an object, removes it from our screen, and refreshes the view.
 *
 * @param atom/movable/gone the object leaving our storage
 */
/datum/storage/proc/remove_and_refresh(atom/movable/gone)
	SIGNAL_HANDLER

	for(var/mob/user in is_using)
		if(user.client)
			var/client/cuser = user.client
			cuser.screen -= gone

	reset_item(gone)
	refresh_views()

/// Signal handler for emp_act to emp all contents
/datum/storage/proc/on_emp_act(datum/source, severity, protection)
	SIGNAL_HANDLER

	if(protection & EMP_PROTECT_CONTENTS)
		return

	for(var/obj/item/thing in real_location)
		thing.emp_act(severity)

/// Signal handler for preattack from an object.
/datum/storage/proc/on_preattack(datum/source, obj/item/thing, mob/user, params)
	SIGNAL_HANDLER

	if(!istype(thing) || !allow_quick_gather || thing.atom_storage)
		return

	if(collection_mode == COLLECT_ONE)
		attempt_insert(thing, user)
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(!isturf(thing.loc))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	INVOKE_ASYNC(src, PROC_REF(collect_on_turf), thing, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/**
 * Collects every item of a type on a turf.
 *
 * @param obj/item/thing the initial object to pick up
 * @param mob/user the user who is picking up the items
 */
/datum/storage/proc/collect_on_turf(obj/item/thing, mob/user)
	var/atom/holder = thing.loc
	var/list/pick_up = holder.contents.Copy()

	if(collection_mode == COLLECT_SAME)
		pick_up = typecache_filter_list(pick_up, typecacheof(thing.type))

	var/amount = length(pick_up)
	if(!amount)
		parent.balloon_alert(user, "nothing to pick up!")
		return

	var/datum/progressbar/progress = new(user, amount, thing.loc)
	var/list/rejections = list()

	while(do_after(user, 1 SECONDS, parent, NONE, FALSE, CALLBACK(src, PROC_REF(handle_mass_pickup), user, pick_up.Copy(), thing.loc, rejections, progress)))
		stoplag(1)

	progress.end_progress()
	// If nothing was actually removed, don't send the pickup message
	var/list/current_contents = holder.contents.Copy()
	if(length(pick_up | current_contents) == length(current_contents))
		return
	parent.balloon_alert(user, "picked up")

/// Signal handler for whenever we drag the storage somewhere.
/datum/storage/proc/on_mousedrop_onto(datum/source, atom/over_object, mob/user)
	SIGNAL_HANDLER

	if(ismecha(user.loc) || user.incapacitated() || !user.canUseStorage())
		return

	parent.add_fingerprint(user)

	if(istype(over_object, /atom/movable/screen/inventory/hand))
		if(real_location.loc != user)
			return

		var/atom/movable/screen/inventory/hand/hand = over_object
		user.putItemFromInventoryInHandIfPossible(parent, hand.held_index)

	else if(ismob(over_object))
		if(over_object != user)
			return

		INVOKE_ASYNC(src, PROC_REF(open_storage), user)

	else if(!istype(over_object, /atom/movable/screen))
		INVOKE_ASYNC(src, PROC_REF(dump_content_at), over_object, user)

/**
 * Dumps all of our contents at a specific location.
 *
 * @param atom/dest_object where to dump to
 * @param mob/user the user who is dumping the contents
 */
/datum/storage/proc/dump_content_at(atom/dest_object, mob/user)
	if(locked)
		user.balloon_alert(user, "closed!")
		return
	if(!user.CanReach(parent) || !user.CanReach(dest_object))
		return

	if(SEND_SIGNAL(dest_object, COMSIG_STORAGE_DUMP_CONTENT, src, user) & STORAGE_DUMP_HANDLED)
		return

	// Storage to storage transfer is instant
	if(dest_object.atom_storage)
		to_chat(user, span_notice("You dump the contents of [parent] into [dest_object]."))

		if(rustle_sound)
			playsound(parent, SFX_RUSTLE, 50, TRUE, -5)

		for(var/obj/item/to_dump in real_location)
			dest_object.atom_storage.attempt_insert(to_dump, user)
		parent.update_appearance()
		SEND_SIGNAL(src, COMSIG_STORAGE_DUMP_POST_TRANSFER, dest_object, user)
		return

	var/atom/dump_loc = dest_object.get_dumping_location()
	if(isnull(dump_loc))
		return

	// Storage to loc transfer requires a do_after
	to_chat(user, span_notice("You start dumping out the contents of [parent] onto [dest_object]..."))
	if(!do_after(user, 2 SECONDS, target = dest_object))
		return

	remove_all(dump_loc)

/// Signal handler for whenever something gets mouse-dropped onto us.
/datum/storage/proc/on_mousedropped_onto(datum/source, obj/item/dropping, mob/user)
	SIGNAL_HANDLER

	if(!istype(dropping))
		return
	if(dropping != user.get_active_held_item())
		return
	if(dropping.atom_storage) // If it has storage it should be trying to dump, not insert.
		return

	if(!iscarbon(user) && !isdrone(user))
		return
	var/mob/living/user_living = user
	if(user_living.incapacitated())
		return

	attempt_insert(dropping, user)

/// Signal handler for whenever we're attacked by an object.
/datum/storage/proc/on_attackby(datum/source, obj/item/thing, mob/user, params)
	SIGNAL_HANDLER

	if(!thing.attackby_storage_insert(src, parent, user))
		return

	if(iscyborg(user))
		return COMPONENT_NO_AFTERATTACK

	attempt_insert(thing, user)
	return COMPONENT_NO_AFTERATTACK

/// Signal handler for whenever we're attacked by a mob.
/datum/storage/proc/on_attack(datum/source, mob/user)
	SIGNAL_HANDLER

	if(!attack_hand_interact)
		return
	if(user.active_storage == src && parent.loc == user)
		user.active_storage.hide_contents(user)
		hide_contents(user)
		return COMPONENT_CANCEL_ATTACK_CHAIN
	if(ishuman(user))
		var/mob/living/carbon/human/hum = user
		if(hum.l_store == parent && !hum.get_active_held_item())
			INVOKE_ASYNC(hum, TYPE_PROC_REF(/mob, put_in_hands), parent)
			hum.l_store = null
			return
		if(hum.r_store == parent && !hum.get_active_held_item())
			INVOKE_ASYNC(hum, TYPE_PROC_REF(/mob, put_in_hands), parent)
			hum.r_store = null
			return

	if(parent.loc == user)
		INVOKE_ASYNC(src, PROC_REF(open_storage), user)
		return COMPONENT_CANCEL_ATTACK_CHAIN

/// Generates the numbers on an item in storage to show stacking.
/datum/storage/proc/process_numerical_display()
	var/list/toreturn = list()

	for(var/obj/item/thing in real_location)
		var/total_amnt = 1

		if(isstack(thing))
			var/obj/item/stack/things = thing
			total_amnt = things.amount

		if(!toreturn["[thing.type]-[thing.name]"])
			toreturn["[thing.type]-[thing.name]"] = new /datum/numbered_display(thing, total_amnt)
		else
			var/datum/numbered_display/numberdisplay = toreturn["[thing.type]-[thing.name]"]
			numberdisplay.number += total_amnt

	return toreturn

/// Updates the storage UI to fit all objects inside storage.
/datum/storage/proc/orient_to_hud()
	var/adjusted_contents = real_location.contents.len

	//Numbered contents display
	var/list/datum/numbered_display/numbered_contents
	if(numerical_stacking)
		numbered_contents = process_numerical_display()
		adjusted_contents = numbered_contents.len
	//if the ammount of contents reaches some multiplier of the final column (and its not the last slot), let the player view an additional row
	var/additional_row = (!(adjusted_contents % screen_max_columns) && adjusted_contents < max_slots)

	var/columns = clamp(max_slots, 1, screen_max_columns)
	var/rows = clamp(CEILING(adjusted_contents / columns, 1) + additional_row, 1, screen_max_rows)

	orient_item_boxes(rows, columns, numbered_contents)

/// Generates the actual UI objects, their location, and alignments whenever we open storage up.
/datum/storage/proc/orient_item_boxes(rows, cols, list/obj/item/numerical_display_contents)
	boxes.screen_loc = "[screen_start_x]:[screen_pixel_x],[screen_start_y]:[screen_pixel_y] to [screen_start_x+cols-1]:[screen_pixel_x],[screen_start_y+rows-1]:[screen_pixel_y]"
	var/current_x = screen_start_x
	var/current_y = screen_start_y
	var/turf/our_turf = get_turf(real_location)

	if(islist(numerical_display_contents))
		for(var/type in numerical_display_contents)
			var/datum/numbered_display/numberdisplay = numerical_display_contents[type]

			var/obj/item/display_sample = numberdisplay.sample_object
			display_sample.mouse_opacity = MOUSE_OPACITY_OPAQUE
			display_sample.screen_loc = "[current_x]:[screen_pixel_x],[current_y]:[screen_pixel_y]"
			display_sample.maptext = MAPTEXT("<font color='white'>[(numberdisplay.number > 1)? "[numberdisplay.number]" : ""]</font>")
			SET_PLANE(display_sample, ABOVE_HUD_PLANE, our_turf)

			current_x++

			if(current_x - screen_start_x >= cols)
				current_x = screen_start_x
				current_y++

				if(current_y - screen_start_y >= rows)
					break

	else
		for(var/obj/item in real_location)
			item.mouse_opacity = MOUSE_OPACITY_OPAQUE
			item.screen_loc = "[current_x]:[screen_pixel_x],[current_y]:[screen_pixel_y]"
			item.maptext = ""
			item.plane = ABOVE_HUD_PLANE
			SET_PLANE(item, ABOVE_HUD_PLANE, our_turf)

			current_x++

			if(current_x - screen_start_x >= cols)
				current_x = screen_start_x
				current_y++

				if(current_y - screen_start_y >= rows)
					break

	closer.screen_loc = "[screen_start_x + cols]:[screen_pixel_x],[screen_start_y]:[screen_pixel_y]"


/// Signal handler for when we get attacked with secondary click by an item.
/datum/storage/proc/open_storage_attackby_secondary(datum/source, atom/weapon, mob/user)
	SIGNAL_HANDLER

	if(istype(weapon, /obj/item/chameleon))
		var/obj/item/chameleon/chameleon_weapon = weapon
		chameleon_weapon.make_copy(source, user)

	return open_storage_on_signal(source, user)

/// Signal handler to open up the storage when we receive a signal.
/datum/storage/proc/open_storage_on_signal(datum/source, mob/to_show)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(open_storage), to_show)
	if(display_contents)
		return COMPONENT_NO_AFTERATTACK


/// Alt click on the storage item. Default: Open the storage.
/datum/storage/proc/on_click_alt(datum/source, mob/user)
	SIGNAL_HANDLER

	if(!click_alt_open)
		return

	return open_storage_on_signal(source, user)


/// Opens the storage to the mob, showing them the contents to their UI.
/datum/storage/proc/open_storage(mob/to_show, can_reach_target = parent) // NOVA EDIT ADDITION -- Original: /datum/storage/proc/open_storage(mob/to_show)
	if(isobserver(to_show))
		show_contents(to_show)
		return FALSE

	if(!to_show.CanReach(can_reach_target)) // NOVA EDIT ADDITION -- can_reach_target arg
		parent.balloon_alert(to_show, "can't reach!")
		return FALSE

	if(!isliving(to_show) || to_show.incapacitated())
		return FALSE

	if(locked)
		if(!silent)
			parent.balloon_alert(to_show, "closed!")
		return FALSE

	// If we're quickdrawing boys
	if(quickdraw && !to_show.get_active_held_item())
		var/obj/item/to_remove = locate() in real_location
		if(!to_remove)
			return TRUE

		remove_single(to_show, to_remove)
		INVOKE_ASYNC(src, PROC_REF(put_in_hands_async), to_show, to_remove)
		if(!silent)
			to_show.visible_message(
				span_warning("[to_show] draws [to_remove] from [parent]!"),
				span_notice("You draw [to_remove] from [parent]."),
			)
		return TRUE

	// If nothing else, then we want to open the thing, so do that
	if(!show_contents(to_show))
		return FALSE

	if(animated)
		animate_parent()

	if(rustle_sound)
		playsound(parent, SFX_RUSTLE, 50, TRUE, -5)

	return TRUE


/// Async version of putting something into a mobs hand.
/datum/storage/proc/put_in_hands_async(mob/toshow, obj/item/toremove)
	if(!toshow.put_in_hands(toremove))
		if(!silent)
			toremove.balloon_alert(toshow, "fumbled!")
		return TRUE

/// Signal handler for whenever a mob walks away with us, close if they can't reach us.
/datum/storage/proc/close_distance(datum/source)
	SIGNAL_HANDLER

	for(var/mob/user in can_see_contents())
		if (!user.CanReach(parent))
			hide_contents(user)

/// Close the storage UI for everyone viewing us.
/datum/storage/proc/close_all()
	for(var/mob/user in is_using)
		hide_contents(user)

/// Refresh the views of everyone currently viewing the storage.
/datum/storage/proc/refresh_views()
	for (var/mob/user in can_see_contents())
		show_contents(user)

/// Checks who is currently capable of viewing our storage (and is.)
/datum/storage/proc/can_see_contents()
	var/list/seeing = list()
	for (var/mob/user in is_using)
		if(user.active_storage == src && user.client)
			seeing += user
		else
			is_using -= user
	return seeing

/**
 * Show our storage to a mob.
 *
 * Arguments
 * * mob/toshow - the mob to show the storage to
 *
 * Returns
 * * FALSE if the show failed
 * * TRUE otherwise
 */
/datum/storage/proc/show_contents(mob/toshow)
	if(!toshow.client)
		return FALSE

	// You can only inspect hidden contents if you're an observer
	if(!isobserver(toshow) && !display_contents)
		return FALSE

	if(toshow.active_storage != src && (toshow.stat == CONSCIOUS))
		for(var/obj/item/thing in real_location)
			if(thing.on_found(toshow))
				toshow.active_storage.hide_contents(toshow)

	if(toshow.active_storage)
		toshow.active_storage.hide_contents(toshow)

	toshow.active_storage = src

	if(ismovable(real_location))
		var/atom/movable/movable_loc = real_location
		movable_loc.become_active_storage(src)

	orient_to_hud()

	is_using |= toshow

	toshow.client.screen |= boxes
	toshow.client.screen |= closer
	toshow.client.screen |= real_location.contents
	return TRUE

/**
 * Hide our storage from a mob.
 *
 * Arguments
 * * mob/toshow - the mob to hide the storage from
 */
/datum/storage/proc/hide_contents(mob/to_hide)
	if(!to_hide.client)
		return TRUE
	if(to_hide.active_storage == src)
		to_hide.active_storage = null

	if(!length(is_using) && ismovable(real_location))
		var/atom/movable/movable_loc = real_location
		movable_loc.lose_active_storage(src)

	is_using -= to_hide

	to_hide.client.screen -= boxes
	to_hide.client.screen -= closer
	to_hide.client.screen -= real_location.contents
	return TRUE

/datum/storage/proc/action_trigger(datum/source, datum/action/triggered)
	SIGNAL_HANDLER

	toggle_collection_mode(triggered.owner)

/datum/storage/proc/action_deleted(datum/source)
	SIGNAL_HANDLER

	modeswitch_action = null

/**
 * Toggles the collectmode of our storage.
 *
 * @param mob/toshow the mob toggling us
 */
/datum/storage/proc/toggle_collection_mode(mob/user)
	collection_mode = (collection_mode + 1) % 3
	switch(collection_mode)
		if(COLLECT_SAME)
			parent.balloon_alert(user, "will now only pick up a single type")
		if(COLLECT_EVERYTHING)
			parent.balloon_alert(user, "will now pick up everything")
		if(COLLECT_ONE)
			parent.balloon_alert(user, "will now pick up one at a time")

/// Gives a spiffy animation to our parent to represent opening and closing.
/datum/storage/proc/animate_parent(atom/target = parent) // NOVA EDIT ADDITION -- target arg
	var/matrix/old_matrix = target.transform // NOVA EDIT -- target var
	animate(target, time = 1.5, loop = 0, transform = target.transform.Scale(1.07, 0.9)) // NOVA EDIT -- target var
	animate(time = 2, transform = old_matrix)

/// Signal proc for [COMSIG_ATOM_CONTENTS_WEIGHT_CLASS_CHANGED] to drop items out of our storage if they're suddenly too heavy.
/datum/storage/proc/contents_changed_w_class(datum/source, obj/item/changed, old_w_class, new_w_class)
	SIGNAL_HANDLER

	if(new_w_class <= max_specific_storage && new_w_class + get_total_weight() <= max_total_storage)
		return
	if(!attempt_remove(changed, parent.drop_location()))
		return

	changed.visible_message(span_warning("[changed] falls out of [parent]!"), vision_distance = COMBAT_MESSAGE_RANGE)

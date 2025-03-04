/obj/item/reagent_containers/hypospray/medipen
	/// If TRUE, the medipen will initialize without reagents
	var/init_empty = FALSE
	/// If TRUE, indicates that the medipen hasn't been injected by a mob yet
	var/unused = TRUE

// Allows medipens to initialize without reagents if init_empty is TRUE
/obj/item/reagent_containers/hypospray/medipen/Initialize(mapload)
	if(init_empty != TRUE)
		return ..()

	// Temporarily sets list_reagents to null to avoid filling the medipen
	var/initial_reagents = list_reagents
	list_reagents = null
	. = ..()
	list_reagents = initial_reagents

	if(label_examine)
		var/reagent_types = assoc_to_keys(list_reagents)
		// Set label text via list_reagents, due to actual reagents being empty
		label_text = span_notice("There is a sticker pasted onto the side which reads, 'WARNING: This medipen contains [pretty_string_from_reagent_list(reagent_types, names_only = TRUE, join_text = ", ", final_and = TRUE, capitalize_names = TRUE)], do not use if allergic to any listed chemicals.")

// Sends a more generic chat message when an unused medipen is empty
/obj/item/reagent_containers/hypospray/medipen/inject(mob/living/affected_mob, mob/user)
	if(!reagents?.total_volume || (init_empty && used_up && unused))
		to_chat(user, span_warning("You push [src]'s button, but nothing happens. It's empty!"))
		return FALSE

	// Attempt the injection
	. = ..()

	// If the injection succeeded, then the medipen is not unused anymore
	if(unused && .)
		unused = FALSE

/obj/item/reagent_containers/hypospray/medipen/empty
	init_empty = TRUE
	used_up = TRUE

/obj/item/reagent_containers/hypospray/medipen/atropine/empty
	init_empty = TRUE
	used_up = TRUE

/obj/item/reagent_containers/hypospray/medipen/salbutamol/empty
	init_empty = TRUE
	used_up = TRUE

/obj/item/reagent_containers/hypospray/medipen/oxandrolone/empty
	init_empty = TRUE
	used_up = TRUE

/obj/item/reagent_containers/hypospray/medipen/salacid/empty
	init_empty = TRUE
	used_up = TRUE

/obj/item/reagent_containers/hypospray/medipen/penacid/empty
	init_empty = TRUE
	used_up = TRUE

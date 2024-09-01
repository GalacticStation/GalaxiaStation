/obj/machinery/medipen_refiller
	name = "Medipen Refiller"
	desc = "A machine that refills used medipens with chemicals."
	icon = 'icons/obj/machines/medipen_refiller.dmi'
	icon_state = "medipen_refiller"
	density = TRUE
	circuit = /obj/item/circuitboard/machine/medipen_refiller

	///List of medipen subtypes it can refill and the chems needed for it to work.
	var/static/list/allowed_pens = list(
		/obj/item/reagent_containers/hypospray/medipen = /datum/reagent/medicine/epinephrine,
		/obj/item/reagent_containers/hypospray/medipen/atropine = /datum/reagent/medicine/atropine,
		/obj/item/reagent_containers/hypospray/medipen/salbutamol = /datum/reagent/medicine/salbutamol,
		/obj/item/reagent_containers/hypospray/medipen/oxandrolone = /datum/reagent/medicine/oxandrolone,
		/obj/item/reagent_containers/hypospray/medipen/salacid = /datum/reagent/medicine/sal_acid,
		/obj/item/reagent_containers/hypospray/medipen/penacid = /datum/reagent/medicine/pen_acid,
		/obj/item/reagent_containers/hypospray/medipen/mutadone = /datum/reagent/medicine/mutadone,
		/obj/item/reagent_containers/hypospray/medipen/methamphetamine = /datum/reagent/drug/methamphetamine,
		/obj/item/reagent_containers/hypospray/medipen/survival = /datum/reagent/medicine/c2/libital,
		/obj/item/reagent_containers/hypospray/medipen/survival/luxury = /datum/reagent/medicine/c2/penthrite,
		/obj/item/reagent_containers/hypospray/medipen/invisibility = /datum/reagent/drug/saturnx,
		// NOVA EDIT ADDITION BEGIN - Universal medipens and lathe medipens
		/obj/item/reagent_containers/hypospray/medipen/universal = null,
		/obj/item/reagent_containers/hypospray/medipen/universal/lowpressure = null,
		/obj/item/reagent_containers/hypospray/medipen/empty = /datum/reagent/medicine/epinephrine,
		/obj/item/reagent_containers/hypospray/medipen/atropine/empty = /datum/reagent/medicine/atropine,
		/obj/item/reagent_containers/hypospray/medipen/salbutamol/empty = /datum/reagent/medicine/salbutamol,
		/obj/item/reagent_containers/hypospray/medipen/oxandrolone/empty = /datum/reagent/medicine/oxandrolone,
		/obj/item/reagent_containers/hypospray/medipen/salacid/empty = /datum/reagent/medicine/sal_acid,
		/obj/item/reagent_containers/hypospray/medipen/penacid/empty = /datum/reagent/medicine/pen_acid,
		// NOVA EDIT ADDITION END
	)

	// NOVA EDIT ADDITION BEGIN - Universal medipens
	///Whitelist typecache of reagent types which are allowed to refill universal medipens.
	var/static/list/medipen_reagent_whitelist = typecacheof(list(
		/datum/reagent/medicine,
		/datum/reagent/vaccine,
	))
	///Blacklist typecache of reagent types which are disallowed to refill universal medipens.
	var/static/list/medipen_reagent_blacklist = typecacheof(list(
		/datum/reagent/medicine/morphine,
	))
	// NOVA EDIT ADDITION END

/obj/machinery/medipen_refiller/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/plumbing/simple_demand)
	register_context()
	CheckParts()

/obj/machinery/medipen_refiller/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(held_item)
		if(held_item.tool_behaviour == TOOL_WRENCH)
			context[SCREENTIP_CONTEXT_LMB] = anchored ? "Unsecure" : "Secure"
		else if(held_item.tool_behaviour == TOOL_CROWBAR && panel_open)
			context[SCREENTIP_CONTEXT_LMB] = "Deconstruct"
		else if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
			context[SCREENTIP_CONTEXT_LMB] = panel_open ? "Close panel" : "Open panel"
		else if(is_reagent_container(held_item) && held_item.is_open_container())
			context[SCREENTIP_CONTEXT_LMB] = "Refill machine"
		// NOVA EDIT CHANGE - ORIGINAL: else if(istype(held_item, /obj/item/reagent_containers/hypospray/medipen) && reagents.has_reagent(allowed_pens[held_item.type]))
		else if(istype(held_item, /obj/item/reagent_containers/hypospray/medipen/universal) || istype(held_item, /obj/item/reagent_containers/hypospray/medipen) && reagents.has_reagent(allowed_pens[held_item.type]))
		// NOVA EDIT CHANGE END
			context[SCREENTIP_CONTEXT_LMB] = "Refill medipen"
		else if(istype(held_item, /obj/item/plunger))
			context[SCREENTIP_CONTEXT_LMB] = "Plunge machine"
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/medipen_refiller/RefreshParts()
	. = ..()
	var/new_volume = 100
	for(var/datum/stock_part/matter_bin/matter_bin in component_parts)
		new_volume += (100 * matter_bin.tier)
	if(!reagents)
		create_reagents(new_volume, TRANSPARENT)
	reagents.maximum_volume = new_volume
	return TRUE

/obj/machinery/medipen_refiller/attackby(obj/item/weapon, mob/user, params)
	if(DOING_INTERACTION(user, src))
		balloon_alert(user, "already interacting!")
		return
	if(is_reagent_container(weapon) && weapon.is_open_container())
		var/obj/item/reagent_containers/reagent_container = weapon
		if(!length(reagent_container.reagents.reagent_list))
			balloon_alert(user, "nothing to transfer!")
			return
		var/units = reagent_container.reagents.trans_to(src, reagent_container.amount_per_transfer_from_this, transferred_by = user)
		if(units)
			balloon_alert(user, "[units] units transferred")
		else
			balloon_alert(user, "reagent storage full!")
		return
	if(istype(weapon, /obj/item/reagent_containers/hypospray/medipen))
		var/obj/item/reagent_containers/hypospray/medipen/medipen = weapon
		if(!(LAZYFIND(allowed_pens, medipen.type)))
			balloon_alert(user, "medipen incompatible!")
			return
		if(medipen.reagents?.reagent_list.len)
			balloon_alert(user, "medipen full!")
			return
		// NOVA EDIT CHANGE - ORIGINAL: if(!reagents.has_reagent(allowed_pens[medipen.type], 10))
		if(!reagents.has_reagent(allowed_pens[medipen.type], medipen.volume))
			balloon_alert(user, "not enough reagents!")
			return
		add_overlay("active")
		if(do_after(user, 2 SECONDS, src))
			medipen.used_up = FALSE
			// NOVA EDIT ADDITION BEGIN - Universal medipen and lathe medipens
			if(istype(medipen, /obj/item/reagent_containers/hypospray/medipen/universal))
				// Ignore reagents which aren't the blacklist or whitelist
				var/list/datum/reagent/compatible_reagents = typecache_filter_multi_list_exclusion(reagents.reagent_list, medipen_reagent_whitelist, medipen_reagent_blacklist)
				// Ensure there is enough of the whitelisted reagents
				if(!length(compatible_reagents))
					balloon_alert(user, "reagents incompatible!")
					return
				// Create list of transferable reagent typepaths
				var/list/target_reagent_types = list()
				for(var/datum/reagent/target_reagent as anything in compatible_reagents)
					target_reagent_types += target_reagent.type
				// Transfer proportional amounts of each reagent
				reagents.trans_to_multiple(target_atom = medipen, amount = medipen.volume, target_ids = target_reagent_types)
			else
			// NOVA EDIT ADDITION END
			// NOVA EDIT CHANGE BEGIN - Universal medipen and lathe medipens
				medipen.add_initial_reagents()
				// NOVA EDIT CHANGE - ORIGINAL: reagents.remove_reagent(allowed_pens[medipen.type], 10)
				reagents.remove_reagent(allowed_pens[medipen.type], medipen.volume)
			// NOVA EDIT CHANGE END
			balloon_alert(user, "refilled")
			use_energy(active_power_usage)
		cut_overlays()
		return
	return ..()

/obj/machinery/medipen_refiller/plunger_act(obj/item/plunger/P, mob/living/user, reinforced)
	user.balloon_alert_to_viewers("furiously plunging...", "plunging medipen refiller...")
	if(do_after(user, 3 SECONDS, target = src))
		user.balloon_alert_to_viewers("finished plunging")
		reagents.expose(get_turf(src), TOUCH)
		reagents.clear_reagents()

/obj/machinery/medipen_refiller/wrench_act(mob/living/user, obj/item/tool)
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/medipen_refiller/crowbar_act(mob/living/user, obj/item/tool)
	default_deconstruction_crowbar(tool)
	return TRUE

/obj/machinery/medipen_refiller/screwdriver_act(mob/living/user, obj/item/tool)
	return default_deconstruction_screwdriver(user, "[initial(icon_state)]_open", initial(icon_state), tool)

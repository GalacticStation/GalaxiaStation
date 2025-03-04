/obj/item/reagent_containers/hypospray/medipen/universal
	name = "universal medipen"
	article = "a"
	desc = "It's an auto-injecting syringe with a universal refill port on the side."
	icon = 'modular_nova/modules/lathe_medipens/icons/syringe.dmi'
	lefthand_file = 'modular_nova/modules/lathe_medipens/icons/medical_lefthand.dmi'
	righthand_file = 'modular_nova/modules/lathe_medipens/icons//medical_righthand.dmi'
	icon_state = "medipen_blue_unused"
	base_icon_state = "medipen_blue"
	inhand_icon_state = "medipen_blue"
	reagent_flags = TRANSPARENT
	list_reagents = null
	label_examine = FALSE
	used_up = TRUE
	init_empty = TRUE

/obj/item/reagent_containers/hypospray/medipen/universal/update_overlays()
	. = ..()
	var/list/reagent_overlays = update_reagent_overlay()
	if(reagent_overlays)
		. += reagent_overlays

/// Returns a list of overlays to add that relate to the reagents inside the syringe
/obj/item/reagent_containers/hypospray/medipen/universal/proc/update_reagent_overlay()
	if(!reagents?.total_volume)
		return
	var/mutable_appearance/filling_overlay = mutable_appearance('modular_nova/modules/lathe_medipens/icons/reagent_fillings.dmi', "medipen")
	filling_overlay.color = mix_color_from_reagents(reagents.reagent_list)
	. += filling_overlay

/obj/item/reagent_containers/hypospray/medipen/universal/inject(mob/living/affected_mob, mob/user)
	. = ..()
	if(. && used_up)
		// Workaround to reset reagent flags after injection (gets set to 0 by parent proc)
		reagents.flags = reagent_flags

/obj/item/reagent_containers/hypospray/medipen/universal/lowpressure
	name = "universal low-pressure medipen"
	desc = "It's a low-pressure auto-injecting syringe with a universal refill port on the side. WARNING: This device is designed to be operated in low-pressure environments only."
	icon_state = "medipen_red_unused"
	base_icon_state = "medipen_red"
	inhand_icon_state = "medipen_red"
	volume = 30
	amount_per_transfer_from_this = 30

/obj/item/reagent_containers/hypospray/medipen/universal/lowpressure/update_icon_state()
	. = ..()
	if(reagents?.total_volume == 0)
		icon_state = "[base_icon_state]0"
	else if(reagents?.total_volume > (volume * 0.5))
		icon_state = base_icon_state
	else
		icon_state = "[base_icon_state]15"

/// Returns a list of overlays to add that relate to the reagents inside the syringe
/obj/item/reagent_containers/hypospray/medipen/universal/lowpressure/update_reagent_overlay()
	if(!reagents?.total_volume)
		return
	var/overlay_icon = "medipen"
	if(reagents?.total_volume <= (volume * 0.5))
		overlay_icon = "medipen_half"
	var/mutable_appearance/filling_overlay = mutable_appearance('modular_nova/modules/lathe_medipens/icons/reagent_fillings.dmi', overlay_icon)
	filling_overlay.color = mix_color_from_reagents(reagents.reagent_list)
	. += filling_overlay

/obj/item/reagent_containers/hypospray/medipen/universal/lowpressure/inject(mob/living/affected_mob, mob/user)
	// Calculate quantity to inject, depending on if the user is on lavaland.
	if(lavaland_equipment_pressure_check(get_turf(user)))
		amount_per_transfer_from_this = initial(amount_per_transfer_from_this)
	else
		if(DOING_INTERACTION(user, DOAFTER_SOURCE_SURVIVALPEN))
			to_chat(user,span_notice("You are too busy to use \the [src]!"))
			return

		to_chat(user,span_notice("You start manually releasing the low-pressure gauge..."))
		if(!do_after(user, 10 SECONDS, affected_mob, interaction_key = DOAFTER_SOURCE_SURVIVALPEN))
			return

		amount_per_transfer_from_this = initial(amount_per_transfer_from_this) * 0.5

	// Attempt the injection
	. = ..()
	// Workaround to update icon and overlay after partial injection
	if(. && !used_up)
		update_appearance()

// Re-labels TG brainproblems to be more generic. There never was a tumor anyways!
/datum/quirk/item_quirk/brainproblems
	name = "Brain Degeneration"
	desc = "You have a lethal condition in your brain that is slowly destroying it. Better bring some mannitol!"
	medical_record_text = "Patient has a lethal condition in their brain that is slowly causing brain death."
	icon = FA_ICON_BRAIN

// Override of Brain Tumor quirk for species with artificial brains.
// Does not appear in TGUI or the character preferences window.
/datum/quirk/item_quirk/brainproblems/synth
	gain_text = "<span class='danger'>You feel glitchy.</span>"
	lose_text = "<span class='notice'>You no longer feel glitchy.</span>"
	icon = FA_ICON_BRAZILIAN_REAL_SIGN
	mail_goodies = list(/obj/item/storage/pill_bottle/liquid_solder/braintumor)
	hidden_quirk = TRUE

/datum/quirk/item_quirk/brainproblems/synth/add()
	. = ..()
	var/obj/item/organ/brain/synth/synth_brain = quirk_holder.get_organ_slot(ORGAN_SLOT_BRAIN)
	medical_record_text = "Patient has a malfunction in their [synth_brain] that is slowly causing brain death."
	switch(synth_brain.type)
		if(/obj/item/organ/brain/synth)
			name = "Positronic Cascade Anomaly"
		if(/obj/item/organ/brain/synth/mmi)
			name = "Interface Rejection Syndrome"
		if(/obj/item/organ/brain/synth/circuit)
			name = "Processor Firmware Bug"

// If brainproblems is added to a synth, this detours to the brainproblems/synth quirk.
/datum/quirk/item_quirk/brainproblems/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source)
	var/obj/item/organ/brain/synth/synth_brain = new_holder.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!istype(synth_brain) || type != /datum/quirk/item_quirk/brainproblems)
		// Defer to TG brainproblems if the character's brain isn't robotic.
		return ..()

	var/datum/quirk/item_quirk/brainproblems/synth/bp_synth = new
	qdel(src)
	return bp_synth.add_to_holder(new_holder, quirk_transfer, client_source)

// Synthetics get liquid_solder with Brain Tumor instead of mannitol.
/datum/quirk/item_quirk/brainproblems/synth/add_unique(client/client_source)
	give_item_to_holder(
		/obj/item/storage/pill_bottle/liquid_solder/braintumor,
		list(
			LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
			LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
			LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
			LOCATION_HANDS = ITEM_SLOT_HANDS,
		),
		flavour_text = "These will keep you alive until you can secure a supply of medication. Don't rely on them too much!",
	)

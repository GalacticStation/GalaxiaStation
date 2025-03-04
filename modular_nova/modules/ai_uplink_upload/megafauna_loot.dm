/obj/item/organ/brain/cybernetic/ai
	/// Nova addition. Slots to ignore in check for organic organs. Used to bypass things that do not have ORGAN_EXTERNAL flag, since
	/// not all of actual external organs have it. Better to double check in case someone messes up with flags or something.
	var/list/ignored_organ_slots = list(
		ORGAN_SLOT_EXTERNAL_CAP,
		ORGAN_SLOT_EXTERNAL_FLUFF,
		ORGAN_SLOT_EXTERNAL_FRILLS,
		ORGAN_SLOT_EXTERNAL_HEAD_ACCESSORY,
		ORGAN_SLOT_EXTERNAL_HORNS,
		ORGAN_SLOT_EXTERNAL_MOTH_MARKINGS,
		ORGAN_SLOT_EXTERNAL_NECK_ACCESSORY,
		ORGAN_SLOT_EXTERNAL_POD_HAIR,
		ORGAN_SLOT_EXTERNAL_SKRELL_HAIR,
		ORGAN_SLOT_EXTERNAL_SYNTH_ANTENNA,
		ORGAN_SLOT_EXTERNAL_SYNTH_SCREEN,
		ORGAN_SLOT_EXTERNAL_TAUR,
		ORGAN_SLOT_EXTERNAL_XENODORSAL,
		ORGAN_SLOT_EXTERNAL_XENOHEAD,
		ORGAN_SLOT_EXTERNAL_TAIL,
		ORGAN_SLOT_EXTERNAL_SPINES,
		ORGAN_SLOT_EXTERNAL_SNOUT,
		ORGAN_SLOT_EXTERNAL_FRILLS,
		ORGAN_SLOT_EXTERNAL_HORNS,
		ORGAN_SLOT_EXTERNAL_WINGS,
		ORGAN_SLOT_EXTERNAL_ANTENNAE,
		ORGAN_SLOT_EXTERNAL_POD_HAIR,
	)

/obj/item/organ/brain/cybernetic/ai/Initialize(mapload)
	desc += " P.S. External organs such as tails, snouts, etc still work fine."
	organ_traits += TRAIT_SILICON_EMOTES_ALLOWED
	return ..()

/obj/item/clothing/under/syndicate/nova/overalls/unarmoured
	name = "utility overalls turtleneck"
	desc = "A pair of spiffy overalls with a turtleneck underneath, useful for both engineering and botanical work."
	icon_state = "syndicate_overalls"
	armor_type = /datum/armor/clothing_under/none
	has_sensor = HAS_SENSORS
	can_adjust = TRUE

/datum/loadout_item/under/miscellaneous/syndicate_nova_overalls_unarmoured
	name = "Tacticool Utility Overalls Turtleneck"
	item_path = /obj/item/clothing/under/syndicate/nova/overalls/unarmoured

/obj/item/clothing/under/syndicate/nova/overalls/unarmoured/skirt
	name = "utility overalls skirtleneck"
	desc = "A pair of spiffy overalls with a turtleneck underneath, this one is a skirt instead, breezy."
	icon_state = "syndicate_overallskirt"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/datum/loadout_item/under/miscellaneous/syndicate_nova_overalls_unarmoured_skirt
	name = "Tacticool Overalls Skirtleneck"
	item_path = /obj/item/clothing/under/syndicate/nova/overalls/unarmoured/skirt

/obj/item/clothing/mask/gas/sechailer/half_mask
	name = "tacticool neck gaiter"
	desc = "A black techwear mask. Its low-profile design contrasts with the edge. Has a small respirator to be used with internals."
	actions_types = list(/datum/action/item_action/adjust)
	alternate_worn_layer = BODY_FRONT_UNDER_CLOTHES
	icon_state = "half_mask"
	icon = 'modular_nova/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/mask.dmi'
	unique_death = 'modular_nova/master_files/sound/effects/hacked.ogg'
	voice_filter = null
	use_radio_beeps_tts = FALSE

/datum/loadout_item/mask/sechailer_half_mask
	name = "Tacticool Neck Gaiter"
	item_path = /obj/item/clothing/mask/gas/sechailer/half_mask

/datum/outfit/sapper
	name = "Space Sapper"

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/sapper

	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/sapper
	belt = /obj/item/storage/belt/utility/sapper
	gloves = /obj/item/clothing/gloves/color/yellow
	shoes = /obj/item/clothing/shoes/workboots/sapper

	box = /obj/item/storage/box/survival/engineer
	back = /obj/item/storage/toolbox/guncase/nova/carwo_large_case/sapper
	backpack_contents = list(
		/obj/item/storage/backpack/satchel/flat/empty =1,
		/obj/item/grenade/chem_grenade/metalfoam = 1,
		/obj/item/stack/cable_coil/thirty = 1,
		/obj/item/fireaxe = 1,
		)

	l_pocket = /obj/item/paper/fluff/sapper_intro
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	skillchips = list(/obj/item/skillchip/job/engineer)

/datum/outfit/sapper/pre_equip(mob/living/carbon/human/equipped)
	if(equipped.jumpsuit_style == PREF_SKIRT)
		uniform = /obj/item/clothing/under/sapper/skirt

/datum/outfit/sapper/post_equip(mob/living/carbon/human/equipped)
	equipped.faction |= FACTION_SAPPER

	var/obj/item/radio/outfit_radio = equipped.ears
	if(outfit_radio)
		outfit_radio.keyslot = new /obj/item/encryptionkey/syndicate()
		outfit_radio.set_frequency(FREQ_SYNDICATE)

	var/obj/item/card/id/outfit_id = equipped.wear_id
	if(outfit_id)
		outfit_id.registered_name = equipped.real_name
		outfit_id.update_label()
		outfit_id.update_icon()

	var/obj/item/clothing/under/outfit_uniform = equipped.w_uniform
	if(outfit_uniform)
		outfit_uniform.has_sensor = NO_SENSORS
		outfit_uniform.sensor_mode = SENSOR_OFF
		equipped.update_suit_sensors()

	SSquirks.AssignQuirks(equipped, equipped.client, TRUE, TRUE, null, FALSE, equipped)


/obj/item/clothing/mask/gas/atmos/sapper
	name = "\improper Sapper gas mask"
	desc = "A modified black gas mask with a yellow painted bottom and digitally expressive eyes, its framing is <b>laser-reflective</b>."
	icon = 'modular_nova/modules/sapper_gang/sapper_obj.dmi'
	icon_state = "mask_one"
	worn_icon = 'modular_nova/modules/sapper_gang/sapper.dmi'
	var/hit_reflect_chance = 35

/obj/item/clothing/mask/gas/atmos/sapper/partner
	icon_state = "mask_two"

/obj/item/clothing/mask/gas/atmos/sapper/IsReflect(def_zone)
	if(def_zone in list(BODY_ZONE_HEAD))
		return FALSE
	if (prob(hit_reflect_chance))
		return TRUE

/obj/item/clothing/under/sapper
	name = "\improper Sapper slacks"
	desc = "A sleek black jacket with <b>laser-reflective</b> 'heatsilk' lining and a high-visibility pair of slacks, comfortable, safe, efficient."
	icon = 'modular_nova/modules/sapper_gang/sapper_obj.dmi'
	icon_state = "suit_pants"
	worn_icon = 'modular_nova/modules/sapper_gang/sapper.dmi'
	inhand_icon_state = "engi_suit"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	has_sensor = NO_SENSORS
	armor_type = /datum/armor/clothing_under/rank_security
	can_adjust = FALSE
	var/hit_reflect_chance = 55

/obj/item/clothing/under/sapper/sapper/IsReflect(def_zone)
	if(!(def_zone in list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)))
		return FALSE
	if (prob(hit_reflect_chance))
		return TRUE

/obj/item/clothing/under/sapper/skirt
	name = "\improper Sapper skirt"
	desc = "A sleek black jacket with <b>laser-reflective</b> 'heatsilk' lining and a high-visibility skirt, comfortable, safe, efficient."
	icon_state = "suit_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/shoes/workboots/sapper
	name = "black work boots"
	desc = "Lace-up steel-tipped shiny black workboots, nothing can get through these."
	icon = 'modular_nova/modules/sapper_gang/sapper_obj.dmi'
	icon_state = "boots"
	worn_icon = 'modular_nova/modules/sapper_gang/sapper.dmi'
	inhand_icon_state = "jackboots"
	armor_type = /datum/armor/shoes_combat

/obj/item/clothing/shoes/workboots/sapper/Initialize(mapload)
	. = ..()
	contents += new /obj/item/screwdriver

/obj/item/storage/belt/utility/sapper
	name = "black toolbelt"
	desc = "A tactical toolbelt, what makes it tactical? The color."
	icon = 'modular_nova/modules/sapper_gang/sapper_obj.dmi'
	icon_state = "belt"
	worn_icon = 'modular_nova/modules/sapper_gang/sapper.dmi'
	inhand_icon_state = "security"
	worn_icon_state = "belt"
	preload = FALSE

/obj/item/storage/belt/utility/sapper/PopulateContents() //its just a complete mishmash
	new /obj/item/forcefield_projector(src)
	new /obj/item/multitool(src)
	new /obj/item/wrench/combat(src)
	new /obj/item/construction/rcd(src)
	new /obj/item/screwdriver/caravan(src)
	new /obj/item/inducer/syndicate(src)
	new /obj/item/weldingtool/abductor(src)

/obj/item/storage/toolbox/guncase/nova/carwo_large_case/sapper
	name = "compact tool case"
	desc = "A wide yellow tool case with foam inserts laid out to fit a fire axe, tools, cable coils and even grenades."

/obj/item/storage/toolbox/guncase/nova/carwo_large_case/sapper/PopulateContents()
	return


/datum/id_trim/sapper
	assignment = "Sapper"
	trim_state = "trim_sapper"
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	department_color = COLOR_ORANGE
	subdepartment_color = COLOR_ORANGE
	sechud_icon_state = SECHUD_SAPPER
	access = list(ACCESS_SAPPER_SHIP)
	threat_modifier = 2

/datum/job/space_sapper
	title = ROLE_SPACE_SAPPER
	policy_index = ROLE_SPACE_SAPPER

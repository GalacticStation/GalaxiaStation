/datum/job/blueshield
	title = JOB_BLUESHIELD
	description = "Protect heads of staff, get your fancy gun stolen, cry as the captain touches the supermatter."
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list(JOB_NT_REP)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "Central Command and the Nanotrasen Consultant"
	minimal_player_age = 7
	exp_requirements = 2400
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_COMMAND
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "BLUESHIELD"

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_CMD

	outfit = /datum/outfit/job/blueshield
	plasmaman_outfit = /datum/outfit/plasmaman/blueshield
	display_order = JOB_DISPLAY_ORDER_BLUESHIELD
	bounty_types = CIV_JOB_SEC

	department_for_prefs = /datum/job_department/captain

	departments_list = list(
		/datum/job_department/central_command,
		/datum/job_department/command,
	)
	liver_traits = list(TRAIT_PRETENDER_ROYAL_METABOLISM)

	family_heirlooms = list(/obj/item/bedsheet/captain, /obj/item/clothing/head/beret/blueshield)

	mail_goodies = list(
		/obj/item/storage/fancy/cigarettes/cigars/havana = 10,
		/obj/item/stack/spacecash/c500 = 3,
		/obj/item/disk/nuclear/fake/obvious = 2,
		/obj/item/clothing/head/collectable/captain = 4,
	)

	veteran_only = TRUE
	job_flags = STATION_JOB_FLAGS | JOB_CANNOT_OPEN_SLOTS

/datum/outfit/job/blueshield
	name = "Blueshield"
	jobtype = /datum/job/blueshield
	uniform = /obj/item/clothing/under/rank/blueshield
	suit = /obj/item/clothing/suit/armor/vest/blueshield/jacket
	gloves = /obj/item/clothing/gloves/tackler/security
	id = /obj/item/card/id/advanced/centcom/station
	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/headset_bs/alt
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	implants = list(/obj/item/implant/mindshield)
	backpack_contents = list(
		/obj/item/choice_beacon/blueshield = 1,
	)
	backpack = /obj/item/storage/backpack/blueshield
	satchel = /obj/item/storage/backpack/satchel/blueshield
	duffelbag = /obj/item/storage/backpack/duffelbag/blueshield
	messenger = /obj/item/storage/backpack/messenger/blueshield

	head = /obj/item/clothing/head/beret/blueshield
	box = /obj/item/storage/box/survival/security
	belt = /obj/item/modular_computer/pda/security
	l_pocket = /obj/item/sensor_device/blueshield

	id_trim = /datum/id_trim/job/blueshield

/datum/outfit/plasmaman/blueshield
	name = "Blueshield Plasmaman"

	head = /obj/item/clothing/head/helmet/space/plasmaman/blueshield
	uniform = /obj/item/clothing/under/plasmaman/blueshield

/*
	Blueshield's Hellfire is between SC-1 and the Hellfire in terms of Damage and wound output
*/

/// Blueshield's Custom Hellfire
/obj/item/ammo_casing/energy/laser/hellfire/blueshield
	projectile_type = /obj/projectile/beam/laser/hellfire
	e_cost = LASER_SHOTS(13, STANDARD_CELL_CHARGE)
	select_name = "maim"

/obj/item/gun/energy/laser/hellgun/blueshield
	name ="modified hellfire laser gun"
	desc = "A lightly overtuned version of NT's Hellfire Laser rifle, scratches showing its age and the fact it has definitely been owned before. This one is more energy efficient without sacrificing damage."
	icon_state = "hellgun"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hellfire/blueshield)

/obj/item/choice_beacon/blueshield
	name = "Weaponry beacon"
	desc = "A single use beacon to deliver a weapon or set of your choice. Please only call this in your office!"

	icon_state = "cc_becon"
	inhand_icon_state = "cc_becon"
	icon = 'modular_nova/modules/modular_items/icons/remote.dmi'
	lefthand_file = 'modular_nova/modules/modular_items/icons/inhand/mobs/lefthand_remote.dmi'
	righthand_file = 'modular_nova/modules/modular_items/icons/inhand/mobs/righthand_remote.dmi'
	company_source = "Nanotrasen Rapid Equipment Deployment Division"
	company_message = span_bold("Supply Pod incoming, please stand by.")

/obj/item/choice_beacon/blueshield/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"Takbok Revolver Set" = /obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/takbok,
		"Custom Hellfire Laser Rifle" = /obj/item/gun/energy/laser/hellgun/blueshield,
		"NT20 Submachinegun Gunset" = /obj/item/storage/toolbox/guncase/nova/nt20,
		"NT Energy Blade" = /obj/item/melee/energy/nova/blueshieldsword,
	)

	return selectable_gun_types

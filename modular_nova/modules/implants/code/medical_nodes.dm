/datum/techweb_node/cyber/cyber_implants/New()
	design_ids += list(
		"ci-scanner",
		"ci-gloweyes",
		"ci-welding",
		"ci-medhud",
		"ci-sechud",
		"ci-diaghud",
		"ci-botany",
		"ci-janitor",
		"ci-lighter",
		"ci-razor",
		"ci-drill",
		"combat_implant_sandy",
		"combat_implant_hackerman",
		"combat_implant_razorwire",
		"combat_implant_shell_launcher",
	)
	// thrusters in combat_implants
	design_ids -= list(
		"ci-thrusters",
	)
	return ..()

/datum/techweb_node/cyber/combat_implants/New()
	design_ids += list(
		"ci-mantis",
		"ci-flash",
		"ci-thrusters",
		"ci-antisleep",
	)
	return ..()

/datum/techweb_node/cyber/night_vision_implants
	id = "nv_implants"
	display_name = "Night vision implants"
	description = "Now you can work all night, even if you lost your glasses!"
	prereq_ids = list("night_vision", "cyber_implants")
	design_ids = list(
		"ci-nv",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/mining_adv/New() //Here for the integrated drill augments.
	design_ids = list(
		"ci-drill-diamond"
	)
	return ..()

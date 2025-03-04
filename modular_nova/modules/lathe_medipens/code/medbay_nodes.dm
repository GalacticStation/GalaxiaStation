/datum/techweb_node/medbay_medipens
	id = TECHWEB_NODE_MEDBAY_MEDIPENS
	display_name = "Auto-Injecting 'Medipen' Syringes"
	description = "Advanced auto-injecting syringes, or 'medipens'. Used for automatically injecting medications."
	prereq_ids = list(TECHWEB_NODE_CHEM_SYNTHESIS)
	design_ids = list(
		"medipen_universal",
		"medipen_universal_lowpressure",
		"medipen_epinephrine",
		"medipen_atropine",
		"medipen_salbutamol",
		"medipen_oxandrolone",
		"medipen_salacid",
		"medipen_penacid",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

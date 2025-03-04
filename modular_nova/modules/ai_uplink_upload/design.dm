/datum/design/ai_uplink_upload
	name = "AI Uplink Brain"
	desc = "A synthetic brain with capability to let AI control bodies directly."
	id = "ai_uplink_brain"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/brain/cybernetic/ai
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_UPGRADES,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

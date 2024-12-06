/obj/item/ammo_box/magazine/kineticball
	name = "kinetic ball pistol magazine"
	desc = "A gun magazine filled with balls. The kind that makes makes people stop, holds eight rounds."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/bolt_fabrications/type207magazine.dmi'
	icon_state = "type207mag"
	ammo_type = /obj/item/ammo_casing/kineticball
	caliber = CALIBER_KINETICBALL
	max_ammo = 8
	custom_price = PAYCHECK_CREW * 2
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/kineticball/starts_empty
	start_empty = TRUE

/datum/design/kineticballs
	name = "Kinetic Ammo Box"
	id = "kineticballs"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/ammo_box/advanced/kineticballs
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/obj/item/ammo_box/advanced/kineticballs
	name = "kinetic ammo box"
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/bolt_fabrications/stingstopbox.dmi'
	icon_state = "stingstopbox"
	desc = "A box of kinetic balls rounds, holds twenty seven rounds."
	custom_price = PAYCHECK_CREW * 2
	ammo_type = /obj/item/ammo_casing/kineticball
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2,
	)
	max_ammo = 27

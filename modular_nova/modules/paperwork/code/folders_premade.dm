/obj/item/folder/cargo_contract
	name = "folder- 'NT-Cargo Cargo Agreement'"
	desc = "A folder stamped \"Nanotrasen - Generic Cargo Company Agreement. Unauthorized distribution or attempted alteration is punishable financially.\""
	bg_color = "#b88f3d"
	icon_state = "folder_byellow"
	icon = 'modular_nova/modules/paperwork/icons/bureaucracy.dmi'

/obj/item/folder/cargo_contract/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/folder/cargo_contract/old
	name = "folder- 'NT-FTU Cargo Agreement'"
	desc = "A folder stamped \"Nanotrasen - Free Trade Union Company Agreement. Unauthorized distribution or attempted alteration is punishable financially.\""
	bg_color = "#355e9f"
	icon_state = "folder_cblue"

/obj/item/folder/cargo_contract/old/Initialize(mapload)
	. = ..()
	new /obj/item/paper/lore/cargo_old/p00(src)
	new /obj/item/paper/lore/cargo_old/p01(src)
	new /obj/item/paper/lore/cargo_old/p02(src)
	new /obj/item/paper/lore/cargo_old/p03(src)
	new /obj/item/paper/lore/cargo_old/p04(src)
	new /obj/item/paper/lore/cargo_old/p05(src)
	new /obj/item/paper/lore/cargo_old/p06(src)
	new /obj/item/paper/lore/cargo_old/p07(src)
	new /obj/item/paper/lore/cargo_old/p08(src)
	new /obj/item/paper/lore/cargo_old/p09(src)
	new /obj/item/paper/lore/cargo_old/p10(src)
	new /obj/item/paper/lore/cargo_old/p11(src)
	update_appearance()

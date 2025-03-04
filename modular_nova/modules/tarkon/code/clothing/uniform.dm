/obj/item/clothing/under/tarkon
	name = "tarkon general uniform"
	desc = "A uniform worn by civilian-ranked crew, provided by Tarkon Industries."
	icon = 'modular_nova/modules/tarkon/icons/obj/clothing/uniform.dmi'
	worn_icon = 'modular_nova/modules/tarkon/icons/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_nova/modules/tarkon/icons/mob/clothing/uniform_digi.dmi'
	icon_state = "tarkon"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS
	armor_type = /datum/armor/clothing_under/tarkon
	greyscale_config = /datum/greyscale_config/tarkonuniform
	greyscale_config_worn = /datum/greyscale_config/tarkonuniform/worn
	greyscale_config_worn_digi = /datum/greyscale_config/tarkonuniform/worn/digi

/obj/item/clothing/under/tarkon/cargo
	name = "tarkon cargo uniform"
	desc = "A uniform worn by cargo-ranked crew, provided by Tarkon Industries."
	icon_state = "tarkon_recolor"
	greyscale_colors = "#B7793D#ffffff"

/obj/item/clothing/under/tarkon/sci
	name = "tarkon research uniform"
	desc = "A uniform worn by research-ranked crew, provided by Tarkon Industries."
	icon_state = "tarkon_recolor"
	greyscale_colors = "#9E00EA#ffffff"

/obj/item/clothing/under/tarkon/sec
	name = "tarkon guard uniform"
	desc = "A uniform worn by security-ranked crew, provided by Tarkon Industries."
	icon_state = "tarkon_recolor"
	armor_type = /datum/armor/clothing_under/tarkon
	greyscale_colors = "#B72B2F#ffffff"

/obj/item/clothing/under/tarkon/med
	name = "tarkon medical uniform"
	desc = "A uniform worn by medical-ranked crew, provided by Tarkon Industries."
	icon_state = "tarkon_recolor"
	greyscale_colors = "#85C1E6#ffffff"

/obj/item/clothing/under/tarkon/eng
	name = "tarkon maintenance uniform"
	desc = "A uniform worn by maintenance-ranked crew, provided by Tarkon Industries."
	icon_state = "tarkon_recolor"
	greyscale_colors = "#ff9900#ffffff"

/obj/item/clothing/under/tarkon/com
	name = "tarkon command uniform"
	desc = "A uniform worn by command-ranked crew, provided by Tarkon Industries."
	icon_state = "tarkon_recolor"
	armor_type = /datum/armor/clothing_under/tarkon
	greyscale_colors = "#3F6E9E#ffffff"

/datum/armor/clothing_under/tarkon
	melee = 10
	fire = 50
	acid = 50
	wound = 10

// Sabres, including the cargo variety

/obj/item/storage/belt/sabre/cargo
	name = "authentic shamshir leather sheath"
	desc = "A good-looking sheath that is advertised as being made of real Venusian black leather. It feels rather plastic-like to the touch, and it looks like it's made to fit a British cavalry sabre."
	icon = 'modular_nova/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/belt.dmi'

/obj/item/storage/belt/sabre/cargo/PopulateContents()
	new /obj/item/melee/sabre/cargo(src)
	update_appearance()

/obj/item/melee/sabre
	force = 20 // Original: 15
	wound_bonus = 5 // Original: 10
	bare_wound_bonus = 20 // Original: 25 Both down slightly, to make up for the damage buff, since it'd get a bit wacky ontop of the armor pen.

/obj/item/melee/sabre/cargo
	name = "authentic shamshir sabre"
	desc = "An expertly crafted historical human sword once used by the Persians which has recently gained traction due to Venusian historal recreation sports. One small flaw, the Taj-based company who produces these has mistaken them for British cavalry sabres akin to those used by high ranking Nanotrasen officials. Atleast it cuts the same way!"
	icon_state = "sabre"
	icon = 'modular_nova/modules/modular_weapons/icons/obj/melee.dmi'
	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/inhands/weapons/swords_righthand.dmi'
	block_chance = 20
	armour_penetration = 25


/obj/item/melee/energy/nova/blueshieldsword
	name = "\improper Blueshield energy blade"
	desc = "A specialized sword built and designed not for comfort but utility for usage amongst members within the Central Command Blueshield division."
	icon_state = "bs_esword"
	icon = 'modular_nova/modules/modular_weapons/icons/obj/melee.dmi'
	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/inhands/weapons/swords_righthand.dmi'
	hitsound = SFX_SWING_HIT
	force = 3
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	block_chance = 20
	armour_penetration = 25

// This is here so that people can't buy the Sabres and craft them into powercrepes
/datum/crafting_recipe/food/powercrepe
	blacklist = list(/obj/item/melee/sabre/cargo)

/obj/item/melee/baton
	/// For use with jousting. For each usable jousting tile, increase the stamina damage of the jousting hit by this much.
	var/stamina_damage_per_jousting_tile = 2

/obj/item/melee/baton/Initialize(mapload)
	. = ..()

	add_jousting_component()

/// Component adder proc for custom behavior, without needing to add more vars.
/obj/item/melee/baton/proc/add_jousting_component()
	AddComponent(/datum/component/jousting, damage_boost_per_tile = 0, knockdown_chance_per_tile = 6)

/// For jousting. Called when a joust is considered successfully done.
/obj/item/melee/baton/proc/on_successful_joust(mob/living/target, mob/user, usable_charge)
	target.apply_damage(stamina_damage_per_jousting_tile * usable_charge, STAMINA)

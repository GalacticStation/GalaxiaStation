// Rapid firing scary military grade weapon firing .27-54 Cesarzowa

/obj/item/gun/ballistic/automatic/miecz
	name = "\improper Miecz Support Weapon"
	desc = "A short barrel weapon riding the line between submachine gun and a rifle. \
		Features plasticized furniture and a maintenance manual in the stock... \
		Which just doesn't seem to come out no matter how hard you pull."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_48.dmi'
	icon_state = "miecz"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	inhand_icon_state = "miecz"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	worn_icon_state = "miecz"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_righthand.dmi'
	inhand_icon_state = "miecz"

	SET_BASE_PIXEL(-8, 0)

	special_mags = FALSE

	bolt_type = BOLT_TYPE_STANDARD

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BELT // we keeping this for the VIBE

	accepted_magazine_type = /obj/item/ammo_box/magazine/miecz

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/csgo_ak_shoot.ogg'
	can_suppress = TRUE
	suppressor_x_offset = 5
	suppressor_y_offset = 3

	burst_size = 1
	fire_delay = 3.5
	actions_types = list()

	spread = 1
	recoil = 0.5

/obj/item/gun/ballistic/automatic/miecz/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/miecz/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/miecz/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/miecz/examine_more(mob/user)
	. = ..()

	. += "The Miecz is one of the staple weapons of the frontier; simple, effective, and based on \
		a figuratively 'tested' design, (though you couldn't be sure which one that is). \
		Fires the .27-54 'intermediary' caliber round, if only to dodge its classification as a rifle. \
		Overall, it's decently accurate, lightweight, reeks of gun-grease,  \
		and might feel a little more homely then the next gun over... or, at least that's what the label says. \
		The Wood-Substitute material is known to have various side-effects, please contact your local health department before use."

/obj/item/gun/ballistic/automatic/miecz/no_mag
	spawnwithmagazine = FALSE

// Semi-automatic rifle firing .310 with reduced damage compared to a Sakhno

/obj/item/gun/ballistic/automatic/lanca
	name = "\improper Lanca Battle Rifle"
	desc = "A relatively compact, long barreled battle rifle chambered for .310 Strilka. Has an integrated sight with \
		a surprisingly functional amount of magnification, given its place of origin."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_48.dmi'
	icon_state = "lanca"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	worn_icon_state = "lanca"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_righthand.dmi'
	inhand_icon_state = "lanca"

	SET_BASE_PIXEL(-8, 0)

	special_mags = FALSE

	bolt_type = BOLT_TYPE_STANDARD

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK

	accepted_magazine_type = /obj/item/ammo_box/magazine/lanca

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/battle_rifle.ogg'
	suppressed_sound = 'modular_nova/modules/modular_weapons/sounds/suppressed_heavy.ogg'
	can_suppress = TRUE
	suppressor_x_offset = 2
	suppressor_y_offset = 1

	burst_size = 1
	fire_delay = 1.2 SECONDS
	actions_types = list()

	recoil = 0.5
	spread = 2.5
	projectile_wound_bonus = -20

/obj/item/gun/ballistic/automatic/lanca/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/gun/ballistic/automatic/lanca/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/lanca/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/lanca/examine_more(mob/user)
	. = ..()

	. += "The Lanca started as an attempt to replace the confusing position of the Miecz, \
		Originally started as an attempt to upscale the Miecz to a marksman caliber. \
		It eventually ended up as little more then an odd cousin to it's starting frame. \
		Upscaled heavily from the classic 7.62x24mm catridge, to a full size .310, which \
		Necessitated a redoing of the entire bolt, and upper receiver, coupled with a much stronger recoil spring. \
		Then, to make up for all the added weight, the stock was replaced with a lighter skeletonized one, \
		and the barrel assembly was changed out for a minimalist design. \
		All in all, you get less rifle, for the priveledge of a bigger caliber. \
		...And a scope."

	return .

/obj/item/gun/ballistic/automatic/lanca/no_mag
	spawnwithmagazine = FALSE

// The AMR
// This sounds a lot scarier than it actually is, you'll just have to trust me here

/obj/item/gun/ballistic/automatic/wylom
	name = "\improper Wyłom Anti-Materiel Rifle"
	desc = "A massive, outdated beast of an anti materiel rifle supposedly designed for 'fauna control.' Fires the devastating .60 Strela caseless round, \
		the massively overperforming penetration of which being the reason this weapon was eventually restricted from galactic trade."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_64.dmi'
	base_pixel_x = -16 // This baby is 64 pixels wide
	pixel_x = -16
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/inhands_64_left.dmi'
	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/inhands_64_right.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	icon_state = "wylom"
	inhand_icon_state = "wylom"
	worn_icon_state = "wylom"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK

	accepted_magazine_type = /obj/item/ammo_box/magazine/wylom
	can_suppress = FALSE

	fire_sound = 'modular_nova/modules/novaya_ert/sound/amr_fire.ogg'
	fire_sound_volume = 100 // BOOM BABY

	recoil = 4

	weapon_weight = WEAPON_HEAVY
	burst_size = 1
	fire_delay = 2 SECONDS
	actions_types = list()

	force = 15 // I mean if you're gonna beat someone with the thing you might as well get damage appropriate for how big the fukken thing is

/obj/item/gun/ballistic/automatic/wylom/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 0.5)

/obj/item/gun/ballistic/automatic/wylom/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)
	AddElement(/datum/element/gun_launches_little_guys, throwing_force = 3, throwing_range = 5)

/obj/item/gun/ballistic/automatic/wylom/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/wylom/examine_more(mob/user)
	. = ..()

	. += "The 'Wyłom' AMR was a weapon not originally made for unaided human hands. \
		The original rifle had mounting points for a specialized suit attachment system, \
		but that quickly fell through once it was announced, as exosuit hunting, isnt a common trend on the frontier. \
		This is the spitting image of anti-armo-... anti-anything.  \
		There's a laser etched warning label, informing users of the weapon to be wary of side-blast. \
		...And to not use it if you arent of appropriate size, but the sizing chart is no where to be seen."

	return .

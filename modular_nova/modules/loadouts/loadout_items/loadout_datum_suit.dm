/datum/loadout_category/suit
	category_name = "Suit"
	category_ui_icon = FA_ICON_VEST
	type_to_generate = /datum/loadout_item/suit
	tab_order = /datum/loadout_category/neck::tab_order + 1

/*
*	LOADOUT ITEM DATUMS FOR THE (EXO/OUTER)SUIT SLOT
*/

/datum/loadout_item/suit
	abstract_type = /datum/loadout_item/suit

/datum/loadout_item/suit/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE) // don't bother storing in backpack, can't fit
	if(initial(outfit_important_for_life.suit))
		return TRUE

/datum/loadout_item/suit/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.suit)
			LAZYADD(outfit.backpack_contents, outfit.suit)
		outfit.suit = item_path
	else
		outfit.suit = item_path

/*
*	WINTER COATS
*/

/datum/loadout_item/suit/winter_coat
	name = "Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat

/datum/loadout_item/suit/winter_coat_greyscale
	name = "Greyscale Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/custom

/datum/loadout_item/suit/aformal
	name = "Assistant's Formal Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/nova

/datum/loadout_item/suit/runed
	name = "Runed Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/nova/narsie

/datum/loadout_item/suit/brass
	name = "Brass Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/nova/ratvar

/datum/loadout_item/suit/korea
	name = "Eastern Winter Coat"
	item_path = /obj/item/clothing/suit/koreacoat

/datum/loadout_item/suit/czech
	name = "Czech Winter Coat"
	item_path = /obj/item/clothing/suit/modernwintercoatthing

/datum/loadout_item/suit/mantella
	name = "Mothic Mantella"
	item_path = /obj/item/clothing/suit/mothcoat/winter

/*
*	SUITS / SUIT JACKETS
*/

/datum/loadout_item/suit/recolorable
	name = "Recolorable Formal Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/greyscale

/datum/loadout_item/suit/black_suit_jacket
	name = "Black Formal Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/black

/datum/loadout_item/suit/blue_suit_jacket
	name = "Blue Formal Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer

/datum/loadout_item/suit/purple_suit_jacket
	name = "Purple Formal Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/purple

/datum/loadout_item/suit/white_suit_jacket
	name = "White Formal Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/white

/datum/loadout_item/suit/suitblackbetter
	name = "Light Black Formal Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/black/better

/datum/loadout_item/suit/suitwhite
	name = "Texan Suit Jacket"
	item_path = /obj/item/clothing/suit/texas

/*
*	SUSPENDERS
*/

/datum/loadout_item/suit/suspenders
	name = "Recolorable Suspenders"
	item_path = /obj/item/clothing/suit/toggle/suspenders

/*
*	DRESSES
*/

/datum/loadout_item/suit/white_dress
	name = "White Dress"
	item_path = /obj/item/clothing/suit/costume/whitedress

/*
*	LABCOATS
*/

/datum/loadout_item/suit/labcoat
	name = "Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat

/datum/loadout_item/suit/labcoat_green
	name = "Green Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/mad

/datum/loadout_item/suit/labcoat_medical
	name = "Medical Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/medical

/datum/loadout_item/suit/labcoat_lalunevest
	name = "Designer Buttoned Coat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/nova/lalunevest

/datum/loadout_item/suit/fancy_labcoat
	name = "Recolorable Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/nova/fancy

/datum/loadout_item/suit/labcoat_regular
	name = "Researcher's Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/nova/fancy/regular

/datum/loadout_item/suit/labcoat_pharmacist
	name = "Pharmacist's Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/nova/fancy/pharmacist

/datum/loadout_item/suit/labcoat_geneticist
	name = "Geneticist's Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/nova/fancy/geneticist

/datum/loadout_item/suit/labcoat_roboticist
	name = "Roboticist's Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/nova/fancy/roboticist

/datum/loadout_item/suit/labcoat_custom
	name = "Custom Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/nova/custom

/*
*	PONCHOS
*/

/datum/loadout_item/suit/poncho
	name = "Poncho"
	item_path = /obj/item/clothing/suit/costume/poncho

/datum/loadout_item/suit/poncho_green
	name = "Green Poncho"
	item_path = /obj/item/clothing/suit/costume/poncho/green

/datum/loadout_item/suit/poncho_red
	name = "Red Poncho"
	item_path = /obj/item/clothing/suit/costume/poncho/red

/datum/loadout_item/suit/dagger_mantle
	name = "'Dagger' Designer Mantle"
	item_path = /obj/item/clothing/suit/dagger_mantle

/*
*	JACKETS
*/

/datum/loadout_item/suit/bomber_jacket
	name = "Bomber Jacket"
	item_path = /obj/item/clothing/suit/jacket/bomber

/datum/loadout_item/suit/military_jacket
	name = "Military Jacket"
	item_path = /obj/item/clothing/suit/jacket/miljacket

/datum/loadout_item/suit/puffer_jacket
	name = "Puffer Jacket"
	item_path = /obj/item/clothing/suit/jacket/puffer

/datum/loadout_item/suit/puffer_vest
	name = "Puffer Vest"
	item_path = /obj/item/clothing/suit/jacket/puffer/vest

/datum/loadout_item/suit/leather_jacket
	name = "Leather Jacket"
	item_path = /obj/item/clothing/suit/jacket/leather

/datum/loadout_item/suit/leather_jacket/biker
	name = "Biker Jacket"
	item_path = /obj/item/clothing/suit/jacket/leather/biker

/datum/loadout_item/suit/leather_jacket/hooded
	name = "Leather Jacket with a Hoodie"
	item_path = /obj/item/clothing/suit/hooded/leather

/datum/loadout_item/suit/jacket_sweater
	name = "Recolorable Sweater Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/sweater

/datum/loadout_item/suit/jacket_oversized
	name = "Recolorable Oversized Jacket"
	item_path = /obj/item/clothing/suit/jacket/oversized

/datum/loadout_item/suit/jacket_fancy
	name = "Recolorable Fancy Fur Coat"
	item_path = /obj/item/clothing/suit/jacket/fancy

/datum/loadout_item/suit/tailored_jacket
	name = "Recolorable Tailored Jacket"
	item_path = /obj/item/clothing/suit/tailored_jacket

/datum/loadout_item/suit/tailored_short_jacket
	name = "Recolorable Tailored Short Jacket"
	item_path = /obj/item/clothing/suit/tailored_jacket/short

/datum/loadout_item/suit/ethereal_raincoat
	name = "Ethereal Raincoat"
	item_path = /obj/item/clothing/suit/hooded/ethereal_raincoat

/datum/loadout_item/suit/mothcoat
	name = "Mothic Flightsuit"
	item_path = /obj/item/clothing/suit/mothcoat

/datum/loadout_item/suit/big_jacket
	name = "Alpha Atelier Pilot Jacket"
	item_path = /obj/item/clothing/suit/big_jacket

/*
*	VARSITY JACKET
*/

/datum/loadout_item/suit/varsity
	name = "Varsity Jacket"
	item_path = /obj/item/clothing/suit/varsity

/*
*	COSTUMES
*/

/datum/loadout_item/suit/owl
	name = "Owl Cloak"
	item_path = /obj/item/clothing/suit/toggle/owlwings

/datum/loadout_item/suit/griffin
	name = "Griffon Cloak"
	item_path = /obj/item/clothing/suit/toggle/owlwings/griffinwings

/datum/loadout_item/suit/syndi
	name = "Black And Red Space Suit Replica"
	item_path = /obj/item/clothing/suit/syndicatefake

/datum/loadout_item/suit/bee
	name = "Bee Outfit"
	item_path = /obj/item/clothing/suit/hooded/bee_costume

/datum/loadout_item/suit/plague_doctor
	name = "Plague Doctor Suit"
	item_path = /obj/item/clothing/suit/bio_suit/plaguedoctorsuit

/datum/loadout_item/suit/snowman
	name = "Snowman Outfit"
	item_path = /obj/item/clothing/suit/costume/snowman

/datum/loadout_item/suit/chicken
	name = "Chicken Suit"
	item_path = /obj/item/clothing/suit/costume/chickensuit

/datum/loadout_item/suit/monkey
	name = "Monkey Suit"
	item_path = /obj/item/clothing/suit/costume/monkeysuit

/datum/loadout_item/suit/cardborg
	name = "Cardborg Suit"
	item_path = /obj/item/clothing/suit/costume/cardborg

/datum/loadout_item/suit/xenos
	name = "Xenos Suit"
	item_path = /obj/item/clothing/suit/costume/xenos

/datum/loadout_item/suit/ian_costume
	name = "Corgi Costume"
	item_path = /obj/item/clothing/suit/hooded/ian_costume

/datum/loadout_item/suit/carp_costume
	name = "Carp Costume"
	item_path = /obj/item/clothing/suit/hooded/carp_costume

/datum/loadout_item/suit/shark_costume
	name = "Shark Costume"
	item_path = /obj/item/clothing/suit/hooded/shark_costume

/datum/loadout_item/suit/shork_costume
	name = "Shork Costume"
	item_path = /obj/item/clothing/suit/hooded/shork_costume

/datum/loadout_item/suit/wizard
	name = "Wizard Robe"
	item_path = /obj/item/clothing/suit/wizrobe/fake

/datum/loadout_item/suit/witch
	name = "Witch Robe"
	item_path = /obj/item/clothing/suit/wizrobe/marisa/fake

/*
*	SEASONAL
*/

/datum/loadout_item/suit/winter_coat/christmas
	name = "Christmas Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/nova/christmas

/datum/loadout_item/suit/winter_coat/christmas/green
	name = "Green Christmas Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/nova/christmas/green

/*
*	MISC
*/

/datum/loadout_item/suit/recolorable_apron
	name = "Recolorable Apron"
	item_path = /obj/item/clothing/suit/apron/chef/colorable_apron

/datum/loadout_item/suit/recolorable_overalls
	name = "Recolorable Overalls"
	item_path = /obj/item/clothing/suit/apron/overalls

/datum/loadout_item/suit/redhood
	name = "Red cloak"
	item_path = /obj/item/clothing/suit/hooded/cloak/david

/datum/loadout_item/suit/wellwornshirt
	name = "Well-worn Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt

/datum/loadout_item/suit/wellworn_graphicshirt
	name = "Well-worn Graphic Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/graphic

/datum/loadout_item/suit/ianshirt
	name = "Well-worn Ian Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/graphic/ian

/datum/loadout_item/suit/wornoutshirt
	name = "Worn-out Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/wornout

/datum/loadout_item/suit/wornout_graphicshirt
	name = "Worn-out graphic Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic

/datum/loadout_item/suit/wornout_ianshirt
	name = "Worn-out Ian Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic/ian

/datum/loadout_item/suit/messyshirt
	name = "Messy Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/messy

/datum/loadout_item/suit/messy_graphicshirt
	name = "Messy Graphic Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic

/datum/loadout_item/suit/messy_ianshirt
	name = "Messy Ian Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic/ian

/datum/loadout_item/suit/wornshirt
	name = "Worn Shirt"
	item_path = /obj/item/clothing/suit/wornshirt

/datum/loadout_item/suit/duster
	name = "Colorable Duster"
	item_path = /obj/item/clothing/suit/duster

/datum/loadout_item/suit/peacoat
	name = "Colorable Peacoat"
	item_path = /obj/item/clothing/suit/toggle/peacoat

/datum/loadout_item/suit/trackjacket
	name = "Track Jacket"
	item_path = /obj/item/clothing/suit/toggle/trackjacket

/datum/loadout_item/suit/croptop
	name = "Crop Top Turtleneck"
	item_path = /obj/item/clothing/suit/jacket/croptop

/datum/loadout_item/suit/white_robe
	name = "White Robe"
	item_path = /obj/item/clothing/suit/jacket/white_robe

/*
*	FLANNELS
*/

/datum/loadout_item/suit/flannel_gags
	name = "Flannel Shirt"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel/gags

/datum/loadout_item/suit/flannel_black
	name = "Black Flannel"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel

/datum/loadout_item/suit/flannel_red
	name = "Red Flannel"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel/red

/datum/loadout_item/suit/flannel_aqua
	name = "Aqua Flannel"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel/aqua

/datum/loadout_item/suit/flannel_brown
	name = "Brown Flannel"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel/brown

/*
*	HAWAIIAN
*/


/datum/loadout_item/suit/hawaiian_shirt
	name = "Hawaiian Shirt"
	item_path = /obj/item/clothing/suit/costume/hawaiian

/*
*	MISC
*/

/datum/loadout_item/suit/frenchtrench
	name = "Blue Trenchcoat"
	item_path = /obj/item/clothing/suit/frenchtrench

/datum/loadout_item/suit/frontiertrench
	name = "Frontier Trenchcoat"
	item_path = /obj/item/clothing/suit/jacket/frontier_colonist

/datum/loadout_item/suit/cossak
	name = "Ukrainian Coat"
	item_path = /obj/item/clothing/suit/cossack

/datum/loadout_item/suit/parka
	name = "Falls Parka"
	item_path = /obj/item/clothing/suit/fallsparka

/datum/loadout_item/suit/gags_wintercoat
	name = "Recolorable Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/colourable

/datum/loadout_item/suit/urban
	name = "Urban Coat"
	item_path = /obj/item/clothing/suit/urban

/datum/loadout_item/suit/maxson
	name = "Fancy Brown Coat"
	item_path = /obj/item/clothing/suit/brownbattlecoat

/datum/loadout_item/suit/bossu
	name = "Fancy Black Coat"
	item_path = /obj/item/clothing/suit/blackfurrich

/datum/loadout_item/suit/dutchjacket
	name = "Western Jacket"
	item_path = /obj/item/clothing/suit/dutchjacketsr

/datum/loadout_item/suit/caretaker
	name = "Caretaker Jacket"
	item_path = /obj/item/clothing/suit/victoriantailcoatbutler

/datum/loadout_item/suit/jacketbomber_alt
	name = "Bomber Jacket w/ Zipper"
	item_path = /obj/item/clothing/suit/toggle/jacket

/datum/loadout_item/suit/colourable_leather_jacket
	name = "Colourable Leather Jacket"
	item_path = /obj/item/clothing/suit/jacket/leather/colourable

/datum/loadout_item/suit/frontierjacket
	abstract_type = /datum/loadout_item/suit/frontierjacket

/datum/loadout_item/suit/frontierjacket/short
	name = "Frontier Jacket (Short)"
	item_path = /obj/item/clothing/suit/jacket/frontier_colonist/short

/datum/loadout_item/suit/frontierjacket/short/medical
	name = "Frontier Medical Jacket (Short)"
	item_path = /obj/item/clothing/suit/jacket/frontier_colonist/medical

/datum/loadout_item/suit/woolcoat
	name = "Leather Overcoat"
	item_path = /obj/item/clothing/suit/woolcoat

/datum/loadout_item/suit/flakjack
	name = "Flak Jacket"
	item_path = /obj/item/clothing/suit/flakjack

/datum/loadout_item/suit/deckard
	name = "Runner Coat"
	item_path = /obj/item/clothing/suit/toggle/deckard
	restricted_roles = list(JOB_DETECTIVE)

/datum/loadout_item/suit/bltrench
	name = "Black Trenchcoat"
	item_path = /obj/item/clothing/suit/trenchblack

/datum/loadout_item/suit/brtrench
	name = "Brown Trenchcoat"
	item_path = /obj/item/clothing/suit/trenchbrown

/datum/loadout_item/suit/discojacket
	name = "Disco Ass Blazer"
	item_path = /obj/item/clothing/suit/discoblazer

/datum/loadout_item/suit/kimjacket
	name = "Aerostatic Bomber Jacket"
	item_path = /obj/item/clothing/suit/kimjacket

/datum/loadout_item/suit/cardigan
	name = "Cardigan"
	item_path = /obj/item/clothing/suit/toggle/jacket/cardigan

/datum/loadout_item/suit/blastwave_suit
	name = "Blastwave Trenchcoat"
	item_path = /obj/item/clothing/suit/blastwave

/*
*	HOODIES
*/
/datum/loadout_item/suit/hoodie
	abstract_type = /datum/loadout_item/suit/hoodie


/datum/loadout_item/suit/hoodie/greyscale
	name = "Greyscale Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie

/datum/loadout_item/suit/hoodie/greyscale_trim
	name = "Greyscale Trimmed Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/trim

/datum/loadout_item/suit/hoodie/greyscale_trim_alt
	name = "Greyscale Trimmed Hoodie (Alt)"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/trim/alt

/datum/loadout_item/suit/hoodie/black
	name = "Black Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/black

/datum/loadout_item/suit/hoodie/red
	name = "Red Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/red

/datum/loadout_item/suit/hoodie/blue
	name = "Blue Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/blue

/datum/loadout_item/suit/hoodie/green
	name = "Green Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/green

/datum/loadout_item/suit/hoodie/orange
	name = "Orange Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/orange

/datum/loadout_item/suit/hoodie/yellow
	name = "Yellow Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/yellow

/datum/loadout_item/suit/hoodie/grey
	name = "Grey Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/grey

/datum/loadout_item/suit/hoodie/nt
	name = "NT Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded

/datum/loadout_item/suit/hoodie/smw
	name = "SMW Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded/smw

/datum/loadout_item/suit/hoodie/nrti
	name = "NRTI Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded/nrti

/datum/loadout_item/suit/hoodie/cti
	name = "CTI Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded/cti

/datum/loadout_item/suit/hoodie/mu
	name = "Mojave University Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded/mu

/*
*	JOB-LOCKED
*/

// WINTER COATS
/datum/loadout_item/suit/coat_med
	name = "Medical Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical

/datum/loadout_item/suit/coat_paramedic
	name = "Paramedic Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical/paramedic

/datum/loadout_item/suit/coat_robotics
	name = "Robotics Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/science/robotics

/datum/loadout_item/suit/coat_sci
	name = "Science Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/science

/datum/loadout_item/suit/coat_eng
	name = "Engineering Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/engineering

/datum/loadout_item/suit/coat_atmos
	name = "Atmospherics Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/engineering/atmos

/datum/loadout_item/suit/coat_hydro
	name = "Hydroponics Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/hydro

/datum/loadout_item/suit/coat_bar
	name = "Bartender Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/nova/bartender

/datum/loadout_item/suit/coat_cargo
	name = "Cargo Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/cargo

/datum/loadout_item/suit/coat_miner
	name = "Mining Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/miner

// JACKETS
/datum/loadout_item/suit/navybluejacketofficer
	name = "Security Officer's Navy Blue Formal Jacket"
	item_path = /obj/item/clothing/suit/jacket/officer/blue
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/suit/navybluejacketwarden
	name = "Warden's Navy Blue Formal Jacket"
	item_path = /obj/item/clothing/suit/jacket/warden/blue
	restricted_roles = list(JOB_WARDEN)

/datum/loadout_item/suit/navybluejackethos
	name = "Head of Security's Navy Blue Formal Jacket"
	item_path = /obj/item/clothing/suit/jacket/hos/blue
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

/datum/loadout_item/suit/security_jacket
	name = "Security Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/sec
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY) //Not giving this one to COs because it's actually better than the one they spawn with

/datum/loadout_item/suit/brit
	name = "High Vis Armored Vest"
	item_path = /obj/item/clothing/suit/armor/vest/peacekeeper/brit
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/suit/british_jacket
	name = "Peacekeeper Officer Coat"
	item_path = /obj/item/clothing/suit/british_officer
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/suit/peacekeeper_jacket
	name = "Peacekeeper Jacket"
	item_path = /obj/item/clothing/suit/armor/vest/peacekeeper/jacket
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/suit/peacekeeper_jacket_badge
	name = "Badged Peacekeeper Jacket"
	item_path = /obj/item/clothing/suit/armor/vest/peacekeeper/jacket/badge
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/suit/peacekeeper_wintercoat
	name = "Security Wintercoat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/security
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/suit/detjacket
	name = "Detective Jacket (dark)"
	item_path = /obj/item/clothing/suit/jacket/det_suit/dark
	restricted_roles = list(JOB_DETECTIVE)

/datum/loadout_item/suit/detjackenoir
	name = "Detective Jacket (noir)"
	item_path = /obj/item/clothing/suit/jacket/det_suit/noir
	restricted_roles = list(JOB_DETECTIVE)

/datum/loadout_item/suit/detjacketbrown
	name = "Detective's Brown Jacket"
	item_path = /obj/item/clothing/suit/jacket/det_suit/brown 
	restricted_roles = list(JOB_DETECTIVE)

/datum/loadout_item/suit/detjacketplain
	name = "Detective's Jacket"
	item_path = /obj/item/clothing/suit/jacket/det_suit
	restricted_roles = list(JOB_DETECTIVE)

/datum/loadout_item/suit/detectivearmorvest
	name = "Detective's Armor Vest"
	item_path = /obj/item/clothing/suit/armor/vest/det_suit
	restricted_roles = list(JOB_DETECTIVE)

/datum/loadout_item/suit/peacekeeper_jacket/badge
	name = "Badged Peacekeeper Jacket"
	item_path = /obj/item/clothing/suit/armor/vest/peacekeeper/jacket/badge

/datum/loadout_item/suit/offdep_jacket
	name = "Off-Department Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/assistant

/datum/loadout_item/suit/engi_jacket
	name = "Engineering Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/engi

/datum/loadout_item/suit/sci_jacket
	name = "Science Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/sci

/datum/loadout_item/suit/med_jacket
	name = "Medbay Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/med

/datum/loadout_item/suit/supply_jacket
	name = "Supply Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/supply

/datum/loadout_item/suit/cargo_gorka_jacket
	name = "Cargo Gorka Jacket"
	item_path = /obj/item/clothing/suit/toggle/cargo_tech

/datum/loadout_item/suit/qm_jacket
	name = "Quartermaster's Overcoat"
	item_path = /obj/item/clothing/suit/jacket/quartermaster
	restricted_roles = list(JOB_QUARTERMASTER)

// LABCOATS
/datum/loadout_item/suit/labcoat_highvis
	name = "High-Vis Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/nova/highvis

/*
*	FAMILIES
*/

/datum/loadout_item/suit/tmc
	name = "TMC Coat"
	item_path = /obj/item/clothing/suit/costume/tmc

/datum/loadout_item/suit/pg
	name = "PG Coat"
	item_path = /obj/item/clothing/suit/costume/pg

/datum/loadout_item/suit/deckers
	name = "Deckers Hoodie"
	item_path = /obj/item/clothing/suit/costume/deckers

/datum/loadout_item/suit/soviet
	name = "Soviet Coat"
	item_path = /obj/item/clothing/suit/costume/soviet

/datum/loadout_item/suit/yuri
	name = "Yuri Coat"
	item_path = /obj/item/clothing/suit/costume/yuri

/*
*	DONATOR
*/

/datum/loadout_item/suit/donator
	abstract_type = /datum/loadout_item/suit/donator
	donator_only = TRUE

/datum/loadout_item/suit/donator/furredjacket
	name = "Furred Jacket"
	item_path = /obj/item/clothing/suit/brownfurrich/public

/datum/loadout_item/suit/donator/whitefurredjacket
	name = "White Furred Jacket"
	item_path = /obj/item/clothing/suit/brownfurrich/white

/datum/loadout_item/suit/donator/creamfurredjacket
	name = "Cream Furred Jacket"
	item_path = /obj/item/clothing/suit/brownfurrich/cream

/datum/loadout_item/suit/donator/modern_winter
	name = "Modern Winter Coat"
	item_path = /obj/item/clothing/suit/modern_winter

/datum/loadout_item/suit/donator/blondie
	name = "Cowboy Vest"
	item_path = /obj/item/clothing/suit/cowboyvest

/datum/loadout_item/suit/donator/digicoat
	abstract_type = /datum/loadout_item/suit/donator/digicoat

/datum/loadout_item/suit/donator/digicoat/nanotrasen
	name = "nanotrasen digicoat"
	item_path = /obj/item/clothing/suit/toggle/digicoat/nanotrasen

/datum/loadout_item/suit/donator/digicoat/interdyne
	name = "Interdyne Digicoat"
	item_path = /obj/item/clothing/suit/toggle/digicoat/interdyne

/datum/loadout_item/suit/donator/replica_parade_jacket
	name = "Replica Parade Jacket"
	item_path = /obj/item/clothing/suit/replica_parade_jacket

// All-donators donator item for BlindPoet
/datum/loadout_item/suit/donator/chokha
	name = "Iseurian Chokha"
	item_path = /obj/item/clothing/suit/chokha

/datum/loadout_item/suit/digicoat_glitched //Public donator reward for Razurath.
	name = "Glitched Digicoat"
	item_path = /obj/item/clothing/suit/toggle/digicoat/glitched

/datum/loadout_item/suit/warm_coat
	name = "Colourable Warm Coat"
	item_path = /obj/item/clothing/suit/warm_coat

/datum/loadout_item/suit/warm_sweater
	name = "Colourable Warm Sweater"
	item_path = /obj/item/clothing/suit/warm_sweater

/datum/loadout_item/suit/heart_sweater
	name = "Colourable Heart Sweater"
	item_path = /obj/item/clothing/suit/heart_sweater

// Fancy crop-top jackets

/datum/loadout_item/suit/crop_jacket
	name = "Colourable Crop-Top Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket

/datum/loadout_item/suit/shortsleeve_crop_jacket
	name = "Colourable Short-Sleeved Crop-Top Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket/shortsleeve

/datum/loadout_item/suit/sleeveless_crop_jacket
	name = "Colourable Sleeveless Crop-Top Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket/sleeveless

/datum/loadout_item/suit/sports_jacket
	name = "Colourable Sports Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket/long

/datum/loadout_item/suit/shortsleeve_sports_jacket
	name = "Colourable Short-Sleeved Sports Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket/shortsleeve/long

/datum/loadout_item/suit/sleeveless_sports_jacket
	name = "Colourable Sleeveless Sports Jacket"
	item_path = /obj/item/clothing/suit/crop_jacket/sleeveless/long

/*
*	CHAPLAIN
*/

/datum/loadout_item/suit/chap_nun
	name = "Nun's Habit"
	item_path = /obj/item/clothing/suit/chaplainsuit/nun

/datum/loadout_item/suit/chap_holiday
	name = "Chaplain's Holiday Robe"
	item_path = /obj/item/clothing/suit/chaplainsuit/holidaypriest

/datum/loadout_item/suit/chap_brownmonk
	name = "Monk's Brown Habit"
	item_path = /obj/item/clothing/suit/hooded/chaplainsuit/monkhabit

/datum/loadout_item/suit/chap_eastmonk
	name = "Eastern Monk's Robe"
	item_path = /obj/item/clothing/suit/chaplainsuit/monkrobeeast

/datum/loadout_item/suit/chap_shrinehand
	name = "Shrinehand Robe"
	item_path = /obj/item/clothing/suit/chaplainsuit/shrinehand

/datum/loadout_item/suit/chap_blackmonk
	name = "Monk's Black Habit"
	item_path = /obj/item/clothing/suit/chaplainsuit/habit

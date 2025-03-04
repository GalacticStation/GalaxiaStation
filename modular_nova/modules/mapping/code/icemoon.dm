/*----- Template for ruins, prevents needing to re-type the filepath prefix -----*/
/datum/map_template/ruin/icemoon/underground/nova/
	prefix = "_maps/RandomRuins/IceRuins/nova/"

/datum/map_template/ruin/icemoon/nova/
	prefix = "_maps/RandomRuins/IceRuins/nova/"
/*----- Underground -----*/

/datum/map_template/ruin/icemoon/underground/nova/mining_site_below
	name = "Ice-ruin Mining Site Underground"
	id = "miningsite-underground"
	description = "The Iceminer arena."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_underground_mining_site.dmm"
	always_place = TRUE

/datum/map_template/ruin/icemoon/underground/nova/interdyne_base
	name = "Ice-ruin Interdyne Pharmaceuticals Nova Sector Base 8817238"
	id = "ice-base"
	description = "A planetside Interdyne research facility developing biological weapons; it is closely guarded by an elite team of agents."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_underground_interdyne_base1.dmm"
	allow_duplicates = FALSE
	never_spawn_with = list(/datum/map_template/ruin/lavaland/nova/interdyne_base)
	always_place = TRUE

/datum/map_template/ruin/icemoon/underground/nova/magic_hotsprings
	name = "Magic Hotsprings"
	id = "magic-hotsprings"
	description = "A beautiful hot springs spot, surrounded by unnatural fairy grass and exotic trees."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_underground_magical_hotsprings.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/icemoon/underground/nova/abandoned_hearth
	name = "Abandoned Hearth"
	id = "abandoned-hearth"
	description = "Something went terribly wrong in this hearth, if the signs of struggle are anything to go by."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_underground_abandoned_icewalker_den.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/icemoon/underground/nova/duo_hermit
	name = "Ice-ruin Duo Hermit"
	id = "icemoon-duo-hermit"
	description = "A place of shelter for a duet of hermits, scraping by to live another day."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_duo_hermit.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/icemoon/underground/nova/abandoned_sacred_temple
	name = "Sacred Temple"
	id = "abandoned-sacred-temple"
	description = "The dusty remains of a temple, sacred in nature."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_underground_abandoned_sacred_temple.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/icemoon/underground/nova/ice_boss_vent
	name = "Ice-Ruin Frozen Rite Location"
	id = "ice_r_boss_vent"
	description = "They believed sacrifices could give more rewards. They were not prepared for the felling of their hubris."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_underground_boss_vent.dmm"
	allow_duplicates = FALSE
	cost = 0
	mineral_cost = 1

/datum/map_template/ruin/icemoon/underground/nova/ice_elite_vent
	name = "Ice-Ruin Frozen Well Location"
	id = "ice_r_elite_vent"
	description = "Jimmy never fell in the well. But it wasn't Jimmy that walked away"
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_underground_elite_vent.dmm"
	allow_duplicates = FALSE
	cost = 0
	mineral_cost = 1

//Code for the Abandoned Sacred Temple
/obj/structure/statue/hearthkin/odin
	name = "statue of Óðinn"
	desc = "A gold statue, representing the All-Father Óðinn. It is strangely in good state."
	icon = 'modular_nova/modules/primitive_catgirls/icons/gods_statue.dmi'
	icon_state = "odin_statue"

/obj/item/paper/crumpled/bloody/fluff/stations/lavaland/sacred_temple/
	name = "moon 34, of the year 2283"
	desc = "A note written in Ættmál. It seems to have been ripped from a diary of some sort."
	default_raw_text = "<i>I refuse to believe we're reduced to this- to sacrifice our own in hopes of our gods taking pity and rescuing us. We've lost too many already... I regret not joining with the rest. But I won't sit here and wait for my turn to be sacrificed, moping about like some sort of useless bastard. Me, my husband, and my sibling Halko will soon make our move, once the grand priest goes to sleep.</i>"

/obj/item/paper/crumpled/bloody/fluff/stations/lavaland/sacred_temple/ui_status(mob/user, datum/ui_state/state)
    if(!user.has_language(/datum/language/primitive_catgirl))
        to_chat(user, span_warning("This seems to be in a language you do not understand!"))
        return UI_CLOSE

    . = ..()

/*----- Above Ground -----*/
////// Yes, I know the "Above Ground" Is very limited in space. This is a... ~17x17? ruin.
/datum/map_template/ruin/icemoon/nova/turret_bunker
	name = "Ice-ruin Surface Geological Research Bunker"
	id = "turret_bunker"
	description = "A ramshackle research bunker for geological survey on the icemoon. Its inhabitants, however, forgot to scrub their turret's AI after an electrical event."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_surface_turretbunker.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/icemoon/nova/snow_geosite
	name = "Ice-Ruin Surface Geological Site"
	id = "snow_geosite"
	description = "A mishap during geological site testing ended a poor man's life. Anyways, Roll a d10 to loot the body."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_surface_geosite.dmm"
	allow_duplicates = FALSE

/*----- Template for ruins, prevents needing to re-type the filepath prefix -----*/
/datum/map_template/ruin/lavaland/nova
	prefix = "_maps/RandomRuins/LavaRuins/nova/"
/*------*/

/datum/map_template/ruin/lavaland/ash_walker
	name = "Lava-Ruin Ash Walker Nest"
	id = "ash-walker"
	description = "A race of unbreathing lizards live here, that run faster than a human can, worship a broken dead city, and are capable of reproducing by something involving tentacles? \
	Probably best to stay clear."
	prefix = "_maps/RandomRuins/LavaRuins/nova/"
	suffix = "lavaland_surface_ash_walker1.dmm"
	cost = 1000
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/nova/interdyne_base
	name = "Lava-Ruin Interdyne Pharmaceutics Nova Sector Base 3c76928"
	id = "lava-base"
	description = "A planetside Interdyne research facility developing biological weapons; it is closely guarded by an elite team of agents."
	prefix = "_maps/RandomRuins/LavaRuins/nova/"
	suffix = "lavaland_surface_interdyne_base1.dmm"
	allow_duplicates = FALSE
	never_spawn_with = list(/datum/map_template/ruin/icemoon/underground/nova/interdyne_base)
	always_place = TRUE

/datum/map_template/ruin/lavaland/arena
	name = "Lava-Ruin Grand Arena"
	id = "arena"
	description = "An ancient gladiatorial arena containing a deadly warrior within."
	prefix = "_maps/RandomRuins/LavaRuins/nova/"
	suffix = "lavaland_surface_arena.dmm"
	cost = 0
	always_place = TRUE //WOULD BE UNFAIR IF SOMETHING THAT IS ALWAYS PLACED HAD A COST...
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/nova/colonist_homestead
	name = "Lava-Ruin Colonist Homestead"
	id = "colonist_homestead"
	description = "Some Tiziran bushcraft club members adopted the name of a historical figure for 'immersion.' They didn't realize how hard that would make things..."
	prefix = "_maps/RandomRuins/LavaRuins/nova/"
	suffix = "lavaland_surface_prefab_homestead.dmm"
	allow_duplicates = FALSE
	cost = 5

/datum/map_template/ruin/lavaland/nova/geosite
	name = "Lava-Ruin Geological site"
	id = "lava_geosite"
	description = "A legion encounter during geological site extraction costed everyone their lives. Even the dwarf."
	prefix = "_maps/RandomRuins/LavaRuins/nova/"
	suffix = "lavaland_surface_geosite.dmm"
	allow_duplicates = FALSE
	cost = 0 // We'll steal ore vent costs, since this provides 2 vents on lavaland in a public manner
	mineral_cost = 2

/datum/map_template/ruin/lavaland/nova/boss_vent
	name = "Lava-Ruin Rite Location"
	id = "lava_r_boss_vent"
	description = "A temple paved with stones, to disturb it is to fight the fears within."
	prefix = "_maps/RandomRuins/LavaRuins/nova/"
	suffix = "lavaland_surface_boss_vent.dmm" // 11x11
	allow_duplicates = FALSE
	cost = 0 // We'll steal ore vent costs for vents
	mineral_cost = 1 //One vent

/datum/map_template/ruin/lavaland/nova/elite_vent
	name = "Lava-Ruin Lava Well"
	id = "lava_r_elite_vent"
	description = "A well of rich mineral water hidden below a small lake of lava. Nice that it was paved atleast."
	prefix = "_maps/RandomRuins/LavaRuins/nova/"
	suffix = "lavaland_surface_elite_vent.dmm" // 5x5
	allow_duplicates = FALSE
	cost = 0 // We'll steal ore vent costs for vents
	mineral_cost = 1 //One vent

/datum/map_template/ruin/lavaland/nova/duo_hermit
	name = "Lava-Ruin Duo Makeshift Shelter"
	id = "lavaland-duo-hermit"
	description = "A place of shelter for a duet of hermits, scraping by to live another day."
	prefix = "_maps/RandomRuins/LavaRuins/nova/"
	suffix = "lavaland_duo_hermit.dmm"
	allow_duplicates = FALSE
	cost = 5

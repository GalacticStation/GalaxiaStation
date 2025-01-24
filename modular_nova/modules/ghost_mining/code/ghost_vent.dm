#define COLONY_THREAT_XENOS "xenos"
#define COLONY_THREAT_PIRATES "pirates"
#define COLONY_THREAT_CARP "carp"
#define COLONY_THREAT_SNOW "snow"
#define COLONY_THREAT_MINING "mining"
#define COLONY_THREAT_ICE_MINING "ice-mining"
#define COLONY_THREAT_BEACH "beach"

//Resetting veins for ghost roles. Randomizes bouldersize, mineral breakdown, and potentially threats.

/obj/structure/ore_vent/ghost_mining
	name = "oxide nodule vent"
	desc = "A vent full of rare oxide nodules, producing varous minerals every time one is brought up. Scan with an advanced mining scanner to start extracting ore from it."
	icon_state = "ore_vent_active"
	mineral_breakdown = list(
		/datum/material/iron = 50,
		/datum/material/glass = 50) //we dont need a seperate starting list
	unique_vent = TRUE
	boulder_size = BOULDER_SIZE_SMALL
	defending_mobs = list(/mob/living/basic/carp)
	var/clear_tally = 0 //so we can track how many time it clears for data-testing purposes.
	var/boulder_bounty = 10 //how many boulders per clear attempt. First one is small and easy
	var/threat_pool = list(
		COLONY_THREAT_CARP,
		COLONY_THREAT_PIRATES,
		COLONY_THREAT_XENOS
	) //we put this here for customization reasons. For singular threat ones, Only put one.

/obj/structure/ore_vent/ghost_mining/examine(mob/user)
	. = ..()
	if(discovered)
		switch(boulder_size)
			if(BOULDER_SIZE_SMALL)
				. += span_notice("This vent produces [span_bold("small")] boulders containing [ore_string]")
			if(BOULDER_SIZE_MEDIUM)
				. += span_notice("This vent produces [span_bold("medium")] boulders containing [ore_string]")
			if(BOULDER_SIZE_LARGE)
				. += span_notice("This vent produces [span_bold("large")] boulders containing [ore_string]")
	else
		. += span_notice("This vent can be scanned with a [span_bold("Mining Scanner")].")

	switch(tapped)
		if(TRUE)
			. += span_notice("The current nodule holds [boulder_bounty] chunks worth of ore.")
		if(FALSE)
			. += span_notice("The vent holds a nodule breakable into [boulder_bounty] ore chunks.")
	if(clear_tally >= 1)
		. += span_notice("This vent has hauled up [clear_tally] nodules.")

/obj/structure/ore_vent/ghost_mining/produce_boulder(apply_cooldown)
	. = ..()
	boulder_bounty -= 1
	if(boulder_bounty == 0)
		reset_vent()

/obj/structure/ore_vent/ghost_mining/start_wave_defense() //We add faction and change spawn text a bit. tbh we could rebalance a bit but thats for later ideas
	AddComponent(\
		/datum/component/spawner, \
		spawn_types = defending_mobs, \
		spawn_time = (10 SECONDS + (5 SECONDS * (boulder_size/5))), \
		faction = FACTION_MINING, \
		max_spawned = 10, \
		max_spawn_per_attempt = (1 + (boulder_size/5)), \
		spawn_text = "emerges from hidden tunnels near", \
		spawn_distance = 4, \
		spawn_distance_exclude = 3, \
	)
	COOLDOWN_START(src, wave_cooldown, wave_timer)
	addtimer(CALLBACK(src, PROC_REF(handle_wave_conclusion)), wave_timer)
	icon_state = icon_state_tapped
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/ore_vent/ghost_mining/proc/reset_vent()
	cut_overlays()
	tapped = FALSE
	SSore_generation.processed_vents -= src
	icon_state = base_icon_state
	update_appearance(UPDATE_ICON_STATE)
	clear_tally += 1
	reset_ores()

/obj/structure/ore_vent/ghost_mining/proc/reset_ores()
	var/magnitude = rand(1,4)
	var/ore_pool = list(
		/datum/material/iron = 14,
		/datum/material/glass = 12,
		/datum/material/plasma = 10,
		/datum/material/titanium = 9,
		/datum/material/silver = 9,
		/datum/material/gold = 7,
		/datum/material/diamond = 3,
		/datum/material/uranium = 5,
		/datum/material/bluespace = 3,
		/datum/material/plastic = 2,
		)
	var/ore_output_size = list(
		LARGE_VENT_TYPE,
		MEDIUM_VENT_TYPE,
		SMALL_VENT_TYPE,
		)

	var/new_boulder_size = pick(ore_output_size)
	switch(new_boulder_size)
		if(LARGE_VENT_TYPE)
			boulder_size = BOULDER_SIZE_LARGE
			wave_timer = WAVE_DURATION_LARGE
		if(MEDIUM_VENT_TYPE)
			boulder_size = BOULDER_SIZE_MEDIUM
			wave_timer = WAVE_DURATION_MEDIUM
		if(SMALL_VENT_TYPE)
			boulder_size = BOULDER_SIZE_SMALL
			wave_timer = WAVE_DURATION_SMALL

	boulder_bounty = (magnitude * boulder_size) // minimal 5, maximum is 60. tbh not that hard in space

	name = "[new_boulder_size] oxide chunk"
	AddComponent(/datum/component/gps, name)

	var/threat_pick = pick(threat_pool)

	switch(threat_pick)
		if(COLONY_THREAT_CARP)
			defending_mobs = list(
				/mob/living/basic/carp,
				/mob/living/basic/carp/mega)
		if(COLONY_THREAT_PIRATES)
			defending_mobs = list(
				/mob/living/basic/trooper/pirate/melee/space,
				/mob/living/basic/trooper/pirate/ranged/space
			)
		if(COLONY_THREAT_XENOS)
			defending_mobs = list(
				/mob/living/basic/alien,
				/mob/living/basic/alien/drone,
				/mob/living/basic/alien/sentinel
			)
		if(COLONY_THREAT_MINING)
			defending_mobs = list(
				/mob/living/basic/mining/goliath,
				/mob/living/basic/mining/legion/spawner_made,
				/mob/living/basic/mining/watcher,
				/mob/living/basic/mining/lobstrosity/lava,
				/mob/living/basic/mining/brimdemon,
				/mob/living/basic/mining/bileworm,
			)
		if(COLONY_THREAT_ICE_MINING)
			defending_mobs = list(
				/mob/living/basic/mining/ice_whelp,
				/mob/living/basic/mining/lobstrosity,
				/mob/living/basic/mining/legion/snow/spawner_made,
				/mob/living/basic/mining/ice_demon,
				/mob/living/basic/mining/wolf,
				/mob/living/simple_animal/hostile/asteroid/polarbear,
			)
		if(COLONY_THREAT_SNOW)
			defending_mobs = list(
				/mob/living/basic/mining/lobstrosity,
				/mob/living/basic/mining/legion/snow/spawner_made,
				/mob/living/basic/mining/wolf,
				/mob/living/simple_animal/hostile/asteroid/polarbear,
			)
		if(COLONY_THREAT_BEACH) // gotta keep atleast one "difficult" monster in
			defending_mobs = list(
				/mob/living/basic/crab,
				/mob/living/basic/mining/lobstrosity/juvenile/lava,
				/mob/living/basic/mining/lobstrosity/lava
			)

	for(var/old_ore in mineral_breakdown)
		mineral_breakdown -= old_ore

	for(var/new_ore in 1 to magnitude)
		var/datum/mineral_picked = pick(ore_pool)
		mineral_breakdown += mineral_picked
		ore_pool -= mineral_picked
		mineral_breakdown[mineral_picked] = rand(5, 20) //we need a weight to the boulders or else produce_boulder shits the bed.

//// Vent variants for ghost roles in future work

/obj/structure/ore_vent/ghost_mining/lavaland
	defending_mobs = list(/mob/living/basic/mining/legion/spawner_made) //one of the easier starting ones
	threat_pool = list(COLONY_THREAT_MINING)

/obj/structure/ore_vent/ghost_mining/snowland
	icon_state = "ore_vent_ice_active"
	defending_mobs = list(/mob/living/basic/mining/wolf) //one of the easier snowies
	threat_pool = list(COLONY_THREAT_SNOW)

/obj/structure/ore_vent/ghost_mining/undersnow
	icon_state = "ore_vent_ice_active"
	defending_mobs = list(/mob/living/basic/mining/wolf) //one of the easier snowies
	threat_pool = list(COLONY_THREAT_ICE_MINING)

/obj/structure/ore_vent/ghost_mining/pirate
	defending_mobs = list(/mob/living/basic/trooper/pirate/melee,
		/mob/living/basic/trooper/pirate/ranged) //you can space cheese the starting ones, but only the starting ones
	threat_pool = list(COLONY_THREAT_PIRATES)

/obj/structure/ore_vent/ghost_mining/xenos
	defending_mobs = list(/mob/living/basic/alien/drone)
	threat_pool = list(COLONY_THREAT_XENOS)

/obj/structure/ore_vent/ghost_mining/carp
	defending_mobs = list(/mob/living/basic/carp)
	threat_pool = list(COLONY_THREAT_CARP)

/obj/structure/ore_vent/ghost_mining/crab
	defending_mobs = list(/mob/living/basic/crab)
	threat_pool = list(COLONY_THREAT_BEACH)

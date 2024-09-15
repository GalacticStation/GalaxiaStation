/obj/docking_port/mobile
	/// Does this shuttle play sounds upon landing and takeoff?
	var/shuttle_sounds = TRUE
	/// The take off sound to be played
	var/takeoff_sound = sound('modular_nova/modules/advanced_shuttles/sound/engine_startup.ogg')
	/// The landing sound to be played
	var/landing_sound = sound('modular_nova/modules/advanced_shuttles/sound/engine_landing.ogg')
	/// The sound range coeff for the landing and take off sound effect
	var/sound_range = 11

/obj/docking_port/mobile/proc/bolt_all_doors() // Expensive procs :(
	var/list/turfs = return_ordered_turfs(x, y, z, dir)
	var/list/airlock_cache = list()
	for(var/i in 1 to turfs.len)
		var/turf/checked_turf = turfs[i]

		// Do not touch station airlocks
		if (!shuttle_areas[get_area(checked_turf)])
			continue

		for(var/obj/machinery/door/airlock/airlock_door in checked_turf)
			if(airlock_door.external)
				airlock_door.close(force_crush = TRUE)
				airlock_door.bolt()
				// If airlock is controlled - bolt all airlocks with same id, to avoid different bolt state on airlocks binded to same button
				if(airlock_door.id_tag)
					// Let non-external airlocks after us know, that they should bolt themself
					airlock_cache[airlock_door.id_tag] = TRUE
					// For every non-external airlock that we already iterated through
					for(var/obj/machinery/door/airlock/synced_door in airlock_cache)
						if (synced_door.id_tag == airlock_door.id_tag)
							synced_door.close(force_crush = TRUE)
							synced_door.bolt()
							airlock_cache -= synced_door

			// If we are non-external, but we having id - there is possibility of external airlock with same id, if so - we want be bolted too
			// That is needed to avoid different bolt state on airlocks binded to same button
			else if(airlock_door.id_tag)
				// It already was external airlock with same id
				if(airlock_cache[airlock_door.id_tag])
					airlock_door.close(force_crush = TRUE)
					airlock_door.bolt()
					continue
				// There was none, so let it handle our bolting, if there will be any external at all
				airlock_cache += airlock_door

/obj/docking_port/mobile/proc/unbolt_all_doors()
	var/list/turfs = return_ordered_turfs(x, y, z, dir)
	for(var/i in 1 to turfs.len)
		var/turf/checked_turf = turfs[i]

		// Do not touch station airlocks
		if (!shuttle_areas[get_area(checked_turf)])
			continue

		for(var/obj/machinery/door/airlock/airlock_door in checked_turf)
			// Do not unbolt button controlled exits
			if(airlock_door.external && !airlock_door.id_tag)
				airlock_door.unbolt()

/obj/docking_port/mobile/proc/play_engine_sound(atom/distant_source, takeoff)
	if(distant_source)
		for(var/mob/hearing_mob in range(sound_range, distant_source))
			if(hearing_mob?.client)
				var/dist = get_dist(hearing_mob.loc, distant_source.loc)
				var/vol = clamp(40 - ((dist - 3) * 5), 0, 40) // Every tile decreases sound volume by 5
				if(takeoff)
					if(hearing_mob.client?.prefs?.read_preference(/datum/preference/toggle/sound_ship_ambience))
						hearing_mob.playsound_local(distant_source, takeoff_sound, vol)
				else
					if(hearing_mob.client?.prefs?.read_preference(/datum/preference/toggle/sound_ship_ambience))
						hearing_mob.playsound_local(distant_source, landing_sound, vol)

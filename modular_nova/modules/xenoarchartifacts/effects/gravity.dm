#define GRAVITY_PULL 0
#define GRAVITY_REPEL 1
#define GRAVITY_MAYHEM 2

/datum/artifact_effect/gravity
	log_name = "Gravity"
	var/grav_type

/datum/artifact_effect/gravity/New()
	. = ..()
	trigger = TRIGGER_TOUCH
	release_method = ARTIFACT_EFFECT_PULSE
	type_name = ARTIFACT_EFFECT_BLUESPACE
	grav_type = pick(GRAVITY_PULL, GRAVITY_REPEL, GRAVITY_MAYHEM)
	maximum_charges = rand(4,10)
	activation_pulse_cost = maximum_charges

/datum/artifact_effect/gravity/DoEffectPulse()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	switch(grav_type)
		if (GRAVITY_MAYHEM)
			for(var/atom/movable/to_throw in range(range, curr_turf))
				mayhem_throw(to_throw, curr_turf, 1)
		if (GRAVITY_REPEL)
			for(var/atom/movable/to_throw in range(range, curr_turf))
				repel(to_throw, curr_turf)
		if (GRAVITY_PULL)
			for(var/atom/movable/to_throw in range(range, curr_turf))
				grav_pull(to_throw, curr_turf)


/datum/artifact_effect/gravity/proc/repel(atom/to_repel, turf/our_turf)
	var/protection = get_anomaly_protection(to_repel)
	if(ishuman(to_repel) && !get_anomaly_protection(to_repel))
		return
	if (istype(to_repel, /obj))
		var/obj/test_anchored = to_repel
		if(test_anchored.anchored)
			return
	var/turfs_to_step = 0
	turfs_to_step = round(protection * 16 / 2) // 8 turfs max range with no protection
	while(turfs_to_step > 0)
		step_away(to_repel, our_turf)
		turfs_to_step--

/datum/artifact_effect/gravity/proc/grav_pull(atom/to_pull, turf/T)
	var/protection = get_anomaly_protection(to_pull)
	if(ishuman(to_pull) && !get_anomaly_protection(to_pull))
		return
	if (istype(to_pull, /obj))
		var/obj/test_anchored = to_pull
		if(test_anchored.anchored)
			return
	var/turfs_to_step = 0
	turfs_to_step = round(protection * 16 / 2) // 8 turfs max range with no protection
	while(turfs_to_step > 0)
		step_towards(to_pull, T)
		turfs_to_step--

/datum/artifact_effect/gravity/proc/mayhem_throw(atom/to_throw, turf/T, amplifier)
	var/protection = get_anomaly_protection(to_throw)
	if(!protection)
		return
	if (istype(to_throw, /obj))
		var/obj/test_anchored = to_throw
		if(test_anchored.anchored)
			return
	var/throw_power = maximum_charges * 2
	var/atom/movable/throw_atom = to_throw
	var/turf/target_turf = pick(orange(get_turf(holder), range * 2 * protection))
	if(!QDELETED(throw_atom))
		throw_atom.throw_at(target_turf, 10 * protection * amplifier, throw_power * protection * amplifier/2)

/datum/artifact_effect/gravity/DoEffectDestroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/atom/movable/to_throw in range(range, curr_turf))
		mayhem_throw(to_throw, curr_turf, 2)


#undef GRAVITY_PULL
#undef GRAVITY_REPEL
#undef GRAVITY_MAYHEM

/datum/artifact_effect/sleepy
	log_name = "Sleepy"

/datum/artifact_effect/sleepy/New()
	. = ..()
	type_name = pick(ARTIFACT_EFFECT_PSIONIC, ARTIFACT_EFFECT_ORGANIC)

/datum/artifact_effect/sleepy/DoEffectTouch(mob/user)
	. = ..()
	if(!.)
		return
	apply_sleepy(user, 25)

/datum/artifact_effect/sleepy/DoEffectAura()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/carbon/carbon_mob in range(range, curr_turf))
		if(prob(50))
			apply_sleepy(carbon_mob, 5)

/datum/artifact_effect/sleepy/DoEffectPulse()
	. = ..()
	if(!.)
		return
	var/used_power = .
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/carbon/carbon_mob in range(range, curr_turf))
		apply_sleepy(carbon_mob, used_power)


/datum/artifact_effect/sleepy/DoEffectDestroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/carbon/carbon_mob in range(7, curr_turf))
		var/weakness = get_anomaly_protection(carbon_mob)
		if(!weakness)
			continue
		carbon_mob.SetSleeping(weakness * (10 SECONDS)) //0 resistance gives you 10 seconds of sleep

/datum/artifact_effect/sleepy/proc/apply_sleepy(mob/receiver, power)
	if(ishuman(receiver) && !issilicon(receiver))
		var/mob/living/carbon/human/human_mob = receiver
		var/weakness = get_anomaly_protection(human_mob)
		if(!weakness)
			return
		to_chat(human_mob, pick(
			span_notice("You feel like taking a nap."),
			span_notice("You feel a yawn coming on."),
			span_notice("You feel a little tired."),
		))
		human_mob.adjust_dizzy_up_to(30 SECONDS, 120 SECONDS)
		human_mob.Sleeping(power * weakness * 10)
	if(issilicon(receiver))
		to_chat(receiver, "<span class='warning'>SYSTEM ALERT: Anomalous process with PID [rand(0,9999)] slows down the CPU.</span>")

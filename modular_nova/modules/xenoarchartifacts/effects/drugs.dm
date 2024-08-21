/datum/artifact_effect/drugs
	log_name = "Hallucinations"

/datum/artifact_effect/drugs/New()
	..()
	type_name = pick(ARTIFACT_EFFECT_PSIONIC, ARTIFACT_EFFECT_ORGANIC)

/datum/artifact_effect/drugs/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	do_drugs(user, 60)
	to_chat(user, span_hypnophrase("I feel so chill."))

/datum/artifact_effect/drugs/do_effect_aura()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/L in range(range, curr_turf))
		if(!prob(20))
			continue
		do_drugs(L, 20)
		to_chat(L, span_hypnophrase("I feel good, like really good."))

/datum/artifact_effect/drugs/do_effect_pulse()
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/L in range(range, curr_turf))
		if(!prob(50))
			continue
		do_drugs(L, 40)
		to_chat(L, span_hypnophrase("Things here are nice. Maybe I should come here more often."))

/datum/artifact_effect/drugs/do_effect_destroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/L in range(range+3, curr_turf))
		do_drugs(L, 120)
		to_chat(L, span_hypnophrase("Duuuude, I feel so transcendent."))

/datum/artifact_effect/drugs/proc/do_drugs(mob/receiver, power)
	var/weakened = get_anomaly_protection(receiver)
	if(!weakened)
		return FALSE
	if(!ishuman(receiver))
		return FALSE
	var/mob/living/carbon/C = receiver
	C.set_drugginess(power SECONDS * weakened)
	return TRUE

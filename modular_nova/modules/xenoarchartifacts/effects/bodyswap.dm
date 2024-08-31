// Picks 2 random humans in range and swaps their mind, similarly to the mage spell
/datum/artifact_effect/bodyswap
	log_name = "bodyswap"
	type_name = ARTIFACT_EFFECT_PSIONIC

/datum/artifact_effect/bodyswap/New()
	. = ..()
	release_method = ARTIFACT_EFFECT_PULSE
	range = rand(2,5)

/datum/artifact_effect/bodyswap/do_effect_pulse()
	. = ..()
	if(!.)
		return
	SwapBodies(0)

/datum/artifact_effect/bodyswap/do_effect_destroy()
	SwapBodies(5)

/**
 * Selects 2 random carbons in artifact range and swaps their minds.
 * Gives mind to those, who dont have it(monkeys)
 *
 * Arguments:
 * * add_range - bonus range to the base artifact's
 */
/datum/artifact_effect/bodyswap/proc/SwapBodies(add_range)
	var/turf/curr_turf = get_turf(holder)
	var/list/poor_humans = list()
	for(var/mob/living/carbon/carbon_mob in range(range + add_range, curr_turf))
		poor_humans.Add(carbon_mob)

	if(length(poor_humans) < 2)
		return FALSE

	// Stolen from mage spell
	var/mob/living/carbon/caster = pick_n_take(poor_humans)
	var/mob/living/carbon/to_swap = pick_n_take(poor_humans)

	if(!caster || !to_swap)
		return FALSE

	var/weakness_caster = get_anomaly_protection(caster)
	var/weakness_to_swap = get_anomaly_protection(to_swap)
	// 0 = full protection on both
	// 2 = zero protection summary
	if(weakness_caster + weakness_to_swap <= 1) { // Either one is fully protected, or they have total protection <= 1
		to_chat(caster, span_warning("You feel like you've just dodged a bullet."))
		to_chat(to_swap, span_warning("You feel like you've just dodged a bullet."))
		return FALSE
	}

	// Gives the target a mind if they don't have one
	if(!to_swap.mind)
		to_swap.mind_initialize()
	if(!caster.mind)
		to_swap.mind_initialize()

	var/datum/mind/mind_to_swap = to_swap.mind
	if(to_swap.can_block_magic(MAGIC_RESISTANCE_MIND) \
		|| mind_to_swap.has_antag_datum(/datum/antagonist/wizard) \
		|| mind_to_swap.has_antag_datum(/datum/antagonist/cult) \
		|| mind_to_swap.has_antag_datum(/datum/antagonist/changeling) \
		|| mind_to_swap.has_antag_datum(/datum/antagonist/rev) \
		|| mind_to_swap.key?[1] == "@" \
	)
		holder.balloon_alert(to_swap, "fizzles out!")
		holder.balloon_alert(caster, "fizzles out!")
		return FALSE

	// MIND TRANSFER BEGIN

	var/datum/mind/caster_mind = caster.mind
	var/datum/mind/to_swap_mind = to_swap.mind

	if(!caster_mind || !to_swap_mind)
		return FALSE

	var/to_swap_key = to_swap.key

	caster_mind.transfer_to(to_swap)
	to_swap_mind.transfer_to(caster)

	// Just in case the swappee's key wasn't grabbed by transfer_to...
	if(to_swap_key)
		caster.key = to_swap_key

	// MIND TRANSFER END

	// No stun, no sleep. Instant change for them to figure out
	// Also completely silent for everyone not affected
	// Should create some interesting situations >:)

	// Only the caster and victim hear the sounds,
	// that way no one knows for sure if the swap happened
	SEND_SOUND(caster, sound('sound/magic/mandswap.ogg'))
	SEND_SOUND(to_swap, sound('sound/magic/mandswap.ogg'))

	return TRUE

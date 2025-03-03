/datum/status_effect/incapacitating/sleeping
	show_duration = TRUE
	///If set to TRUE, the affected mob can resist to wake up.
	var/voluntary = FALSE

/datum/status_effect/incapacitating/sleeping/on_creation(mob/living/new_owner, set_duration, is_voluntary = FALSE)
	voluntary = is_voluntary
	// Hide sleep duration if permanent
	if(set_duration == -1)
		show_duration = FALSE
	return ..()

// Prolongs sleep indefinitely when the client disconnects
/datum/status_effect/incapacitating/sleeping/tick(seconds_between_ticks)
	. = ..()
	if(!isnull(owner.lastKnownIP) && isnull(owner.client))
		pause_expiry = TRUE
	else
		pause_expiry = FALSE

/atom/movable/screen/alert/status_effect/asleep
	desc = "You've fallen asleep. Wait a bit and you should wake up. Resist or click here to wake up from voluntary naps."

// Wakes mob from sleep if the sleep verb was used
/atom/movable/screen/alert/status_effect/asleep/Click()
	. = ..()
	if(!.)
		return
	var/mob/living/living_owner = owner
	if(!istype(living_owner) || !living_owner.can_resist())
		return
	var/datum/status_effect/incapacitating/sleeping/sleep_effect = attached_effect
	if(sleep_effect.voluntary)
		living_owner.SetSleeping(0)

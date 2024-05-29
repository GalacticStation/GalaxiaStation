/datum/round_event_control/can_spawn_event(players_amt, allow_magic = FALSE)
	SHOULD_CALL_PARENT(TRUE)
	. = ..()
	if(intensity_restriction && !GLOB.intense_event_credits)
		return FALSE

/datum/round_event_control/run_event(random = FALSE, announce_chance_override = null, admin_forced = FALSE, event_cause)
	. = ..()
	log_game("ICES: [src.name] is our next event.")
	if(intensity_restriction && GLOB.intense_event_credits)
		GLOB.intense_event_credits--
		log_game("ICES: [src.name] consumed an intensity credit. Intensity credit count: [GLOB.intense_event_credits] credits")
		message_admins("ICES: [src.name] consumed an intensity credit. Intensity credit count: [GLOB.intense_event_credits] credits")
	else if(intensity_restriction)
		log_game("ICES: [src.name] should consume an intensity credit, but didn't! Maybe it was admin forced. Intensity credit count: [GLOB.intense_event_credits] credits")
		message_admins("ICES: [src.name] consumed an intensity credit. Intensity credit count: [GLOB.intense_event_credits] credits")
	else
		log_game("ICES: [src.name] does not need an intensity credit. Intensity credit count: [GLOB.intense_event_credits] credits")
		message_admins("ICES: [src.name] does not need an intensity credit. Intensity credit count: [GLOB.intense_event_credits] credits")

/datum/round_event_control/Topic(href, href_list)
	. = ..()
	if(href_list["something_else"])
		if(!triggering)
			to_chat(usr, span_admin("Too late! The event is running."))
			return
		triggering = FALSE
		SSevents.spawnEvent(threat_override = TRUE)
		message_admins("[key_name_admin(usr)] requested a new event be spawned instead of [name].")
		log_admin_private("[key_name(usr)] requested a new event be spawned instead of [name].")

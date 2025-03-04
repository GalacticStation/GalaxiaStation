ADMIN_VERB(admin_stasis, R_ADMIN, "Toggle Admin Stasis", "Toggles admin stasis for a living mob.", ADMIN_CATEGORY_GAME)
	var/mob/living/target_mob = user.mob
	if (!isliving(target_mob))
		target_mob = tgui_input_list(user, "Select a mob to toggle admin stasis", "Pick a Living Mob", GLOB.alive_mob_list)
		if(isnull(target_mob))
			return
	var/has_effect = !isnull(target_mob.has_status_effect_from_source(/datum/status_effect/grouped/stasis, STASIS_ADMIN))
	if(has_effect)
		target_mob.remove_status_effect(/datum/status_effect/grouped/stasis, STASIS_ADMIN)
	else
		target_mob.apply_status_effect(/datum/status_effect/grouped/stasis, STASIS_ADMIN)
	var/stasis_status = has_effect ? "OFF" : "ON"
	to_chat(user, "You toggled admin stasis [stasis_status] for [target_mob].", confidential = TRUE)
	message_admins("[key_name_admin(user)] has toggled admin stasis [stasis_status] for [target_mob].")
	log_admin("[key_name(user)] has toggled admin stasis [stasis_status] for [target_mob].")

/datum/emote
	specific_emote_audio_cooldown = 0 SECONDS
	/// Emote volume
	var/sound_volume = 25
	/// What species can use this emote?
	var/list/allowed_species

/datum/emote/proc/check_config()
	return TRUE

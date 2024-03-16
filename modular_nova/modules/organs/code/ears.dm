/obj/item/organ/internal/ears/teshari
	name = "teshari ears"
	desc = "A set of four long rabbit-like ears, a Teshari's main tool while hunting."
	damage_multiplier = 2
	actions_types = list(/datum/action/cooldown/spell/teshari_hearing)

/obj/item/organ/internal/ears/teshari/on_mob_remove(mob/living/carbon/ear_owner)
	. = ..()
	REMOVE_TRAIT(ear_owner, TRAIT_GOOD_HEARING, ORGAN_TRAIT)

/datum/action/cooldown/spell/teshari_hearing
	name = "Toggle Sensitive Hearing"
	desc = "Perk up your ears to listen for quiet sounds, such as whispering."
	button_icon = 'modular_nova/master_files/icons/hud/actions.dmi'
	button_icon_state = "echolocation_off"
	var/active = FALSE

	cooldown_time = 1 SECONDS
	spell_requirements = NONE

/datum/action/cooldown/spell/teshari_hearing/proc/update_button_state(new_state)
	button_icon_state = new_state
	owner.update_action_buttons()

/datum/action/cooldown/spell/teshari_hearing/Remove(mob/living/remove_from)
	REMOVE_TRAIT(remove_from, TRAIT_GOOD_HEARING, ORGAN_TRAIT)
	remove_from.update_sight()
	return ..()

/datum/action/cooldown/spell/teshari_hearing/cast(list/targets, mob/living/carbon/human/user = usr)
	. = ..()

	if(HAS_TRAIT(user, TRAIT_GOOD_HEARING))
		teshari_hearing_deactivate(user)
		return

	user.apply_status_effect(/datum/status_effect/teshari_hearing)
	user.visible_message(span_notice("[user], pricks up [user.p_their()] four ears, each twitching intently!"), span_notice("You perk up all four of your ears, hunting for even the quietest sounds."))
	update_button_state("echolocation_on")
	active = TRUE

/datum/action/cooldown/spell/teshari_hearing/proc/teshari_hearing_deactivate(mob/living/carbon/human/user)
	if(!HAS_TRAIT_FROM(user, TRAIT_GOOD_HEARING, ORGAN_TRAIT))
		return

	user.remove_status_effect(/datum/status_effect/teshari_hearing)
	user.visible_message(span_notice("[user] drops [user.p_their()] ears down a bit, no longer listening as closely."), span_notice("You drop your ears down, no longer paying close attention."))
	update_button_state("echolocation_off")
	active = FALSE

/datum/status_effect/teshari_hearing
	id = "teshari_hearing"
	alert_type = null
	status_type = STATUS_EFFECT_UNIQUE

/datum/status_effect/teshari_hearing/on_apply()
	ADD_TRAIT(owner, TRAIT_GOOD_HEARING, ORGAN_TRAIT)
	return ..()

/datum/status_effect/teshari_hearing/on_remove()
	REMOVE_TRAIT(owner, TRAIT_GOOD_HEARING, ORGAN_TRAIT)
	return ..()

/datum/status_effect/teshari_hearing/get_examine_text()
	return span_notice("[owner.p_They()] [owner.p_have()] [owner.p_their()] ears perked up, listening closely to even whisper-quiet sounds.")

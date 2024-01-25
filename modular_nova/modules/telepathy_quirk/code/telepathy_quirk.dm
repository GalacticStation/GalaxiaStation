/datum/quirk/telepathic
	name = "Telepathic"
	desc = "You are able to transmit your thoughts to other living creatures."
	gain_text = span_purple("Your mind roils with psychic energy.")
	lose_text = span_notice("Mundanity encroaches upon your thoughts once again.")
	medical_record_text = "Patient has an unusually enlarged Broca's area visible in cerebral biology, and appears to be able to communicate via extrasensory means."
	value = 0
	icon = FA_ICON_HEAD_SIDE_COUGH

/datum/quirk/telepathic/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder

	if (!human_holder.dna.activate_mutation(/datum/mutation/human/telepathy))
		human_holder.dna.add_mutation(/datum/mutation/human/telepathy, MUT_OTHER)

/datum/quirk/telepathic/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.dna.remove_mutation(/datum/mutation/human/telepathy)

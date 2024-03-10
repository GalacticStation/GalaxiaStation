/datum/quirk/item_quirk/anosmia
	name = "Anosmia"
	desc = "For some reasons you can't smell the smells."
	icon = FA_ICON_HEAD_SIDE_COUGH_SLASH
	value = 0
	mob_trait = TRAIT_ANOSMIA
	gain_text = span_notice("You suddenly notice the lack of smells, Your nose doesn't seem to work.")
	lose_text = span_danger("Your nose seemed to clear up, and you begin to smell things around you!")
	medical_record_text = "Patient lost the the sensation of smell."

//leave there code for asomnia work
//var/list/asomnia_hadders = get_hearers_in_view(vision_distance, src)
//for(var/mob/M in asomnia_hadders)
//	if(!HAS_TRAIT(M, TRAIT_ANOSMIA))
//		asomnia_hadders -= M

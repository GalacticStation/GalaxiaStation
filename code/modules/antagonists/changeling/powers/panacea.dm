/datum/action/changeling/panacea
	name = "Anatomic Panacea"
	desc = "Expels impurifications from our form; curing diseases, removing parasites, sobering us, purging toxins and radiation, curing traumas and brain damage, and resetting our genetic code completely. Costs 20 chemicals."
	helptext = "Can be used while unconscious."
	button_icon_state = "panacea"
	chemical_cost = 20
	dna_cost = 1
	req_stat = HARD_CRIT

//Heals the things that the other regenerative abilities don't.
/datum/action/changeling/panacea/sting_action(mob/user)
	to_chat(user, span_notice("We cleanse impurities from our form."))
	..()
	var/list/bad_organs = list(
<<<<<<< HEAD
		user.get_organ_by_type(/obj/item/organ/internal/empowered_borer_egg), // NOVA EDIT ADDITION
		user.get_organ_by_type(/obj/item/organ/internal/body_egg),
		user.get_organ_by_type(/obj/item/organ/internal/legion_tumour),
		user.get_organ_by_type(/obj/item/organ/internal/zombie_infection),
=======
		user.get_organ_by_type(/obj/item/organ/body_egg),
		user.get_organ_by_type(/obj/item/organ/legion_tumour),
		user.get_organ_by_type(/obj/item/organ/zombie_infection),
>>>>>>> 778ed9f1ab... The death or internal/external organ pathing (ft. fixed fox ears and recoloring bodypart overlays with dye sprays) (#87434)
	)


	try_to_mutant_cure(user) //NOVA EDIT ADDITION

	for(var/o in bad_organs)
		var/obj/item/organ/O = o
		if(!istype(O))
			continue

		O.Remove(user)
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			C.vomit(VOMIT_CATEGORY_DEFAULT, lost_nutrition = 0)
		O.forceMove(get_turf(user))
	//NOVA EDIT Start: Cortical Borer
	var/mob/living/basic/cortical_borer/cb_inside = user.has_borer()
	if(cb_inside)
		cb_inside.leave_host()
	//NOVA EDIT Stop: Cortical Borer
	user.reagents.add_reagent(/datum/reagent/medicine/mutadone, 10)
	user.reagents.add_reagent(/datum/reagent/medicine/pen_acid, 20)
	user.reagents.add_reagent(/datum/reagent/medicine/antihol, 10)
	user.reagents.add_reagent(/datum/reagent/medicine/mannitol, 25)

	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.cure_all_traumas(TRAUMA_RESILIENCE_LOBOTOMY)

	if(isliving(user))
		var/mob/living/L = user
		for(var/thing in L.diseases)
			var/datum/disease/D = thing
			if(D.severity == DISEASE_SEVERITY_POSITIVE)
				continue
			D.cure()
	return TRUE

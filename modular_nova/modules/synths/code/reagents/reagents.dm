#define NANITE_SLURRY_ORGANIC_PURGE_RATE 4
#define NANITE_SLURRY_ORGANIC_VOMIT_CHANCE 25

/datum/reagent/medicine/syndicate_nanites //Used exclusively by Syndicate medical cyborgs
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //Let's not cripple synth ops

/datum/reagent/medicine/stimulants
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //Syndicate developed 'accelerants' for synths?

/datum/reagent/medicine/leporazine
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/flightpotion
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

// REAGENTS FOR SYNTHS

/datum/reagent/medicine/system_cleaner
	name = "System Cleaner"
	description = "Neutralizes harmful chemical compounds inside synthetic systems and refreshes system software."
	color = "#F1C40F"
	taste_description = "ethanol"
	metabolization_rate = 2 * REAGENTS_METABOLISM
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC
	affected_biotype = MOB_ROBOTIC

/datum/reagent/medicine/system_cleaner/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	affected_mob.adjustToxLoss(-2 * REM * seconds_per_tick, 0, required_biotype = affected_biotype)
	affected_mob.adjust_disgust(-5 * REM * seconds_per_tick)
	var/remove_amount = 1 * REM * seconds_per_tick;
	for(var/thing in affected_mob.reagents.reagent_list)
		var/datum/reagent/reagent = thing
		if(reagent != src)
			affected_mob.reagents.remove_reagent(reagent.type, remove_amount)
	..()
	return TRUE

/datum/reagent/medicine/liquid_solder
	name = "Liquid Solder"
	description = "Repairs brain damage in synthetics."
	color = "#727272"
	taste_description = "metal"
	// Processes in organics too but only functions on synthetic brains
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC
	affected_organ_flags = ORGAN_ROBOTIC

/datum/reagent/medicine/liquid_solder/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick)
	affected_mob.adjustOrganLoss(ORGAN_SLOT_BRAIN, -3 * REM * seconds_per_tick, required_organ_flag = affected_organ_flags)
	if(prob(10))
		var/obj/item/organ/brain/owner_brain = affected_mob.get_organ_slot(ORGAN_SLOT_BRAIN)
		if(!owner_brain || !(owner_brain.organ_flags & affected_organ_flags))
			return ..()
		affected_mob.cure_trauma_type(resilience = TRAUMA_RESILIENCE_BASIC)
	return ..()

/datum/reagent/medicine/nanite_slurry
	name = "Nanite Slurry"
	description = "A localized swarm of nanomachines specialized in repairing mechanical parts. Due to the nanites needing to interface with the host's systems to repair them, a surplus of them will cause them to overheat, or for the swarm to forcefully eject out of the mouth of organics for safety."
	color = "#cccccc"
	overdose_threshold = 20
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	process_flags = REAGENT_SYNTHETIC | REAGENT_ORGANIC
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	affected_bodytype = BODYTYPE_ROBOTIC
	affected_biotype = MOB_ROBOTIC
	/// How much brute and burn individually is healed per tick
	var/healing = 3
	/// How much body temperature is increased by per overdose cycle on robotic bodyparts.
	var/temperature_change = 50


/datum/reagent/medicine/nanite_slurry/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick)
	var/heal_amount = healing * REM * seconds_per_tick
	affected_mob.heal_bodypart_damage(heal_amount, heal_amount, required_bodytype = affected_bodytype)
	return ..()

/datum/reagent/medicine/nanite_slurry/overdose_process(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(affected_mob.mob_biotypes & affected_biotype)
		affected_mob.adjust_bodytemperature(temperature_change * REM * seconds_per_tick)
		return ..()
	affected_mob.reagents.remove_reagent(type, NANITE_SLURRY_ORGANIC_PURGE_RATE) //gets removed from organics very fast
	if(prob(NANITE_SLURRY_ORGANIC_VOMIT_CHANCE))
		affected_mob.vomit(vomit_flags = (MOB_VOMIT_MESSAGE | MOB_VOMIT_HARM), vomit_type = /obj/effect/decal/cleanable/vomit/nanites)
	return TRUE

#undef NANITE_SLURRY_ORGANIC_PURGE_RATE
#undef NANITE_SLURRY_ORGANIC_VOMIT_CHANCE

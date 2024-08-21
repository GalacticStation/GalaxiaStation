/datum/artifact_effect/celldrain
	log_name = "Cell Drain"
	type_name = ARTIFACT_EFFECT_ELECTRO

/datum/artifact_effect/celldrain/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	for(var/obj/item/stock_parts/power_store/cell in user.contents)
		cell.use(1e10) // uh oh
		if(issilicon(user))
			to_chat(user, span_notice("SYSTEM ALERT: Massive energy drain detected!"))

/datum/artifact_effect/celldrain/do_effect_aura()
	. = ..()
	if(!.)
		return
	discharge_everything_in_range(500000, range, holder)

/datum/artifact_effect/celldrain/do_effect_pulse()
	. = ..()
	if(!.)
		return
	var/used_power = .
	discharge_everything_in_range(25000 * used_power, range, holder)

/datum/artifact_effect/celldrain/do_effect_destroy()
	discharge_everything_in_range(1000000000, 10, holder) // Massive uh oh

/datum/artifact_effect/celldrain/proc/try_use_charge(atom/reciever_atmon, power)
	if(istype(reciever_atmon, /obj/item/stock_parts/power_store))
		var/obj/item/stock_parts/power_store/cell = reciever_atmon
		cell.use(power)
	if(istype(reciever_atmon, /obj/machinery/power/apc))
		for(var/obj/item/stock_parts/power_store/cell in reciever_atmon.contents)
			cell.use(power)
	if(istype(reciever_atmon, /obj/machinery/power/smes))
		var/obj/machinery/power/smes/unlucky = reciever_atmon
		unlucky.charge -= power
	if(istype(reciever_atmon, /obj/item/gun/energy))
		for(var/obj/item/stock_parts/power_store/cell in reciever_atmon.contents)
			cell.use(power)
	if(istype(reciever_atmon, /obj/item/gun/energy))
		for(var/obj/item/stock_parts/power_store/cell in reciever_atmon.contents)
			cell.use(power)
	if(istype(reciever_atmon, /obj/item/mod/control))
		var/obj/item/mod/control/unluckymod = reciever_atmon
		for(var/obj/item/mod/core/unluckycore in unluckymod.contents)
			for(var/obj/item/stock_parts/power_store/cell in unluckycore.contents)
				cell.use(power)
	if(issilicon(reciever_atmon))
		for(var/obj/item/stock_parts/power_store/cell in reciever_atmon.contents)
			cell.use(power)
		to_chat(reciever_atmon, span_warning("SYSTEM ALERT: Energy drain detected!"))

/datum/artifact_effect/celldrain/proc/discharge_everything_in_range(power, range, center)
	var/turf/curr_turf = get_turf(holder)
	var/list/captured_atoms = range(range, curr_turf)
	for(var/atom/A in captured_atoms)
		try_use_charge(A, power)

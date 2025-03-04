/**
 * Check if this holder contains a reagent with a `chemical_flags_nova` containing this flag.
 *
 * Arguments:
 * * chemical_flag - The bitflag to search for.
 * * min_volume - Checks for having a specific amount of reagents matching that `chemical_flag`
 */
/datum/reagents/proc/has_chemical_flag_nova(chemical_flag, min_volume = 0)
	var/found_amount = 0
	var/list/cached_reagents = reagent_list
	for(var/datum/reagent/holder_reagent as anything in cached_reagents)
		if (holder_reagent.chemical_flags_nova & chemical_flag)
			found_amount += holder_reagent.volume
			if(found_amount >= min_volume)
				return TRUE

	return FALSE

/**
 * Proportionally transfers each reagent to the target atom. Calls trans_to() to do the actual transfer.
 * Unlike trans_to(), target_id is replaced with list target_ids.
 *
 * Arguments:
 * * obj/target - Target atom to attempt transfers to
 * * amount - Maximum total reagent volume to transfer
 * * multiplier - multiplies each reagent amount by this number well byond their available volume before transfering. used to create reagents from thin air if you ever need to
 * * list/datum/reagent/target_ids - transfers only the listed reagent types in this holder leaving others untouched
 * * preserve_data - if preserve_data=FALSE, the reagents data will be lost. Usefull if you use data for some strange stuff and don't want it to be transferred.
 * * no_react - passed through to [/datum/reagents/proc/add_reagent]
 * * mob/transferred_by - used for logging
 * * remove_blacklisted - skips transferring of reagents without REAGENT_CAN_BE_SYNTHESIZED in chemical_flags
 * * methods - passed through to [/datum/reagents/proc/expose] and [/datum/reagent/proc/on_transfer]
 * * show_message - passed through to [/datum/reagents/proc/expose]
 * * ignore_stomach - when using methods INGEST will not use the stomach as the target
 */
/datum/reagents/proc/trans_to_multiple(
	atom/target_atom,
	amount = 1,
	multiplier = 1,
	list/datum/reagent/target_ids,
	preserve_data = TRUE,
	no_react = FALSE,
	mob/transferred_by,
	remove_blacklisted = FALSE,
	methods = NONE,
	show_message = TRUE,
	ignore_stomach = FALSE,
)
	// Nothing to transfer, or the targeted atom can't hold reagents
	if(!total_volume || QDELETED(target_atom) || isnull(target_atom.reagents))
		return FALSE

	if(!IS_FINITE(amount))
		stack_trace("non-number or infinite number passed to trans_to_equal: amount = [amount]")
		return FALSE

	// Ensure given amount is in a safe range
	amount = round(amount, CHEMICAL_QUANTISATION_LEVEL)
	if(amount <= 0)
		return FALSE

	// Maximum amount of reagents which can fit inside the target
	var/max_volume = min(amount, target_atom.reagents.maximum_volume)
	// Total volume of fillable empty space inside the target, accounting for given maximum
	var/empty_volume = max(0, max_volume - target_atom.reagents.total_volume)

	// Targeted atom is already full of reagents
	if(max_volume == 0 || empty_volume == 0)
		return FALSE

	// Total volume of transferable reagents after whitelisting and rounding
	var/possible_transfer_volume = 0
	// Only FALSE if a reagent whitelist was given
	var/ignore_whitelist = isnull(target_ids)
	// Associative list of reagent typepaths to datums
	var/list/datum/reagent/target_reagents = list()
	var/list/cached_reagents = reagent_list
	// Perform whitelisting, then calculate total possible transfer volume
	for(var/datum/reagent/reagent as anything in cached_reagents)
		if(remove_blacklisted && !(reagent.chemical_flags & REAGENT_CAN_BE_SYNTHESIZED))
			continue
		if(ignore_whitelist || is_type_in_list(reagent, target_ids) && reagent.volume)
			target_reagents[reagent.type] = reagent
			possible_transfer_volume += reagent.volume

	// There are no transferable reagents
	if(!length(target_reagents) || !possible_transfer_volume)
		return FALSE

	// Associative list of reagent typepaths to transfer volumes
	// Used to provide reagent transfer amounts to trans_to()
	var/list/transfer_volumes = list()
	// Calculate proportional transfer volumes per reagent
	// Account for reagents with insufficient and excess volumes
	for(var/reagent_type as anything in target_reagents)
		var/datum/reagent/reagent = target_reagents[reagent_type]
		var/distributed_volume = round(reagent.volume / possible_transfer_volume, CHEMICAL_QUANTISATION_LEVEL)
		transfer_volumes[reagent.type] = empty_volume * distributed_volume

	// Actually perform the reagent transfers and return total volume transferred
	var/transfer_total = 0
	for(var/datum/reagent/reagent as anything in target_reagents)
		transfer_total += trans_to(
			target = target_atom,
			amount = transfer_volumes[reagent],
			target_id = reagent.type,
			preserve_data = preserve_data,
			no_react = no_react,
			transferred_by = transferred_by,
			remove_blacklisted = remove_blacklisted,
			methods = methods,
			show_message = show_message,
			ignore_stomach = ignore_stomach,
		)
	return transfer_total

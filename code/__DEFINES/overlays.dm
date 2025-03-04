// A reasonable number of maximum overlays an object needs
// If you think you need more, rethink it
#define SOFT_MAX_ATOM_OVERLAYS 100  // NOVA EDIT ADDITION - If we go over the soft cap, add to the runtime log
#define MAX_ATOM_OVERLAYS 120  // NOVA EDIT CHANGE - Temporarily increase this for debugging+preventing bugs with taur parts - ORIGINAL: #define MAX_ATOM_OVERLAYS 100

/// Checks if an atom has reached the overlay limit, and make a loud error if it does.
#define VALIDATE_OVERLAY_LIMIT(changed_on, has_hit_overlay_limit) \
	if(length(changed_on.overlays) >= SOFT_MAX_ATOM_OVERLAYS) { \
		if(!changed_on.has_hit_overlay_limit) { \
			var/text_lays = overlays2text(changed_on.overlays); \
			stack_trace("Too many overlays on [changed_on.type] - [length(changed_on.overlays)], please investigate why this might be happening!\
				\n What follows is a printout of all existing overlays at the time of the overflow \n[text_lays]"); \
			changed_on.has_hit_overlay_limit = TRUE; \
		} \
		if(length(changed_on.overlays) >= MAX_ATOM_OVERLAYS) { \
			var/text_lays = overlays2text(changed_on.overlays); \
			stack_trace("Hard overlap limit reached on [changed_on.type] - [length(changed_on.overlays)], refusing to update and cutting!\
				\n What follows is a printout of all existing overlays at the time of the overflow \n[text_lays]"); \
			changed_on.overlays.Cut(); \
			changed_on.add_overlay(mutable_appearance('icons/testing/greyscale_error.dmi')); \
			changed_on.has_hit_overlay_limit = FALSE; \
		} \
	} \


/// Performs any operations that ought to run after an appearance change
#define POST_OVERLAY_CHANGE(changed_on) \
	if(alternate_appearances) { \
		for(var/I in changed_on.alternate_appearances){\
			var/datum/atom_hud/alternate_appearance/AA = changed_on.alternate_appearances[I];\
			if(AA.transfer_overlays){\
				AA.copy_overlays(changed_on, TRUE);\
			}\
		} \
	}

/atom/
	/// Temporary anti-spam measure
	var/has_hit_overlay_limit

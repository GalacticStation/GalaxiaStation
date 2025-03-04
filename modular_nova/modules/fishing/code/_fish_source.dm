/datum/fish_source/New()
	..()

	if (!fish_count_regen)
		fish_count_regen = list()

	for(var/path in fish_counts)
		if (!(path in fish_count_regen))
			fish_count_regen[path] = 30 MINUTES

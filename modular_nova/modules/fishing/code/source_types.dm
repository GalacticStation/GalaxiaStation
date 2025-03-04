/datum/fish_source/lavaland/New()
	..()

	fish_table[/obj/item/skeleton_key] = 1
	fish_counts[/obj/item/skeleton_key] = 1
	fish_count_regen[/obj/item/skeleton_key] = 13 MINUTES
	fish_table[/obj/item/stack/sheet/mineral/runite] = 1
	fish_counts[/obj/item/stack/sheet/mineral/runite] = 2
	fish_count_regen[/obj/item/stack/sheet/mineral/runite] = 15 MINUTES

/datum/fish_source/lavaland/icemoon/New()
	..()

	fish_table[/obj/structure/closet/crate/necropolis/tendril] = 1
	fish_counts[/obj/structure/closet/crate/necropolis/tendril] = 1
	fish_count_regen[/obj/structure/closet/crate/necropolis/tendril] = 30 MINUTES
	fish_table[/obj/item/skeleton_key] = 1
	fish_counts[/obj/item/skeleton_key] = 1
	fish_count_regen[/obj/item/skeleton_key] = 15 MINUTES

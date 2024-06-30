/obj/machinery/space_heater/wall_mounted
	name = "mounted heater"
	desc = "A compact heating and cooling device for small scale applications, made to mount onto walls up and out of the way. \
		Like other, more free-standing space heaters however, these still require cell power to function."
	icon = 'modular_nova/modules/colony_fabricator/icons/space_heater.dmi'
	anchored = TRUE
	density = FALSE
	circuit = null
	heating_energy = STANDARD_CELL_RATE * 0.2
	efficiency = 40
	display_panel = TRUE
	/// What this repacks into when its wrenched off a wall
	var/repacked_type = /obj/item/wallframe/wall_heater

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/space_heater/wall_mounted, 29)

/obj/machinery/space_heater/wall_mounted/Initialize(mapload)
	. = ..()
	find_and_hang_on_wall()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	RemoveElement(/datum/element/elevation, pixel_shift = 8) //they're on the wall, you can't climb this
	RemoveElement(/datum/element/climbable)

/obj/machinery/space_heater/wall_mounted/RefreshParts()
	. = ..()
	heating_energy = STANDARD_CELL_RATE * 0.1
	efficiency = 40

/obj/machinery/space_heater/wall_mounted/default_deconstruction_crowbar()
	return

/obj/machinery/space_heater/wall_mounted/default_unfasten_wrench(mob/living/user, obj/item/wrench, time)
	user.balloon_alert(user, "deconstructing...")
	wrench.play_tool_sound(src)
	if(wrench.use_tool(src, user, 1 SECONDS))
		playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
		deconstruct(TRUE)
		return

/obj/machinery/space_heater/wall_mounted/on_deconstruction(disassembled)
	if(disassembled)
		new repacked_type(drop_location())
	cell.forceMove(drop_location())
	return ..()

// Wallmount for creating the heaters

/obj/item/wallframe/wall_heater
	name = "unmounted wall heater"
	desc = "A compact heating and cooling device for small scale applications, made to mount onto walls up and out of the way. \
		Like other, more free-standing space heaters however, these still require cell power to function."
	icon = 'modular_nova/modules/colony_fabricator/icons/space_heater.dmi'
	icon_state = "sheater-off"
	w_class = WEIGHT_CLASS_NORMAL
	result_path = /obj/machinery/space_heater/wall_mounted
	pixel_shift = 29
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 1,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT,
	)

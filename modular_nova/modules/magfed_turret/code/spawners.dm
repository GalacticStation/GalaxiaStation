/obj/effect/spawner/random/magturret
	name = "Random Magazine Turret"
	icon = 'modular_nova/modules/magfed_turret/icons/spawners.dmi'
	icon_state = "turret_spawner"
	loot = list(
		/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/outpost/malf,
		/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider,
		/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider/twin_fang,
		/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/duster,
		/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/toy
	)

/obj/effect/spawner/random/turretkit
	name = "Random Magazine Turret Kit"
	icon = 'modular_nova/modules/magfed_turret/icons/spawners.dmi'
	icon_state = "turretkit_spawner"
	loot = list(
		/obj/item/storage/toolbox/emergency/turret/mag_fed/outpost/pre_filled = 45,
		/obj/item/storage/toolbox/emergency/turret/mag_fed/duster/pre_filled = 20,
		/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/pre_filled = 20,
		/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang/pre_filled = 10,
		/obj/item/storage/toolbox/emergency/turret/mag_fed/toy = 5
	)

/obj/effect/spawner/random/throwturretkit
	name = "Random Throwable Turret Kit"
	icon = 'modular_nova/modules/magfed_turret/icons/spawners.dmi'
	icon_state = "throwkit_spawner"
	loot = list(
		/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/pre_filled = 70,
		/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang/pre_filled = 25,
		/obj/item/storage/toolbox/emergency/turret/mag_fed/toy = 5
	)

/obj/effect/spawner/random/turretassembly
	name = "Random Turret Assembly"
	icon = 'modular_nova/modules/magfed_turret/icons/spawners.dmi'
	icon_state = "assembly_spawner"
	loot = list(
		/obj/item/turret_assembly = 50,
		/obj/item/turret_assembly/twin_fang = 20,
		/obj/item/turret_assembly/duster = 30
	)

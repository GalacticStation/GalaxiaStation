//OUTFITS FOR NEW LEGION CORPSES
/datum/outfit/consumed_engineer
	name = "Legion-Consumed Engineer"
	uniform = /obj/item/clothing/under/rank/engineering/engineer
	mask = /obj/item/clothing/mask/breath
	head = /obj/item/clothing/head/utility/hardhat/welding/up
	shoes = /obj/item/clothing/shoes/workboots
	r_pocket = /obj/item/t_scanner
	belt = /obj/item/storage/belt/utility/full
	back = /obj/item/storage/backpack/industrial
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer,
		/obj/item/stack/rods/lava/ = 10,
	)

/datum/outfit/consumed_scientist
	name = "Legion-Consumed Scientist"
	uniform = /obj/item/clothing/under/rank/rnd/scientist
	suit = /obj/item/clothing/suit/toggle/labcoat/science
	mask = /obj/item/clothing/mask/breath
	belt = /obj/item/tank/internals/emergency_oxygen
	shoes = /obj/item/clothing/shoes/sneakers/white
	back = /obj/item/storage/backpack/science
	backpack_contents = list(
		/obj/item/storage/box/survival,
		/obj/item/clipboard,
		)

/datum/outfit/consumed_cargotech
	name = "Legion-Consumed Cargo-Tech"
	uniform = /obj/item/clothing/under/rank/cargo/tech
	suit = /obj/item/clothing/suit/toggle/cargo_tech
	mask = /obj/item/clothing/mask/breath
	belt = /obj/item/tank/internals/emergency_oxygen
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/sneakers/black
	backpack_contents = list(
		/obj/item/storage/box/survival,
		/obj/item/universal_scanner,
		/obj/item/boxcutter,
		)

/datum/outfit/consumed_cook
	name = "Legion-Consumed Cook"
	uniform = /obj/item/clothing/under/costume/buttondown/slacks/service
	suit = /obj/item/clothing/suit/toggle/chef
	mask = /obj/item/clothing/mask/breath
	belt = /obj/item/tank/internals/emergency_oxygen
	back = /obj/item/storage/backpack
	head = /obj/item/clothing/head/utility/chefhat
	shoes = /obj/item/clothing/shoes/sneakers/black
	backpack_contents = list(
		/obj/item/storage/box/survival,
		/obj/item/sharpener,
		)

/datum/outfit/consumed_doctor
	name = "Legion-Consumed Doctor"
	uniform = /obj/item/clothing/under/rank/medical/doctor
	suit = /obj/item/clothing/suit/toggle/labcoat
	suit_store = /obj/item/flashlight/pen
	mask = /obj/item/clothing/mask/breath
	belt = /obj/item/storage/belt/medical
	shoes = /obj/item/clothing/shoes/sneakers/white
	back = /obj/item/storage/backpack/medic
	backpack_contents = list(
		/obj/item/storage/box/survival,
		/obj/item/storage/medkit/regular,
		/obj/item/healthanalyzer,
		)

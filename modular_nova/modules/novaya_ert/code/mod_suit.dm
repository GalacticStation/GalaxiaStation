/datum/mod_theme/voskhod
	name = "refitted voskhod"
	desc = "A Heliostatic Coalition standard-issue heavy duty suit, designed for fortified positions operation and humanitarian aid."
	extended_desc = "A more expensive, yet more versatile replacement of the dated Voskhod powered armor, designed by the Magellanic Economic Corporate Union researchers \
	in collaboration with and for the needs of the Heliostatic Coalition. An efficient implementation of mixed exoskeletons inbetween and underneath its armor plating \
	allowed for an unprecedented level of protection through an overly abundant use of durathread-backed plasteel plating; and the remnant materials of its predecessor allow for \
	a dubiously efficient dissipation of any stray photon ray or a concentrated laser, were one to get hit by them. The suit's infamous autoparamedical systems \
	are also fully present - or their chemical synthesizing part, consisting of a thin web of subdermal autoinjectors, reaction cameras and tubes lined through the \
	insulation material - leading into its control unit where the relevant synthesis proceeds, mainly out of raw materials of the pharmaceutical industry; \
	morphine's older brother, opium. The sight of a white-and-green juggernaut is the one that instills many fears into numerous pirates; earning it the reputation of a peacekeeper \
	and a niche amongst the rimworld population."
	default_skin = "voskhod"
	armor_type = /datum/armor/mod_theme_voskhod
	complexity_max = DEFAULT_MAX_COMPLEXITY //Five of which is occupied by the in-builts, thus it's closer to 10
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.5
	inbuilt_modules = list(
		/obj/item/mod/module/status_readout/operational/voskhod,
		/obj/item/mod/module/auto_doc,
	)
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/knife/combat,
		/obj/item/shield/riot,
		/obj/item/gun,
	)
	variants = list(
		"voskhod" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/modules/novaya_ert/icons/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/modules/novaya_ert/icons/wornmod.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = HEAD_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY =  HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_voskhod
	melee = 30
	bullet = 40
	laser = 20
	energy = 30
	bomb = 30
	bio = 30
	fire = 80
	acid = 85
	wound = 20

/obj/item/mod/control/pre_equipped/voskhod
	theme = /datum/mod_theme/voskhod
	applied_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/flashlight,
	)

/obj/item/mod/control/pre_equipped/voskhod/ert
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	applied_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/visor/thermal,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magboot/advanced,
	)
	default_pins = list(
		/obj/item/mod/module/visor/thermal,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magboot/advanced,
	)

/datum/mod_theme/policing
	name = "policing"
	desc = "A Novaya Rossiyskaya Imperiya Internal Affairs Collegia general purpose protective suit, designed for coreworld patrols."
	extended_desc = "An Apadyne Technologies outsourced, then modified for frontier use by the responding imperial police precinct, MODsuit model, \
		designed for reassuring panicking civilians than participating in active combat. The suit's thin plastitanium armor plating is durable against environment and projectiles, \
		and comes with a built-in miniature power redistribution system to protect against energy weaponry; albeit ineffectively. \
		Thanks to the modifications of the local police, additional armoring has been added to its legs and arms, at the cost of an increased system load."
	default_skin = "policing"
	armor_type = /datum/armor/mod_theme_policing
	complexity_max = DEFAULT_MAX_COMPLEXITY - 1
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.25
	slowdown_inactive = 1.5
	slowdown_active = 0.5
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/knife/combat,
		/obj/item/shield/riot,
		/obj/item/gun,
	)
	variants = list(
		"policing" = list(
			MOD_ICON_OVERRIDE = 'modular_nova/modules/novaya_ert/icons/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_nova/modules/novaya_ert/icons/wornmod.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = HEAD_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY =  HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_policing
	melee = 40
	bullet = 50
	laser = 30
	energy = 30
	bomb = 60
	bio = 100
	fire = 75
	acid = 75
	wound = 20

/obj/item/mod/control/pre_equipped/policing
	theme = /datum/mod_theme/policing
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/paper_dispenser,
		/obj/item/mod/module/magnetic_harness
	)
	default_pins = list(
		/obj/item/mod/module/tether,
		/obj/item/mod/module/magboot,
	)

/obj/item/mod/control/pre_equipped/policing/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ZCM)

/obj/item/mod/module/status_readout/operational
	name = "MOD operational status readout module"
	desc = "A once-common module, this technology unfortunately went out of fashion in the safer regions of space; \
		however, it remained in use everywhere else. This particular unit hooks into the suit's spine, \
		capable of capturing and displaying all possible biometric data of the wearer; sleep, nutrition, fitness, fingerprints, \
		and even useful information such as their overall health and wellness. The vitals monitor also comes with a speaker, loud enough \
		to alert anyone nearby that someone has, in fact, died. This specific unit has a clock and operational ID readout."
	display_time = TRUE
	death_sound = 'modular_nova/modules/novaya_ert/sound/flatline.ogg'

/obj/item/mod/module/status_readout/operational/voskhod
	removable = FALSE

/obj/item/mod/module/auto_doc
	name = "MOD automatic paramedical module"
	desc = "The reverse-engineered and redesigned medical assistance system, previously used by the now decommissioned VOSKHOD combat armor. \
		The technology it uses is very similar to the one of Spider Clan, yet Innovations and Defense Collegium reject any similarities. \
		Using a built-in storage of chemical compounds and miniature chemical mixer, it's capable of injecting its user with simple painkillers and coagulants, \
		assisting them with their restoration, as long as they don't overdose themselves. However, this system heavily relies on some rarely combat-available chemical compounds to prepare its injections, \
		mainly Cryptobiolin, which appear in the user's bloodstream from time to time, and its trivial damage assesment systems are inadequate for complete restoration purposes."
	icon_state = "adrenaline_boost"
	module_type = MODULE_TOGGLE
	incompatible_modules = list(/obj/item/mod/module/adrenaline_boost, /obj/item/mod/module/auto_doc, /obj/item/mod/module/pepper_shoulders)
	complexity = 4
	removable = FALSE
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 20
	/// Reagent used as 'fuel'
	var/reagent_required = /datum/reagent/drug/opium
	/// How much of a reagent we need to refill a single boost.
	var/reagent_required_amount = 20
	/// Maximum amount of reagents this module can hold.
	var/reagent_max_amount = 120
	/// Percentage health threshold above which the module won't heal.
	var/health_threshold = 0.62
	/// Cooldown betwen each treatment.
	var/heal_cooldown = 45 SECONDS

	/// Timer for the cooldown.
	COOLDOWN_DECLARE(heal_timer)

/obj/item/mod/module/auto_doc/Initialize(mapload)
	. = ..()
	create_reagents(reagent_max_amount)

/obj/item/mod/module/auto_doc/on_active_process()
	if(!COOLDOWN_FINISHED(src, heal_timer))
		return FALSE

	if(!check_power(use_energy_cost))
		balloon_alert(mod.wearer, "not enough charge!")
		deactivate()
		return FALSE

	if(SEND_SIGNAL(src, COMSIG_MODULE_TRIGGERED) & MOD_ABORT_USE)
		return FALSE

	if(!reagents.has_reagent(reagent_required, reagent_required_amount))
		balloon_alert(mod.wearer, "not enough chems!")
		deactivate()
		return FALSE

	var/health_percent = round(mod.wearer.health / mod.wearer.maxHealth, 0.01)
	if(health_percent > health_threshold)
		return FALSE

	var/new_oxyloss = mod.wearer.getOxyLoss()
	var/new_bruteloss = mod.wearer.getBruteLoss()
	var/new_fireloss = mod.wearer.getFireLoss()
	var/new_stamloss = mod.wearer.getStaminaLoss()
	var/new_toxloss = mod.wearer.getToxLoss()

	if(mod.wearer.blood_volume < BLOOD_VOLUME_OKAY)
		mod.wearer.reagents.add_reagent(/datum/reagent/blood, 25, list("viruses"=null,"blood_DNA"=null,"blood_type"="U","resistances"=null,"trace_chem"=null))
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/coagulant, 5)
		to_chat(mod.wearer, span_warning("Blood infused."))
	if(new_oxyloss)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/salbutamol, 5)
		to_chat(mod.wearer, span_warning("Adrenaline administered."))
	if(new_bruteloss)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/sal_acid, 5)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 5)
		to_chat(mod.wearer, span_warning("Brute treatment administered."))
	if(new_fireloss)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/oxandrolone, 5)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 5)
		to_chat(mod.wearer, span_warning("Burn treatment administered."))
	if(new_stamloss)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/morphine, 5)
		mod.wearer.reagents.add_reagent(/datum/reagent/drug/cocaine, 5)
		to_chat(mod.wearer, span_warning("Stimdose administered."))
	if(new_toxloss)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/pen_acid, 5)
		to_chat(mod.wearer, span_warning("Antitoxin administered."))

	reagents.remove_reagent(reagent_required, reagent_required_amount)
	playsound(mod.wearer, 'sound/machines/steam_hiss.ogg', 40)
	drain_power(use_energy_cost*10)

	addtimer(CALLBACK(src, PROC_REF(heal_aftereffects), mod.wearer), 90 SECONDS)
	COOLDOWN_START(src, heal_timer, heal_cooldown)

/// Refills the module with needed chemicals, assuming the container isn't closed or the module isn't full.
/obj/item/mod/module/auto_doc/proc/charge_boost(obj/item/attacking_item, mob/user)
	if(!attacking_item.is_open_container())
		return FALSE
	if(reagents.has_reagent(reagent_required, reagent_max_amount))
		balloon_alert(mod.wearer, "already full!")
		return FALSE
	if(!attacking_item.reagents.trans_to(src, reagent_required_amount, target_id = reagent_required))
		return FALSE
	balloon_alert(mod.wearer, "charge reloaded!")
	return TRUE

/obj/item/mod/module/auto_doc/on_install()
	RegisterSignal(mod, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(try_refill))

/obj/item/mod/module/auto_doc/on_uninstall(deleting)
	UnregisterSignal(mod, COMSIG_ATOM_ITEM_INTERACTION)

/obj/item/mod/module/auto_doc/proc/try_refill(source, mob/user, obj/item/attacking_item)
	SIGNAL_HANDLER
	if(charge_boost(attacking_item))
		return COMPONENT_NO_AFTERATTACK
	return NONE

/// With a certain chance, triggers a spontaneous injection of opium into the user's bloodstream; suit design's rather ancient and prone to mishaps.
/obj/item/mod/module/auto_doc/proc/heal_aftereffects(mob/affected_mob)
	if(!affected_mob)
		return
	var/fault_chance = (reagents.maximum_volume/(reagents.total_volume ? reagents.total_volume : 20))*5 // 5% at max opium, 20% at low-to-none opium
	if(prob(fault_chance))
		reagents.trans_to(affected_mob, 5)
		balloon_alert(affected_mob, "opium leak!")

/obj/item/reagent_containers/cup/glass/waterbottle/large/opium
	name = "bottle of opium"
	desc = "Nothing screams 'Budget cuts' like a plastic bottle of autodoc refills."
	list_reagents = list(/datum/reagent/drug/opium = 100)

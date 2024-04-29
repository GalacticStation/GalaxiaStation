#define RADIO_ALERT 80
#define POWER_FOR_PAYOUT (20 KILO WATTS)
#define PAYOUT 100

/obj/item/powersink/creditminer
	name = "credit-miner"
	desc = "An altered version of the Syndicate power-sink, this one converts energy into credits."
	w_class = WEIGHT_CLASS_HUGE
	max_heat = 1e8 // double the heat of its parent type
	// The amount of power the machine has converted to credits.
	var/cash_out = 0
	///The machine's internal radio, used to broadcast alerts.
	var/obj/item/radio/radio
	///The key our internal radio uses
	var/radio_key = /obj/item/encryptionkey/syndicate
	///The channel we announce over.
	var/radio_channel = RADIO_CHANNEL_SYNDICATE
	///Amount of time before the next warning over the radio is announced.
	var/next_warning = 0
	///The amount of time we have between warnings
	var/minimum_time_between_warnings = 15 SECONDS

/obj/item/powersink/creditminer/Initialize(mapload)
	. = ..()
	radio = new(src)
	radio.keyslot = new radio_key
	radio.set_listening(FALSE)
	radio.recalculateChannels()

/obj/item/powersink/creditminer/examine(mob/user)
	. = ..()
	if(cash_out)
		. += span_blue("[src] has mined [trunc(cash_out)] credits, <b>Alt-click</b> to print a holochip.")

/obj/item/powersink/creditminer/click_alt(mob/user)
	. = ..()
	print()

/obj/item/powersink/creditminer/process()
	. = ..()
	if(internal_heat > max_heat * RADIO_ALERT / 100)
		if(next_warning < world.time && prob(15))
			var/area/hazardous_area = get_area(loc)
			var/message = "I'm about to explode in [initial(hazardous_area.name)]!!"
			radio.talk_into(src, message, radio_channel)
			next_warning = world.time + minimum_time_between_warnings

/obj/item/powersink/creditminer/proc/print()
	if(cash_out > 0)
		playsound(src.loc, 'sound/items/poster_being_created.ogg', 100, TRUE)
		balloon_alert_to_viewers("Printed [trunc(cash_out)] credits")
		new /obj/item/holochip(drop_location(), trunc(cash_out)) //get the loot
		cash_out = 0

/obj/item/powersink/creditminer/drain_power()
	// The net we're attached to
	var/datum/powernet/powernet = attached.powernet
	// How much raw energy we've siphoned
	var/drained = 0
	set_light(5)

	drained = attached.newavail()
	attached.add_delayedload(drained)

	// If tried to drain more than available on powernet, now look for APCs and drain their cells
	for(var/obj/machinery/power/terminal/terminal in powernet.nodes)
		if(istype(terminal.master, /obj/machinery/power/apc))
			var/obj/machinery/power/apc/apc = terminal.master
			if(apc.operating && apc.cell)
				drained += 0.001 * apc.cell.use(0.05 * STANDARD_CELL_CHARGE, force = TRUE)
	internal_heat += drained
	cash_out += min(energy_to_power(drained) / POWER_FOR_PAYOUT, PAYOUT)

#undef RADIO_ALERT
#undef POWER_FOR_PAYOUT
#undef PAYOUT

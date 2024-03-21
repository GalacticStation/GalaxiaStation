/mob/living/verb/roll_verb(message as text)
	set name = "Dice"
	set category = "IC"
	set instant = TRUE

	if(GLOB.say_disabled)
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return

	if(client && client.prefs.muted & MUTE_IC)
		to_chat(src, span_boldwarning("You cannot send IC messages (muted)."))
		return FALSE

	display_random_roll(message)

/atom/movable/proc/display_random_roll(param, show_errors = TRUE)
	var/static/usage = span_notice("This emote is formatted as wDx+y/DCz, where w is the number of dice to roll, x is the amount of faces on the dice, \
	y is the bonus/malus (use + or - respectively) to the roll, and z is the difficulty level of the roll. Both y and z are optional, as is the plus, slash, and \"DC\".\n\
	Here is an example: D20-5/DC15. This will roll a twenty-sided die, subtract five and compare it against a difficulty check of 15.")

	if(!param)
		to_chat(src, usage)
		return

	var/t1 = findtext(param, "+", 1, null)
	if (!t1)
		t1 = findtext(param, "-", 1, null)
	var/t2 = findtext(param, "/", 1, null)
	var/die = lowertext(copytext(param, 1, t1))
	var/bonus_number = copytext(param, t1, t2)
	if (!t1)
		bonus_number = null
	var/dc = copytext(param, t2 + 1, length(param) + 1 )
	if (!t2)
		dc = null
	var/dc_number = text2num(copytext(dc, 3, length(dc) + 1))

	var/die_string = die + bonus_number
	var/die_result = roll(die_string) // will runtime if nonstandard characters are entered. oh well

	var/dc_status
	var/spanless_dc_status
	var/message = "<b>[src]</b> rolls <b>[die_string]</b> for <b>[die_result]</b>"
	var/balloon_message = "rolls [die_result]"
	if (isnum(dc_number))
		if (die_result >= dc_number)
			dc_status = span_boldnotice("succeeding")
			spanless_dc_status = "succeeding"
		if (die_result < dc_number)
			dc_status = span_bolddanger("failing")
			spanless_dc_status = "failing"
		message += " to beat a DC of <b>[dc_number]</b>, [dc_status]"
		balloon_message += ", [spanless_dc_status]"

	message += "."

	balloon_alert_to_viewers(balloon_message)
	visible_message(message)

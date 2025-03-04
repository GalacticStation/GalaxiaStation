ADMIN_VERB(character_preferences_upload, R_ADMIN, "Upload Character Preferences", "Upload a character preferences JSON file to the server.", ADMIN_CATEGORY_MAIN)
	var/jsonfile = input(user, "Choose a JSON file to upload to replace a player save", "Upload Character Preferences") as null|file
	if(!jsonfile)
		return
	if(copytext("[jsonfile]", -5) != ".json")
		to_chat(user, span_warning("Filename must end in '.json': [jsonfile]"), confidential = TRUE)
		return
	var/player_key = input(user, "Enter player CKey to replace their save file", "Enter Player CKey")  as null|text
	if(!player_key)
		return

	var/new_save = file2text(file(jsonfile))
	var/json_tree
	try
		json_tree = json_decode(new_save)
	catch(var/exception/err)
		log_admin("Failed to load json savefile: [err]")
		message_admins("Failed to load json savefile: [err]")
		return

	var/savepath = "data/player_saves/[player_key[1]]/[player_key]/preferences.json"
	var/bacpath = savepath + ".updatebac"
	fdel(savepath)
	fdel(bacpath)
	text2file(json_encode(json_tree), file(savepath))


	if(!isnull(GLOB.preferences_datums[player_key]))
		GLOB.preferences_datums[player_key] = null

	to_chat(user, span_danger("Successfully imported new preferences for player [player_key]"), confidential = TRUE)
	log_admin("[key_name_admin(user)] has successfully imported new preferences for player [player_key].")
	message_admins("[key_name_admin(user)] has successfully imported new preferences for player [player_key].")

	var/client/target_client = GLOB.directory[player_key]
	if(!target_client)
		return

	to_chat(target_client, span_danger("Kicked to finish preference file importing. Please re-connect to the server."), confidential = TRUE)
	qdel(target_client)
	log_admin("Kicked [player_key] to complete preference file importing.")
	message_admins("Kicked [player_key] to complete preference file importing.")

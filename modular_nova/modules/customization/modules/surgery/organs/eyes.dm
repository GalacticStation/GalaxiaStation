/obj/item/organ/eyes
	var/is_emissive = FALSE
	var/eyes_layer = BODY_LAYER

/obj/item/organ/eyes/snail
	eyes_layer = ABOVE_BODY_FRONT_HEAD_LAYER // Roundstart Snails

/obj/item/organ/eyes/night_vision/ashwalker
	//give ashwalker darkvision a reddish-blue tint
	low_light_cutoff = list(22, 12, 17)
	medium_light_cutoff = list(33, 18, 26)
	high_light_cutoff = list(75, 41, 61)

extends Resource

class_name AppearanceData

@export var shoes : ShoesData
@export var skin : SkinToneData
@export var hair : HairData
@export var accessory : AccessoryData

var default_shoes := preload("res://Custom Resources/shoes_basic.tres")
var default_skin := preload("res://Custom Resources/skintone_7.tres")
var default_hair := preload("res://Custom Resources/hair_brown_1.tres")
var default_accessory := preload("res://Custom Resources/accessories_1.tres")

func get_shoes_sprite_sheet():
	if shoes and shoes.sprite_sheet:
		return shoes.sprite_sheet
	else:
		return default_shoes.sprite_sheet

func get_skin_sprite_sheet():
	if skin and skin.sprite_sheet:
		return skin.sprite_sheet
	else:
		return default_skin.sprite_sheet

func get_hair_sprite_sheet():
	if hair and hair.sprite_sheet:
		return hair.sprite_sheet
	else:
		return default_hair.sprite_sheet

func get_accessory_sprite_sheet():
	if accessory and accessory.sprite_sheet:
		return accessory.sprite_sheet
	else:
		return default_accessory.sprite_sheet

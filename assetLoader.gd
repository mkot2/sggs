extends Node

var allPaintings = {}

enum P_DICT_FIELDS {
	NAME,
	AUTHOR,
	MEDIA,
	ERA
}

@onready var music_player = get_node("/root/Node3D/XROrigin3D/MusicPlayer")

var current_id: String

func _ready():
	var list = ConfigFile.new()
	var err = list.load("res://assets/list.ini")
	if err != OK:
		return
	for sec in list.get_sections():
		AssetLoader.allPaintings[sec] = [list.get_value(sec, "name", ""), list.get_value(sec, "author", "neznámy autor"), \
		list.get_value(sec, "media", ""), list.get_value(sec, "era", "")]

func display_painting_scaled(ver: String, painting: Node, init=false, labelr: Node=null, info: Node=null):
	var id = painting.get_meta("Base") + "." + painting.get_meta("Painting")
	music_player.stop()
	music_player.seek(0.0)
	var audio_dat = load("res://assets/"+ ver + "/" + id + ".ogg")
	music_player.stream = audio_dat
	painting.texture = load("res://assets/"+ ver + "/" + id + ".png")

	if init:
		var main_container = labelr.get_child(0).get_child(0).get_child(0).get_child(0) # VBoxContainer
		main_container.get_child(0).text = AssetLoader.allPaintings[id][P_DICT_FIELDS.AUTHOR]
		main_container.get_child(1).text = AssetLoader.allPaintings[id][P_DICT_FIELDS.NAME]
		main_container.get_child(2).text = AssetLoader.allPaintings[id][P_DICT_FIELDS.MEDIA]
		main_container.get_child(3).text = AssetLoader.allPaintings[id][P_DICT_FIELDS.ERA]
		info.text = AssetLoader.allPaintings[ver][P_DICT_FIELDS.NAME]

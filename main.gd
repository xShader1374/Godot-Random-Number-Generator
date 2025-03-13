extends Control

var generated_number: int = 0

var num_range_min: int = 0
var num_range_max: int = 0

## Alunni esclusi perchè già chiamati, assenti o per altri motivi
@export var alunni_esclusi: PackedStringArray = [
	"Mattia Colonna",
]

## Tutti gli alunni di una classe
@export var alunni: PackedStringArray = [
	"Giandomenico Antonicelli",
	"Alessia Barbanente",
	"Nunzio Bongallino",
	"Antonio Cassano",
	"Roberto Cassano",
	"Giuseppe Cardascia",
	"Mattia Colonna",
	"Giuseppe Disabato",
	"Giovanna Denicolò",
	"Andres Francesco Gentile",
	"Michael Ruben Lops",
	"Gaetano Lovreglio",
	"Italo Pellecchia",
	"Paco Spinelli"
]

func _ready() -> void:
	randomize()
	
	num_range_max = alunni.size() - 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED or DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_MAXIMIZED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func generate() -> void:
	#num_range_min = %minSpinBox.value
	#num_range_max = %maxSpinBox.value
	
	generated_number = randi_range(num_range_min, num_range_max)
	
	if alunni_esclusi.has(alunni[generated_number]):
		generate()
	
	textAnim()
	%generatedNumberLabel.text = str(alunni[generated_number], " ", "(", generated_number + 1, ")")

func textAnim() -> void:
	var tween: Tween = create_tween()
	
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	
	tween.tween_property(%generatedNumberLabel, "visible_ratio", 1.0, 0.25).from(0.0)


func _on_min_spin_box_value_changed(value: int) -> void:
	num_range_min = value


func _on_max_spin_box_value_changed(value: int) -> void:
	num_range_max = value


func _on_button_pressed() -> void:
	generate()
	%AudioStreamPlayer.play()


func _on_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(1, !toggled_on)
	
	if toggled_on:
		%sfxMuteButton.text = "ON"
	else:
		%sfxMuteButton.text = "OFF"

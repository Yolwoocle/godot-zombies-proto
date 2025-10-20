extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var life_component = $LifeComponent

func _physics_process(delta: float) -> void:
	move_and_slide()

func _process(delta: float) -> void:
	%LifeBar.max_value = life_component.max_life
	%LifeBar.value = life_component.life
	%LifeLabel.text = str(life_component.life) + " / " + str(life_component.max_life)
	

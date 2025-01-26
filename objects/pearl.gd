extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if visible:
		$Pearl_Hit.play()
		visible = false
	await $Pearl_Hit.finished
	queue_free()

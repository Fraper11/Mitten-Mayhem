extends Node2D
func _process(delta: float) -> void:
	$Days.text="Day: %s" %TimecontrolData.passed_day
	$EMclpointer01.visible=false
	$Mclpointer01.visible=false
	$Eclpointer01.visible=false
	$Nclpoint01.visible=false
	if TimecontrolData.phase_of_day==0:
		$EMclpointer01.visible=true
	if TimecontrolData.phase_of_day==1:
		$Mclpointer01.visible=true
	if TimecontrolData.phase_of_day==2:
		$Eclpointer01.visible=true
	if TimecontrolData.phase_of_day==3:
		$Nclpoint01.visible=true

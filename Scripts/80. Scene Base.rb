#==============================================================================
# ** Scene_Base
#------------------------------------------------------------------------------
#  This class is the base of all scenes
#==============================================================================

class Scene_Base

	#--------------------------------------------------------------------------
	# * Play Decision SE
	#--------------------------------------------------------------------------
	def play_decision_se
		$game_system.se_play($data_system.decision_se)
	end
	#--------------------------------------------------------------------------
	# * Play Cancel SE
	#--------------------------------------------------------------------------
	def play_cancel_se
		$game_system.se_play($data_system.cancel_se)
	end
	#--------------------------------------------------------------------------
	# * Play Buzzer SE
	#--------------------------------------------------------------------------
	def play_buzzer_se
		$game_system.se_play($data_system.buzzer_se)
	end

end

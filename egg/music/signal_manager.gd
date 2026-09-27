# Implied class_name SignalManager
extends Node

@warning_ignore_start("unused_signal")

## Signal(s) for each wave starting
signal wave_started

## Signal(s) for each wave ending - I don't think we need this but I want to use it for testing
signal wave_ended

## Signal for menu button(s) pressed
signal menu_button_pressed()

## Signal for pause
signal pause_open
signal pause_close

## Signal for Player Death
signal player_dead

## Signal for Player Win
signal player_won

# Highkey, I'm only making this so that the audio tracks are easy to work out.... hopefully.
signal sfx_request(sfx_int)

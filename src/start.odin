package main

import "w4"

startscreen :: proc "c" () {
	w4.DRAW_COLORS^ = 3
	w4.text("Welcome to Mung!", 15, 34)
	w4.text(    "Mum pong!", 38, 43)
	w4.DRAW_COLORS^ = 2
	w4.text(     "press x", 47, 74)
	w4.text(    "to start!", 44, 84)
    if .A in w4.GAMEPAD1^ do mode="game"
}


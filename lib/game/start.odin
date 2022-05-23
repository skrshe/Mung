package game

import "lib:w4"

tic:int
swap:int

startscreen :: proc "c" () {
    tic+=1
	w4.DRAW_COLORS^ = 0x303
	w4.text("Welcome to Mung!", 15, 34)
	w4.text(    "Mum pong!", 38, 43)

    w4.DRAW_COLORS^ = 0x202
	w4.text(    "press", 52, 87)
	w4.text(    "to start!", 44, 99)
    w4.rect(99, 87, 9, 9)
    if tic%40 == 1 do swap+=1
    w4.DRAW_COLORS^ = 0x202
    if swap%2 == 1 do w4.DRAW_COLORS^ = 0x101
	w4.text(           "X", 100, 88)

    if .A in w4.GAMEPAD1^ do mode="game"
}

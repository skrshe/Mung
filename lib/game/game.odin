package game

import "lib:w4"
import coll "lib:collision"
//import "core:strings"
//import "core:unicode/utf8"

ball:= Ball{150,140,-1,1}
player:= Player
mode:= "game"
debugcoll:= false

@export
start :: proc "c" () {
        player[0] = {
            y = 70,
            x = 3,
            pad = w4.GAMEPAD1,
        }
        player[1] = {
            y = 70,
            x = 155,
            pad = w4.GAMEPAD2,
        }
}

gameinit:= true
gamescreen :: proc () {
    if gameinit {
        w4.PALETTE[0] = 0x071821
        w4.PALETTE[1] = 0x306850
        w4.PALETTE[2] = 0x86c06c
        w4.PALETTE[3] = 0xe0f8cf
        gameinit = false
    }

    updategame()

    w4.DRAW_COLORS^ = 0x404
    for i in 0..1 {
	    w4.text("0", 72+(i32(i)*9), 2)
        w4.rect(i32(player[i].x),i32(player[i].y), 2, 12)
    }

	w4.DRAW_COLORS^ = 0x444
    w4.oval(i32(ball.x),i32(ball.y),2,2)
    //if winner() do mode == "win"
	//w4.text("press z to continue", 10,130 )

    if debugcoll do w4.rect(1,148,11,159)
}

updategame :: proc "c" () {
    up1:= true
    up2:= true
    debugcoll=false
    for i in 0..<len(player) {
        if .B in w4.GAMEPAD1^ do if winner() do mode="win"
        if .UP in player[i].pad^ {
            player[i].d = -2.5
            up1 = false
        }
        if .DOWN in player[i].pad^ {
            player[i].d = 2.5

            up1 = false
        }

        friction:= false
        if player[i].d != 0 {
            if up1 == true do friction = true
        }
        if friction == true do player[i].d /= 1.065

        player[i].y += player[i].d

        if !coll.cr(ball.x, ball.y, 1,
                   player[0].x, player[0].x, 2, 12) {
            debugcoll = true
            w4.tracef("x: %f, y: %f", ball.x+ ball.dx, ball.y+ ball.dy)
        }


        if player[i].y >= 146 do player[i].y = 146
        if player[i].y < 2 do    player[i].y = 2
    }

    if ball.x >= 158 do ball.dx = -ball.dx
    if ball.x < 0 do    ball.dx = -ball.dx
    if ball.y >= 156 do ball.dy = -ball.dy
    if ball.y < 2 do    ball.dy = -ball.dy
    ball.x += ball.dx
    ball.y += ball.dy
}

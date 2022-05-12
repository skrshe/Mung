package main

import "w4"
import "core:strings"

ball:= Ball{12,12,1,1}
player:= Player

@export start :: proc "c" () {
    player[0] = {
        y = 70,
        x = 3,
        pad = w4.GAMEPAD1,
    }
    player[1] = {
        y = 70,
        x = 156,
        pad = w4.GAMEPAD2,
    }
}

gamescreen :: proc "c" () {
    updategame()

	w4.DRAW_COLORS^ = 4
    w4.rect(0, 0, 160, 160)
	w4.DRAW_COLORS^ = 1
    for i in 0..1 {
	    //w4.text(strings.to_string(player[i].s), 60+((i32(i)-0)*3), 2)
	    w4.text("0", 70+(i32(i)*10), 2)
        w4.rect(i32(player[i].x),i32(player[i].y), 2, 12)
        w4.rect(i32(player[i].x),i32(player[i].y), 2, 12)
    }
    w4.oval(i32(ball.x),i32(ball.y),3,3)
    //if winner() do mode == "win"
	//w4.text("press z to continue", 10,130 )
    //if .B in w4.GAMEPAD1^ do if winner() do mode="win"
}

updategame :: proc "c" () {
    up1:= true
    up2:= true
    for i in 0..1 {
        p:= player[i]

        if .UP in p.pad^ {
            p.d = -2.5

            if i == 0 do up1 = false; else do up2 = false
            w4.tracef("up was last: %f", f32(p.x))
        }
        if .DOWN in p.pad^ {
            p.d = 2.5

            if i == 0 do up1= false; else do up2 = false
            w4.tracef("up was last: %f", f32(p.x))
            //w4.tracef("up was last: %f", f32(p.d))
        }

        friction:= false
        if p.d != 0 {
            if i == 0 && up1 == true do friction = true
            else if i == 1 && up2 == true do friction = true
        }
        if friction == true do p.d /= 1.065

        p.y += p.d

        if p.y >= 146 do p.y = 146
        if p.y < 2 do    p.y = 2
    }
    if ball.x >= 158 do ball.dx = -ball.dx
    if ball.x < 0 do    ball.dx = -ball.dx
    if ball.y >= 156 do ball.dy = -ball.dy
    if ball.y < 2 do    ball.dy = -ball.dy

    ball.x += ball.dx
    ball.y += ball.dy
}

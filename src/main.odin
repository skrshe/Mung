package main

import "w4"
//import "core:fmt"
//import ex "w4-extra"

ball:= Ball{12,12,1,1}
player:= Player

mode:= "game"

@export start :: proc "c" () {
    player[0] = {
        y = 70,
        x = 3,
        pad = w4.GAMEPAD1,
    }
    player[1] = {
        y = 70,
        x = 15,
        pad = w4.GAMEPAD2,
    }
}

@export update :: proc "c" () {
    if      mode == "start" do startscreen()
    else if mode == "game"  do gamescreen()
    else if mode == "win"   do winscreen()
}

startscreen :: proc "c" () {
	w4.DRAW_COLORS^ = 3
	w4.text("Welcome to Mung!", 15, 34)
	w4.text(    "Mum pong!", 38, 43)
	w4.DRAW_COLORS^ = 2
	w4.text(     "press x", 47, 74)
	w4.text(    "to start!", 44, 84)
    if .A in w4.GAMEPAD1^ do mode="game"
}

gamescreen :: proc "c" () {
    updategame()

	w4.DRAW_COLORS^ = 4
    w4.rect(0, 0, 160, 160)
	w4.DRAW_COLORS^ = 1
    for i in 0..1 {
	    //w4.text(string(fmt.tprintf(player[i].score), 60+((i-0)*3), 2)
	    w4.text("0", 60+(i32(i)*3), 2)
        w4.rect(i32(player[i].x),i32(player[i].y), 2, 12)
    }
    w4.rect(155,70,2,12)
    w4.oval(i32(ball.x),i32(ball.y),3,3)
    //if winner() do mode == "win"
	//w4.text("press z to continue", 10,130 )
    //if .B in w4.GAMEPAD1^ do if winner() do mode="win"
}

updategame :: proc "c" () {
    for i in 0..1 {
        p:= player[i]
        released:= true

        if .UP in p.pad^ {
            p.d = -2.5
            released = false
        }
        if .DOWN in p.pad^ {
            p.d = 2.5
            released = false
        }

        if released && p.d != 0.0 {
            p.d /= 1.065
        }

        p.y += p.d

        if p.y >= 146 do p.y = 146
        if p.y < 2 do    p.y = 2
    }

    if ball.x >= 158 do ball.dx = -ball.dx
    if ball.x < 0 do    ball.dx = -ball.dx
    if ball.y >= 158 do ball.dy = -ball.dy
    if ball.y < 2 do    ball.dy = -ball.dy

    ball.x += ball.dx
    ball.y += ball.dy
}

winner :: proc "c" () -> bool   { return true }
whowon :: proc "c" () -> string { return "p2"}

winscreen :: proc "c" () {
    w4.PALETTE[0] = 0xfff6d3
    w4.PALETTE[1] = 0xf9a875
    w4.PALETTE[2] = 0xeb6b6f
    w4.PALETTE[3] = 0x7c3f58
	w4.DRAW_COLORS^ = 3
    //w4.rect(0,0,160,160)

    if whowon() == "p2" {
        w4.text("You Win!",45,70)
        w4.text("Luviya!",44,81)
        w4.blit(&heart[0],99,82,8,8)
    } else {
        w4.text("We're all",  43, 65)
        w4.text("Winners!!!", 40, 75)
    }

    w4.blit(&heart[0],20,20,8,8)
	w4.DRAW_COLORS^ = 2
    w4.blit(&heart[0],20,140,8,8)
	w4.DRAW_COLORS^ = 4
    w4.blit(&heart[0],140,20,8,8)
    w4.blit(&smiley[0],140,140,8,8)
}

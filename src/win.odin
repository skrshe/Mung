package main

import "w4"

winner :: proc "c" () -> bool   { return true }
whowon :: proc "c" () -> string { return "p2"}

wininit:= true
winscreen :: proc "c" () {
    if wininit {
        w4.PALETTE[0] = 0xfff6d3
        w4.PALETTE[1] = 0xf9a875
        w4.PALETTE[2] = 0xeb6b6f
        w4.PALETTE[3] = 0x7c3f58
        wininit = false
    }
	w4.DRAW_COLORS^ = 3
    //w4.rect(0,0,160,160)

    if whowon() == "p2" {
        w4.text("You Win!",45,70)
        w4.text( "Luviya!",44,81)
        w4.blit(&heart[0],99,82,8,8)
    } else {
        w4.text( "We're all",  43, 65)
        w4.text("Winners!!!", 40, 75)
    }

    w4.blit(&heart[0],20,20,8,8)
	w4.DRAW_COLORS^ = 2
    w4.blit(&heart[0],20,140,8,8)
	w4.DRAW_COLORS^ = 4
    w4.blit(&heart[0],140,20,8,8)
    w4.blit(&smiley[0],140,140,8,8)
}

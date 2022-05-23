package main

import "lib:w4"
import gm "lib:game"

@export update :: proc () {
    if      gm.mode == "start"  do gm.startscreen()
    else if gm.mode == "game"  do gm.gamescreen()
    else if gm.mode == "win"   do gm.winscreen()
}


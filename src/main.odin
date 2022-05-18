package main

import "w4"

mode:= "start"

@export update :: proc () {
    if      mode == "start"  do startscreen()
    else if mode == "game"  do gamescreen()
    else if mode == "win"   do winscreen()
}


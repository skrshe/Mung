package main

import "w4"
//import "core:fmt"
//import ex "w4-extra"

mode:= "game"

@export update :: proc "c" () {
    if      mode == "start" do startscreen()
    else if mode == "game"  do gamescreen()
    else if mode == "win"   do winscreen()
}


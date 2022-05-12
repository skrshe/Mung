package main

import "w4"

Ball :: struct {
    x:  f32,
    y:  f32,
    dx: f32,
    dy: f32,
}

Paddle :: struct {
    y: f32,
    x: f32,
    d: f32,
    s: i32,
    pad: ^w4.Buttons,
}

Player: [2]Paddle


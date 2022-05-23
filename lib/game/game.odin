package game

import "lib:w4"
//import "core:strings"
//import "core:unicode/utf8"
ball:= Ball{80,80,-1,1}
player:= Player

mode:= "start"

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
	w4.DRAW_COLORS^ = 0x404
    updategame()

    for i in 0..1 {
        //b: [dynamic]rune
        //append(&b, rune(player[i].s))
        //pscore:=utf8.runes_to_string(b[:])
	    //w4.text(pscore, 60+((i32(i)-0)*3), 2)
	    w4.text("0", 72+(i32(i)*9), 2)
        w4.rect(i32(player[i].x),i32(player[i].y), 2, 12)
    }

	w4.DRAW_COLORS^ = 0x444
    w4.oval(i32(ball.x),i32(ball.y),2,2)
    //if winner() do mode == "win"
	//w4.text("press z to continue", 10,130 )
    if .B in w4.GAMEPAD1^ do if winner() do mode="win"
}

updategame :: proc "c" () {
    up1:= true
    up2:= true

    for i in 0..<len(player) {

        if .UP in player[i].pad^ {
            player[i].d = -2.5
            up1 = false
            w4.tracef("y: %f", f64(player[i].y))
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

// num to string past here ---
log10 :: proc (value: int) -> (res: int) {
    v := value
    for v > 0 {
        v /= 10
        res += 1
    }
    return res if value > 0 else 1
}

count_fractional :: proc (buffer: []u8, remainder: f64, precision: int) -> (length: int) {

    if precision + 1 > len(buffer) {
        // Doesn't fit `.abc`
        return 0
    }

    multiplier := f64(1)
    for in 1..precision {
        multiplier *= 10
    }

    r := uint(remainder * multiplier)

    for i := 0; i < precision; i += 1 {
        _i := len(buffer) - i - 1

        buffer[_i] = '0' + u8(r % 10)
        r /= 10
        length += 1
    }
    buffer[len(buffer) - precision - 1] = ' '
    return length + 1
}

f64_to_string :: proc (buffer: []u8, value: f64, precision: int = 3) -> (s: string) {
    assert(precision >= 0 && precision <= 19)

    whole := int(value)
    fract := value - f64(whole)

    whole_size := log10(whole)
    fract_size := 0 if precision == 0 else precision + 1 // if precision is zero we also don't need the .

    if whole_size + fract_size > len(buffer) {
        // Doesn't fit
        return ""
    }

    for i in 1..whole_size {
        buffer[whole_size - i] = '0' + u8(whole % 10)
        whole /= 10
    }
    if fract_size > 0 {
        count_fractional(buffer[whole_size:][:fract_size], fract, precision)
    }
    return string(buffer[:whole_size + fract_size])
}

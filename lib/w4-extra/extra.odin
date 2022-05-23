package w4extra

import "../w4"

pixel :: proc "c" (x : int, y : int) {
    // The byte index into the framebuffer that contains (x, y)
    idx := (y*160 + x) >> 2

    // Calculate the bits within the byte that corresponds to our position
    shift := u8((x & 0b11) << 1)
    mask := u8(0b11 << shift)

    // Use the first DRAW_COLOR as the pixel color
    palette_color := u8(w4.DRAW_COLORS^ & 0b1111)
    if (palette_color == 0) {
        // Transparent
        return
    }
    color := (palette_color - 1) & 0b11;

    // Write to the framebuffer
    w4.FRAMEBUFFER[idx] = (color << shift) | (w4.FRAMEBUFFER[idx] &~ mask)
}

cls :: proc (color: u16 = 0) {
    reset:= w4.DRAW_COLORS&

	w4.DRAW_COLORS^ = color
    w4.rect(0,0,159,159)
	w4.DRAW_COLORS^ = reset
}

btn   :: proc () {
    w4.trace("btn")
}
btnp  :: proc () {
    w4.trace("btnp")
}

rectf :: proc () {
    w4.trace("rectf")
}
ovalf :: proc () {
    w4.trace("ovalf")
}

package collision

cr :: proc "c" (cx: f32, cy: f32, cr: int,
                rx: f32, ry: f32, rw: int, rh: int) -> bool {
    fcr:= f32(cr)
    frw:= f32(rw)
    frh:= f32(rh)

    if cx+fcr < rx      do return false
    //if cy+fcr < ry     do return false
    if cx-fcr > rx+frw do return false
    //if cy-fcr < ry+frh do return false
    return true
}

//rr :: proc (ax: u16, ay: u16, aw: u16, ah: u16,
//            bx: u16, by: u16, bw: u16, bh: u16) -> bool {
//    if ay-ar>by+bh do return false
//    if ay+ar<by    do return false
//    if ax-ar>bx+bw do return false
//    if ax+ar<bx    do return false
//    return true
//}


//hit :: proc (ox: u16, oy: u16, odx: u16, ody: u16,
//              rx: u16, ry: u16, rw:  u16, rh:  u16) -> bool {
//    angle:= odx / ody
//    nx,ny:= f32

//    if odx <= 0 do return false
//    else if ody <= 0 do return true
//    else if angle > 0 && odx > 0 {
//        nx=rx-ox
//        ny=ry-oy
//        return nx > 0 && ny/nx < angle
//    } else if angle < 0 && odx > 0 {
//        nx=rx-ox
//        ny=ry+rh-oy
//        return nx > 0 && ny/nx >= angle
//    } else if angle > 0 && odx < 0 {
//        nx=rx+rw-ox
//        ny=ry+rh-oy
//        return nx < 0 && ny/nx <= angle
//    } else {
//        nx=rx+rw-ox
//        ny=ry-oy
//        return nx < 0 && ny/nx >= angle
//    }
//}


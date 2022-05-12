package collision

cr::(nx,ny,rx,ry,rw,rh) {
    if ny-br>ry+rh then return false end
    if ny+br<ry    then return false end
    if nx-br>rx+rw then return false end
    if nx+br<rx    then return false end
    return true
}

chit :: proc (ox: u16, oy: u16, odx: u16, ody: u16,
              rx: u16, ry: u16, rw:  u16, rh:  u16) {
    local theta = odx / ody
    local nx,ny
    if odx==0 do
        return false
    else if ody==0 do
        return true
    else if theta > 0 and odx > 0 {
        nx=rx-ox
        ny=ry-oy
        return nx > 0 and ny/nx < theta
    } else if theta < 0 and odx > 0 {
        nx=rx-ox
        ny=ry+rh-oy
        return nx > 0 and ny/nx >= theta
    } else if theta > 0 and odx < 0 {
        nx=rx+rw-ox
        ny=ry+rh-oy
        return nx < 0 and ny/nx <= theta
    } else {
        nx=rx+rw-ox
        ny=ry-oy
        return nx < 0 and ny/nx >= theta
    }
}


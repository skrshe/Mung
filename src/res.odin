package main

import "w4"

smiley := [8]u8{
	0b11000011,
	0b10000001,
	0b00100100,
	0b00100100,
	0b00000000,
	0b00100100,
	0b10011001,
	0b11000011,
}

heart := [8]u8{
	0b10011001,
	0b00000000,
	0b00000000,
	0b10000001,
	0b11000011,
	0b11100111,
	0b11111111,
	0b11111111,
}

nums_width : u32 : 40
nums_height : u32 : 4
nums_flags : w4.Blit_Flags = nil // BLIT_1BPP
nums := [20]u8{ 0xec,0xcc,0xae,0x8e,0xce,0xa4,0x66,0xa8,0xe2,0xea,0xa4,0xc2,0xe6,0xa4,0xae,0xee,0xee,0x2e,0xe4,0xe2 }

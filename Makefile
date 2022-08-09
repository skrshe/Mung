build/cart.wasm: mung.odin lib/game/*.odin
	@-mkdir -p build
	odin build mung.odin -file -out:build/cart.wasm \
		-target:freestanding_wasm32 \
		-collection:lib=./lib \
		-collection:res=./res \
		-no-entry-point -extra-linker-flags:" --import-memory -zstack-size=14752 --initial-memory=65536 --max-memory=65536 --stack-first --lto-O3 --gc-sections --strip-all"
run: build/cart.wasm
	w4 run build/cart.wasm

html: build/cart.wasm
	w4 bundle --html mung.html build/cart.wasm \
		--description "Mothers day Pong" \
		--title mung
tux: build/cart.wasm
	w4 bundle --linux build/mung build/cart.wasm
win: build/cart.wasm
	w4 bundle --windows build/mung.exe build/cart.wasm
mac: build/cart.wasm
	w4 bundle --mac build/mung.app build/cart.wasm

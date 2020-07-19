extends Node

enum State {
	NONE,
	DEPLOY,
	BATTLE,
	RESULTS
}

const BENCH_AREA_POS = Vector2(0, 1)
const BENCH_AREA_SIZE = Vector2(1, 10)
const DEPLOY_AREA_POS = Vector2(2, 2)
const DEPLOY_AREA_SIZE = Vector2(4, 8)

var palette_pale = Color("d1d1d1")
var palette_darkgreen = Color("0c2c2d")
var palette_brown = Color("812a0d")
var palette_teal = Color("2f7c89")
var palette_green = Color("154b4d")
var palette_darkergreen = Color("080808")

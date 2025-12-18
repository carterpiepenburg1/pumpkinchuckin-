extends Node

#Game
var score = 0
var roundNum = 1
var roundTime = 80

#Enemy placement
var enemyStartDistance = 32
var rowWidth = 15
var enemiesPerRow = 5

#Enemy density
var enemyDensity = 0.2
var enemyDensityIncrease = 0.2

#Enemy advancing
var advanceTime = 8
var advanceAmount = 8

#Advances 8 every 10 seconds for 80 seconds rounds = 8 advances of 8 = 64 total distance

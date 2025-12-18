extends Node

#Game
var score = 0
var roundNum = 3
var roundTime = 80

#Enemy placement
var enemyStartDistance = 20
var rowWidth = 10
var enemiesPerRow = 5
var enemyDensity = 0.5

#Enemy advancing
var advanceTime = 8
var advanceAmount = 4

#Advances 4 every 8 seconds for 80 seconds rounds = 10 advances of 4 = 40 total distance

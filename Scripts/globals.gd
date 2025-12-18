extends Node

#Game
var score = 0
var roundNum = 1
var roundTime = 60

#Enemy placement
var enemyStartDistance = 30
var enemyDespawnDistance = 6
var rowWidth = 15
var enemiesPerRow = 5

#Enemy advancing
var advanceTime = 6
var advanceAmount = 6

#Enemy density
var enemyDensity = 0.2
var enemyDensityIncrease = 0.2

#Advances 6 every 6 seconds for 60 seconds rounds = 10 advances of 6 = 60 total distance

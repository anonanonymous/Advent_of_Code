import strutils
import std/algorithm
import math

proc partOne(input: seq[string]): void =
    var calories = 0
    var calorieList: seq[int] = @[]
    for i in input:
        if i == "":
            calorieList.add(calories)
            calories = 0
        else:
            calories += parseInt(i)
    calorieList.sort()
    echo calorieList[len(calorieList)-1]
    echo sum(calorieList[len(calorieList)-3..len(calorieList)-1])

let f = split(strip(readFile("input.txt")), "\n")
partOne(f)

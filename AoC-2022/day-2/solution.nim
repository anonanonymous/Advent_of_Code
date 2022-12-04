import strutils
import sets
import tables

proc gameScoreOne(elfHand: string, myHand: string): int =
    let winConditions = toHashSet(["AY", "BZ", "CX"])
    let drawConditions = toHashSet(["AX", "BY", "CZ"])
    let scoreMap = {"X": 1, "Y": 2, "Z": 3}.toTable
    var score = 0
    if drawConditions.contains(elfHand & myHand):
        score = 3
    elif winConditions.contains(elfHand & myHand):
        score = 6

    return scoreMap[myHand] + score

proc gameScoreTwo(elfHand: string, outcome: string): int =
    let loseMap = {"A": "Z", "B": "X", "C": "Y"}.toTable
    let drawMap = {"A": "X", "B": "Y", "C": "Z"}.toTable
    let winMap = {"A": "Y", "B": "Z", "C": "X"}.toTable
    if outcome == "Y":
        return gameScoreOne(elfHand, drawMap[elfHand])
    elif outcome == "Z":
        return gameScoreOne(elfHand, winMap[elfHand])
    elif outcome == "X":
        return gameScoreOne(elfHand, loseMap[elfHand])


proc partOne(input: seq[string]): void =
    var score = 0

    for i in input:
        let round = i.split(' ')
        score += gameScoreOne(round[0], round[1])
    echo score

proc partTwo(input: seq[string]): void =
    var score = 0

    for i in input:
        let round = i.split(' ')
        score += gameScoreTwo(round[0], round[1])
    echo score

let f = split(strip(readFile("input.txt")), "\n")
partOne(f)
partTwo(f)

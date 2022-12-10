import strutils
import sequtils
import sets
import tables

proc getDiff(head: tuple, tail: tuple): tuple =
    let diff = (x: abs(head.x - tail.x), y: abs(head.y - tail.y))
    return diff

proc handleMove(head: var tuple, tail: var tuple): tuple =
    result = (x: 0, y: 0)
    let diff = getDiff(head, tail)
    if diff.x > 1 and diff.y == 0:
        if head.x > tail.x:
            result.x += 1
        else:
            result.x -= 1
    elif diff.y > 1 and diff.x == 0:
        if head.y > tail.y:
            result.y += 1
        else:
            result.y -= 1
    elif (diff.x == 2 and diff.y == 2) or (diff.x == 2 and diff.y == 1) or (diff.y == 2 and diff.x == 1):
        if head.y > tail.y:
            result.y += 1
        else:
            result.y -= 1
        if head.x > tail.x:
            result.x += 1
        else:
            result.x -= 1
    return result

proc simulateMovement(ropeSize: int, input: seq[string]): void =
    var rope: seq[tuple[x: int, y: int]]
    for i in 0..<ropeSize: rope.add((x: 0, y: 0))
    var tailPositions = initCountTable[string]()

    for i in input:
        let move = i.split(" ")
        let steps = parseInt(move[1])
        case move[0]
        of "R", "L":
            for step in 0..<steps:
                rope[0].x += (if move[0] == "R": 1 else: -1)
                for j in 1..rope.high:
                    let diff = handleMove(rope[j-1], rope[j])
                    rope[j].x += diff.x
                    rope[j].y += diff.y
                    if j == rope.high:
                        tailPositions.inc($rope[j].x & $rope[j].y)
        of "U", "D":
            for i in 0..<steps:
                rope[0].y += (if move[0] == "U": 1 else: -1)
                for j in 1..rope.high:
                    let diff = handleMove(rope[j-1], rope[j])
                    rope[j].x += diff.x
                    rope[j].y += diff.y
                    if j == rope.high:
                        tailPositions.inc($rope[j].x & $rope[j].y)

    echo len(tailPositions)

proc partOne(input: seq[string]): void =
    simulateMovement(2, input)

proc partTwo(input: seq[string]): void =
    simulateMovement(10, input)

let f = split(strip(readFile("input.txt")), "\n")
partOne(f)
partTwo(f)
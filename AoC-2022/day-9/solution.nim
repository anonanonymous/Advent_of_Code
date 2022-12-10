import strutils
import sequtils
import sets
import tables

proc getDiff(head: tuple, tail: tuple): tuple =
    let diff = (x: abs(head.x - tail.x), y: abs(head.y - tail.y))
    return diff

proc handleMove(head: var tuple, tail: var tuple, move: seq): CountTable[string] =
        let steps = parseInt(move[1])
        case move[0]
        of "R":
            for i in 0..<steps:
                head.x += 1
                let diff = getDiff(head, tail)
                echo diff, " ", move[0]
                if diff.x == 2:
                    tail.x += 1
                    tail.y += head.y - tail.y
                if diff.y == 2:
                    tail.x += 1
                    tail.y += head.y - tail.y
                result.inc($tail.x & $tail.y)
        of "L":
            for i in 0..<steps:
                head.x -= 1
                let diff = getDiff(head, tail)
                echo diff, " ", move[0]
                if diff.x == 2:
                    tail.x -= 1
                    tail.y += head.y - tail.y
                if diff.y == 2:
                    tail.x -= 1
                    tail.y += head.y - tail.y
                result.inc($tail.x & $tail.y)
        of "U":
            for i in 0..<steps:
                head.y += 1
                let diff = getDiff(head, tail)
                echo diff, " ", move[0]
                if diff.x == 2:
                    tail.y += 1
                    tail.x += head.x - tail.x
                if diff.y == 2:
                    tail.y += 1
                    tail.x += head.x - tail.x
                result.inc($tail.x & $tail.y)
        of "D":
            for i in 0..<steps:
                head.y -= 1
                let diff = getDiff(head, tail)
                if diff.x == 2:
                    tail.y -= 1
                    tail.x += head.x - tail.x
                if diff.y == 2:
                    tail.y -= 1
                    tail.x += head.x - tail.x
                result.inc($tail.x & $tail.y)
        return result


proc partOne(input: seq[string]): void =
    var head = (x: 0, y: 0)
    var tail = (x: 0, y: 0)
    var tailPositions = initCountTable[string]()

    for i in input:
        let move = i.split(" ")
        tailPositions.merge(handleMove(head, tail, move))
    echo len(tailPositions)

let f = split(strip(readFile("input.txt")), "\n")
partOne(f)

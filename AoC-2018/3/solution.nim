import re, sequtils, strutils

proc part_two[I](input: seq[seq[int]], fabric: array[I, array[I, char]]): int =
    var found: bool
    for claim in input:
        found = false
        for i in 0..<claim[4]:
            for j in 0..<claim[3]:
                if fabric[i + claim[2]][j + claim[1]] == 'X':
                    found = true
        if found == false:
            return claim[0]

proc part_one(input: seq[seq[int]]): tuple[res: int, graph: array[1000, array[1000, char]]] =
    var fabric: array[1000, array[1000, char]]
    for claim in input:
        for i in 0..<claim[4]:
            for j in 0..<claim[3]:
                case fabric[i + claim[2]][j + claim[1]]
                of '\0':
                    fabric[i + claim[2]][j + claim[1]] = '#'
                of '#':
                    fabric[i + claim[2]][j + claim[1]] = 'X'
                    result[0] += 1
                else: discard
    return (result[0], fabric)

let claims = map(split(strip(readFile("input.txt")), "\n"),
                 proc(x: string): seq[int] =  map(findall(x, re"\d+"),
                 proc(x: string): int = parseInt(x)))
var res = part_one(claims)
echo res[0], '\n', part_two(claims, res[1])

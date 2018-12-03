import re, sequtils, strutils

type
    Matrix[W, H: static[int]] = array[W, array[H, char]]

proc strs_to_ints(input: seq[string]): seq[int] =
    return map(input, proc(x: string): int = parseInt(x))

proc part_two(input: seq[seq[int]], fabric: Matrix): int =
    var found: bool
    for claim in input:
        found = false
        for i in 0..<claim[4]:
            for j in 0..<claim[3]:
                if fabric[i + claim[2]][j + claim[1]] == 'X':
                    found = true
        if found == false:
            return claim[0]

proc part_one(input: seq[seq[int]]): int =
    var fabric: Matrix[1000, 1000]
    for claim in input:
        for i in 0..<claim[4]:
            for j in 0..<claim[3]:
                if fabric[i + claim[2]][j + claim[1]] == '\0':
                    fabric[i + claim[2]][j + claim[1]] = '#'
                else:
                    fabric[i + claim[2]][j + claim[1]] = 'X'
    for thread in fabric:
        result += count(thread, 'X')
    echo result
    echo part_two(input, fabric)


let f = split(strip(readFile("input.txt")), "\n")
let claims = map(f, proc(x: string): seq[int] = strs_to_ints(findall(x, re"\d+")))
discard part_one(claims)

import strutils
import sets

proc getMarker(stream: string, size: int): int =
    var index = 0
    while index < stream.len:
        let ss = toHashSet(stream[index..index+size-1])
        if len(ss) == size:
            return index + size
        index += 1


proc partOne(input: seq[string]): void =
    for i in input:
        echo getMarker(i, 4)
        echo getMarker(i, 14)


let f = split(strip(readFile("input.txt")), "\n")
partOne(f)
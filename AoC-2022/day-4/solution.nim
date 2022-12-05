import strutils

proc partOne(input: seq[string]): void =
    var count = 0
    for i in input:
        let pair = i.split(",")
        let firstRange = pair[0].split("-")
        let secondRange = pair[1].split("-")
        let firstX = parseInt(firstRange[0])
        let firstY = parseInt(firstRange[1])
        let secondX = parseInt(secondRange[0])
        let secondY = parseInt(secondRange[1])
        if firstX <= secondX and firstY >= secondY:
            count += 1
        elif secondX <= firstX and secondY >= firstY:
            count += 1

    echo count

proc partTwo(input: seq[string]): void =
    var count = 0
    for i in input:
        let pair = i.split(",")
        let firstRange = pair[0].split("-")
        let secondRange = pair[1].split("-")
        let firstX = parseInt(firstRange[0])
        let firstY = parseInt(firstRange[1])
        let secondX = parseInt(secondRange[0])
        let secondY = parseInt(secondRange[1])
        if firstX >= secondX and firstX <= secondY:
            count += 1
        elif firstY >= secondX and firstY <= secondY:
            count += 1
        elif secondX >= firstX and secondX <= firstY:
            count += 1
        elif secondY >= firstX and secondY <= firstY:
            count += 1

    echo count

let f = split(strip(readFile("input.txt")), "\n")
partOne(f)
partTwo(f)

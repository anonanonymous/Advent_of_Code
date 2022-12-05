import strutils
import sets
import math

proc getPriority(containerOne: HashSet, containerTwo: HashSet): int =
    let item = intersection(containerOne, containerTwo)
    for letter in item.items:
        return if letter.isLowerAscii: ord(letter) - 96 else: ord(letter) - 38

proc partOne(input: seq[string]): void =
    var priorityList: seq[int] = @[]
    for i in input:
        let containerOne = i.substr(0, (len(i) / 2).int - 1).toHashSet
        let containerTwo = i.substr((len(i) / 2).int, len(i) - 1).toHashSet
        let priority = getPriority(containerOne, containerTwo)
        priorityList.add(priority)
    echo sum(priorityList)

proc partTwo(input: seq[string]): void =
    var priorityList: seq[int] = @[]
    var container = initHashSet[char]()
    var elfCount = 1
    for i in input:
        if elfCount == 2:
            container = intersection(container, i.toHashSet)
        elif elfCount == 3:
            let priority = getPriority(container, i.toHashSet)
            priorityList.add(priority)
            elfCount = 0
        else:   
            container = i.toHashSet
        elfCount += 1
    echo sum(priorityList)

let f = split(strip(readFile("input.txt")), "\n")
partOne(f)
partTwo(f)

import intsets, strutils

proc part_one(input: seq[string]): int =
    result = 0
    for i in input:
        result += parseInt(i)

proc part_two(input: seq[string]): int =
    var numSet = initIntSet()
    result = 0
    
    numSet.incl(0)
    for i in input:
        result += parseInt(i)
        if numSet.contains(result):
            return result
        numSet.incl(result)

    while true:
        for i in input:
            result += parseInt(i)
            if numSet.contains(result):
                return result

var f = split(strip(readFile("input.txt")), "\n")
echo part_one(f)
echo part_two(f)

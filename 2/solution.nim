import sets, strutils, tables

proc part_one(input: seq[string]): int =
    var dubs, trips = 0
    var seen = [false, false]
    var temp = initCountTable[char]()

    for line in input:
        for ch in line:
            temp[ch] = if temp.getOrDefault(ch) == 0: 1 else: temp[ch] + 1
        for k, val in temp.pairs():
            if val == 2 and not seen[0]:
                dubs += 1
                seen[0] = true
            elif val == 3 and not seen[1]:
                trips += 1
                seen[1] = true
            elif seen[0] and seen[1]:
                break
        seen[0] = false
        seen[1] = false
        temp.clear()
    return dubs * trips


proc part_two(input: seq[string]): string =
    var new_item: string
    var table = initSet[string]()

    for i in 0..input[0].high:
        for item in input:
            new_item = item[0..i] & item[i+1..item.high]
            if table.contains(new_item):
                return new_item
            table.incl(new_item)
    return new_item

var f = split(strip(readFile("input.txt")), "\n")
echo part_one(f)
echo part_two(f)

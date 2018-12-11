import sequtils, strutils, tables

proc part_one(relations: seq[tuple[p, c: char]]): string =
    var dependencies = initTable[char, int]()
    var mapping = initTable[char, seq[char]]()
    var done, tmp = newSeq[char]()
    var choice: char

    for item in relations:
        if dependencies.hasKey(item[1]): dependencies[item[1]] += 1 else: dependencies[item[1]] = 1
    for item in relations:
        if not dependencies.hasKey(item[0]): dependencies[item[0]] = 0
    for i in relations:
        if not mapping.hasKey(i[0]): mapping[i[0]] = @[i[1]]
        else: mapping[i[0]].add(i[1])

    while dependencies.len > 0:
        for k, v in dependencies.pairs():
            if v == 0: tmp.add(k)
        choice = tmp[0]
        for i in 1..tmp.high: choice = min(tmp[i], choice)
        if mapping.hasKey(choice):
            for i in mapping[choice]: dependencies[i] -= 1
        done.add(choice)
        dependencies.del(choice)
        tmp = @[]
    return cast[string](done)

let input = map(readFile("input.txt").strip.splitLines,
                proc(s: string): tuple[p, c: char] = (s[5], s[36]))
echo part_one(input)

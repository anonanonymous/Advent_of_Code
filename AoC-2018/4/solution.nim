import algorithm, re, sequtils, strutils, tables

proc solution(input: seq[seq[int]]): tuple[part_1, part_2: int] =
    var records = initTable[int, CountTable[int]]()
    var time = initTable[int, int]()
    var sleep = true
    var id, offset, max, hold = 0

    for i in input:
        if i.len == 5 and sleep:
            offset = if i[3] == 0: i[4] else: 0
            sleep = false
        elif i.len == 5:
            if not records.hasKey(id): records[id] = initCountTable[int]()
            if not time.hasKey(id): time[id] = i[4] - offset
            else: time[id] += i[4] - offset
           
            for j in offset..<i[4]:
                if records[id].hasKey(j): records[id][j].inc()
                else: records[id][j] = 1
            offset = 0
            sleep = true
        else:
            id = i[i.high]
            offset = if i[3] == 0: i[4] else: 0
    for k, v in time:
        if v > max:
            max = v
            id = k
    hold = records[id].largest()[0] * id
    offset = 0

    for k, v in records.pairs():
        if v.largest()[1] > offset:
            offset = v.largest()[1]
            max = v.largest()[0]
            id = k

    return (hold, max * id)

var input = map(split(strip(readFile("input.txt")), "\n"),
                 proc(x: string): seq[int] =  map(findall(x, re"\d+"),
                 proc(x: string): int = parseInt(x)))

for i in countDown(4, 1):
    sort(input) do (x, y: seq[int]) -> int: cmp(x[i], y[i])

echo solution(input)

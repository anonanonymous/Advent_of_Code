import intsets, sequtils, strutils, tables

proc man_dist(p, q: tuple[x, y: int]): int =
    return abs(p[0] - q[0]) + abs(p[1] - q[1])

proc part_one(indices: seq[tuple[x, y: int]]): int =
    var ceil: array[2, int]
    var min_index: int
    var values =  newSeq[int](indices.len)
    var inf_set = initIntSet()
    var counter = initCountTable[int]()

    for i in 0..indices.high:
        ceil[0] = max(ceil[0], indices[i][0])
        ceil[1] = max(ceil[1], indices[i][1])

    for i in 0..ceil[0]:
        for j in 0..ceil[1]:
            for xy in 0..indices.high:
                values[xy] = man_dist((i, j), indices[xy])
                if xy > 0:
                    min_index = if values[min_index] > values[xy]: xy else: min_index
            if i == 0 or j == 0 or i == ceil[0] or j == ceil[1]:
                if values.count(values[min_index]) == 1:
                    if counter.hasKey(min_index): counter[min_index] = 0
                    inf_set.incl(min_index)

            elif not inf_set.contains(min_index):
                if not counter.hasKey(min_index):
                    counter[min_index] = 1
                else:
                    counter[min_index] += 1
            min_index = 0
    return counter.largest[1]

proc part_two(indices: seq[tuple[x, y: int]], limit: int): int =
    var ceil: array[2, int]
    var sum: int
    for i in 0..indices.high:
        ceil[0] = max(ceil[0], indices[i][0])
        ceil[1] = max(ceil[1], indices[i][1])
    for i in 0..ceil[0]:
        for j in 0..ceil[1]:
            for idx in indices: sum += man_dist((j, i), idx)
            if sum < limit: result += 1
            sum = 0

let input = map(readFile("input.txt").strip.splitLines,
                proc(s: string): tuple[x, y:int] =
                    let tmp = s.split({',', ' '})
                    (parseInt(tmp[2]), parseInt(tmp[0])))

echo part_one(input)
echo part_two(input, 10000)

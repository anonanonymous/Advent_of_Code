import algorithm, sequtils, strutils, tables

proc solution(input: seq[seq[string]]): tuple[part_1, part_2: int] =
    var time: array[60, seq[int]]
    var guard_times = initCountTable[int]()
    var last_awake, current_id, idx, max, hold: int

    for i in 0..59:
        time[i] = newSeq[int]()

    for record in input:
        if record[2].contains("Guard"):
            idx = 7
            current_id = 0
            while record[2][idx] != ' ':
                current_id += (ord(record[2][idx]) - ord('0'))
                if record[2][idx + 1] != ' ': current_id *= 10
                inc(idx)
            if record[0] == "00":
                last_awake = parseInt(record[1])
            else:
                last_awake = 0
        elif record[2].contains("falls"):
            last_awake = parseInt(record[1]) - 1
        elif record[2].contains("wakes"):
            for i in last_awake + 1..<parseInt(record[1]):
                time[i].add(current_id)
            last_awake = parseInt(record[1])

    for i in 0..59:
        for record in time[i]:
            if guard_times.hasKey(record):
                inc(guard_times[record])
            else:
                guard_times[record] = 1

    current_id = guard_times.largest()[0]
    for i in 0..59:
        idx = time[i].count(current_id)
        if max < idx:
            max = idx
            last_awake = i
    hold = current_id * last_awake
    max = 0
    var offset = 0
    for i in 0..59:
        while offset < time[i].len:
            idx = time[i].count(time[i][offset])
            if idx > max:
                max = idx
                last_awake = i
                current_id = time[i][offset]
            offset += idx
        offset = 0
    return ((hold, current_id * last_awake))

var input = map(readFile("biginput.txt").strip.splitLines.sorted(cmp),
                proc(x: string): seq[string] =
                    @[x[12..13], x[15..16], x[19..x.high]])

echo solution(input)

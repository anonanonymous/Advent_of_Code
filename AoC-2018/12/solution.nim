import math, strutils, tables

proc solve(line: var string, dict: var Table[string, char]): int64 =
    var offset, zeroes, prev, hold: int64
    var new_line, temp: string

    for p in 0 ..< 50000000000:
        for i in 0 .. 3:
            temp = ""
            for _ in 0 .. 3 - i: temp.add('.')
            temp.add(line[0 .. i].join(""))
            if dict.hasKey(temp):
                zeroes += 1
                new_line.add(dict[temp])
            else:
                new_line.add('.')
        for i in 0 .. line.high - 4:
            temp = line[i .. i + 4].join("")
            if dict.hasKey(temp):
                new_line.add(dict[temp])
            else:
                new_line.add('.')
        for i in 0 .. 3:
            temp = line[line.high - (3 - i) .. line.high].join("")
            for _ in 0 .. i: temp.add('.')
            if dict.hasKey(temp):
                new_line.add(dict[temp])
            else:
                new_line.add('.')

        line = new_line
        new_line = ""
        offset = -int64(ceil(float(zeroes div int64(2))))
        for i in line:
            if i == '#': result += offset
            offset += 1
        if p == 19: echo "Part 1: ", result
        if result - prev == hold:
            result += (hold * (50000000000 - (p + 1)))
            echo "Part 2: ", result
            return
        hold = result - prev
        prev = result
        result = 0

var initial = "#...##.#...#..#.#####.##.#..###.#.#.###....#...#...####.#....##..##..#..#..#..#.#..##.####.#.#.###"
let notes = """
..... => .
..#.. => #
..##. => #
#..## => .
..#.# => #
####. => .
##.## => .
#.... => .
###.. => #
##### => #
##..# => #
#.### => #
#..#. => #
.#### => #
#.#.. => #
.###. => #
.##.. => #
.#... => #
.#.## => #
##... => #
..### => .
##.#. => .
...## => .
....# => .
###.# => .
#.##. => #
.##.# => .
.#..# => #
#.#.# => #
.#.#. => #
...#. => #
#...# => #""".splitLines

var d = initTable[string, char]()
for line in notes: d[line[0 .. 4]] = line[line.high]

discard solve(initial, d)

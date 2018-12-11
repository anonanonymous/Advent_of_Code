import re, sequtils, strutils

proc converge(stars: ref seq[tuple[x, y, h, v: int]]): int =
    var prev = high(int)

    while true:
        prev = max(stars[])[0] - min(stars[])[0]
        if (max(stars[])[0] + max(stars[])[2]) - (min(stars[])[0] + min(stars[])[2]) > prev:
            break
        for i in 0 .. stars[].high:
            stars[][i][0] = stars[][i][0] + stars[][i][2]
            stars[][i][1] = stars[][i][1] + stars[][i][3]
        result += 1

proc display(stars: seq[tuple[x, y, h, v: int]]): seq[seq[char]] =
    var min_x, min_y = high(int)
    var max_x, max_y = low(int)
    var grid: seq[seq[char]]

    for i in stars:
        if i[0] < min_x: min_x = i[0]
        if i[1] < min_y: min_y = i[1]
        if i[0] > max_x: max_x = i[0]
        if i[1] > max_y: max_y = i[1]

    grid = newSeq[seq[char]](10)
    for i in 0 .. grid.high:
        grid[i] = newSeq[char](max_x - min_x + 1)
        for j in 0 .. grid[i].high: grid[i][j] = '.'

    for i in 0 .. stars.high:
        grid[stars[i][1] - abs(min_y)][stars[i][0] - abs(min_x)] = '#'

    return grid

var stars: ref seq[tuple[x, y, h, v: int]] = new seq[tuple[x, y, h, v: int]]

for line in readFile("input.txt").strip.splitLines:
    let tmp = re.findall(line, re"-?\d+")
    stars[].add((parseInt(tmp[0]), parseInt(tmp[1]), parseInt(tmp[2]), parseInt(tmp[3])))

echo "seconds: ", converge(stars)
for i in display(stars[]): echo cast[string](i)

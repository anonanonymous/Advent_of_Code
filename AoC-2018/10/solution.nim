import re, sequtils, strutils

proc converge(positions, velocities: ref seq[tuple[x, y: int]]): int =
    var prev = high(int)

    while max(positions[])[0] - min(positions[])[0] < prev:
        result += 1
        prev = max(positions[])[0] - min(positions[])[0]
        for i in 0 .. positions[].high:
            positions[][i] = (positions[][i][0] + velocities[][i][0], positions[][i][1] + velocities[][i][1])
    for i in 0 .. positions[].high:
        positions[][i] = (positions[][i][0] - velocities[][i][0], positions[][i][1] - velocities[][i][1])
    return result - 1

proc display(positions: seq[tuple[x, y: int]]): seq[seq[char]] =
    var min_x, min_y = high(int)
    var max_x, max_y = low(int)
    var grid: seq[seq[char]]

    for i in positions:
        if i[0] < min_x: min_x = i[0]
        if i[1] < min_y: min_y = i[1]
        if i[0] > max_x: max_x = i[0]
        if i[1] > max_y: max_y = i[1]

    grid = newSeq[seq[char]](10)
    for i in 0 .. grid.high:
        grid[i] = newSeq[char](max_x - min_x + 1)
        for j in 0 .. grid[i].high: grid[i][j] = '.'

    for i in 0 .. positions.high:
        grid[positions[i][1] - abs(min_y)][positions[i][0] - abs(min_x)] = '#'

    return grid

var velocities, positions: ref seq[tuple[x, y: int]]
positions = new seq[tuple[x, y: int]]
velocities = new seq[tuple[x, y: int]]

for line in readFile("input.txt").strip.splitLines:
    let tmp = re.findall(line, re"-?\d+")
    positions[].add((parseInt(tmp[0]), parseInt(tmp[1])))
    velocities[].add((parseInt(tmp[2]), parseInt(tmp[3])))
echo "seconds: ", converge(positions, velocities)
for i in display(positions[]): echo cast[string](i)

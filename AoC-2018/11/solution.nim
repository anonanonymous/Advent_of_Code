import math

proc compute_grid(idx: tuple[x, y: int], serial: int): int =
    let rack_id = idx[1] + 1 + 10
    var power_level = rack_id * (idx[0] + 1)
    power_level += serial
    power_level *= rack_id
    power_level = int(power_level / 100) mod 10
    return power_level - 5

proc get_sum(grid: ref array[300, array[300, int]]): int =
    var tmp = 0
    for s in 1 ..< 300:
        for i in 0 .. grid[].high - s:
            for j in 0 .. grid[][i].high - s:
                for ii in 0 ..< s:
                    tmp += sum(grid[][i + ii][j ..< j + s])
                if result < tmp:
                    result = tmp
                    echo j + 1," ", i + 1, " ", s
                tmp = 0

var grid = new array[300, array[300, int]]
for i in 0 .. grid[].high:
    for j in 0 .. grid[][i].high:
        grid[][i][j] = compute_grid((i, j), 7689)

echo get_sum(grid)

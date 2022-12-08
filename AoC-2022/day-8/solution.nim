import strutils
import sequtils

proc toIntSeq(line: string): seq[int] =
    var numbers: seq[int] = @[]
    for i in line: numbers.add(parseInt($i))
    return numbers

proc checkVisibleHorizontal(grid: seq[seq[int]], x: int, y: int): bool =
    var visibleLeft = true
    var visibleRight = true
    for i in 0..y-1:
        if grid[x][i] >= grid[x][y]:
            visibleLeft = false
    for i in y+1..grid.high:
        if grid[x][i] >= grid[x][y]:
            visibleRight = false
    return visibleLeft or visibleRight

proc checkVisibleVertical(grid: seq[seq[int]], x: int, y: int): bool =
    var visibleUp = true
    var visibleDown = true
    for i in 0..x-1:
        if grid[i][y] >= grid[x][y]:
            visibleDown = false
    for i in x+1..grid.high:
        if grid[i][y] >= grid[x][y]:
            visibleUp = false
    return visibleUp or visibleDown

proc isVisible(grid: seq[seq[int]], x: int, y: int): bool =
    if x == 0 or y == grid.high or x == grid.high or y == 0:
        return true
    if checkVisibleVertical(grid, x, y) or checkVisibleHorizontal(grid, x, y):
        return true

proc getScenicScore(grid: seq[seq[int]], x: int, y: int): int =
    var left = 0
    var right = 0
    var up = 0
    var down = 0
    if x == 0 or y == grid.high or x == grid.high or y == 0:
        return 0

    for i in countdown(y-1, 0):
        left += 1
        if grid[x][i] >= grid[x][y]:
            break
    for i in y+1..grid.high:
        right += 1
        if grid[x][i] >= grid[x][y]:
            break
    for i in countdown(x-1, 0):
        up += 1
        if grid[i][y] >= grid[x][y]:
            break
    for i in x+1..grid.high:
        down += 1
        if grid[i][y] >= grid[x][y]:
            break
    return left * right * up * down

proc partOne(input: seq[string]): void =
    var grid: seq[seq[int]] = @[]
    var visibleTrees = 0
    var largestScore = 0
    for i in input:
        grid.add(toIntSeq(i))

    for row in 0..grid.high:
        for col in 0..grid[row].high:
            let score = getScenicScore(grid, row, col)
            if score > largestScore:
                largestScore = score
                
            if isVisible(grid, row, col):
                visibleTrees += 1
    echo visibleTrees
    echo largestScore



let f = split(strip(readFile("input.txt")), "\n")
partOne(f)

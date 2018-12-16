import algorithm, sequtils, strutils, sets

proc solve(tracks: var seq[string]): tuple[x, y: int] =
    var carts = newSeq[tuple[x, y: int, direction: int, c: char]]()
    var pos = initSet[tuple[x, y: int]]()
    var tmp: tuple[x, y: int]
    var i: int

    for row in 0 .. tracks.high:
        for col in 0 .. tracks[row].high:
            if tracks[row][col] in ['>', '<']:
                pos.incl((row, col))
                carts.add((row, col, -1, tracks[row][col]))
                tracks[row][col] = '-'
            if tracks[row][col] in ['^', 'v']:
                pos.incl((row, col))
                carts.add((row, col, -1, tracks[row][col]))
                tracks[row][col] = '|'
    while true:
        carts.sort do (x, y: tuple[x, y: int, direction: int, c: char]) -> int:
            result = cmp(x.x, y.x)
            if result == 0: result = cmp(x.y, y.y)
        while i < carts.len:
            if carts.len == 1:
                return
            pos.excl((carts[i].x, carts[i].y))
            tmp = (carts[i].x, carts[i].y)
            if carts[i].c == '>':
                case tracks[carts[i].x][carts[i].y + 1]
                of '-':
                    carts[i].c = '>'
                of '+':
                    if carts[i].direction == -1:
                        carts[i].c = '^'
                        carts[i].direction += 1
                    elif carts[i].direction == 0:
                        carts[i].c = '>'
                        carts[i].direction += 1
                    elif carts[i].direction == 1:
                        carts[i].c = 'v'
                        carts[i].direction = -1
                of '\\':
                    carts[i].c = 'v'
                of '/':
                    carts[i].c = '^'
                else: discard

                if pos.contains((carts[i].x, carts[i].y + 1)):
                    echo "Crash at: ", carts[i].y + 1, ",", carts[i].x
                    pos.excl((carts[i].x, carts[i].y + 1))
                    keepIf(carts, proc(c: tuple[x, y: int, direction: int, c: char]): bool =
                        (c.x, c.y) != (tmp.x, tmp.y + 1) and (c.x, c.y) != (tmp.x, tmp.y))
                    i -= 1
                else:
                    pos.incl((carts[i].x, carts[i].y + 1))
                    carts[i].y += 1
                    i += 1

            elif carts[i].c == '<':
                case tracks[carts[i].x][carts[i].y - 1]
                of '-':
                    carts[i].c = '<'
                of '+':
                    if carts[i].direction == -1:
                        carts[i].c = 'v'
                        carts[i].direction += 1
                    elif carts[i].direction == 0:
                        carts[i].c = '<'
                        carts[i].direction += 1
                    elif carts[i].direction == 1:
                        carts[i].c = '^'
                        carts[i].direction = -1
                of '/':
                    carts[i].c = 'v'
                of '\\':
                    carts[i].c = '^'
                else: discard

                if pos.contains((carts[i].x, carts[i].y - 1)):
                    echo "Crash at: ", carts[i].y - 1, ",", carts[i].x
                    pos.excl((carts[i].x, carts[i].y - 1))
                    keepIf(carts, proc(c: tuple[x, y: int, direction: int, c: char]): bool =
                        (c.x, c.y) != (tmp.x, tmp.y - 1) and (c.x, c.y) != (tmp.x, tmp.y))
                    i -= 1
                else:
                    pos.incl((carts[i].x, carts[i].y - 1))
                    carts[i].y -= 1
                    i += 1

            elif carts[i].c == '^':
                case tracks[carts[i].x - 1][carts[i].y]
                of '/':
                    carts[i].c = '>'
                of '\\':
                    carts[i].c = '<'
                of '+':
                    if carts[i].direction == -1:
                        carts[i].c = '<'
                        carts[i].direction += 1
                    elif carts[i].direction == 0:
                        carts[i].c = '^'
                        carts[i].direction += 1
                    elif carts[i].direction == 1:
                        carts[i].c = '>'
                        carts[i].direction = -1
                else: discard

                if pos.contains((carts[i].x - 1, carts[i].y)):
                    echo "Crash at: ", carts[i].y, ",", carts[i].x - 1
                    pos.excl((carts[i].x - 1, carts[i].y))
                    keepIf(carts, proc(c: tuple[x, y: int, direction: int, c: char]): bool =
                        (c.x, c.y) != (tmp.x - 1, tmp.y) and (c.x, c.y) != (tmp.x, tmp.y))
                    i -= 1
                else:
                    pos.incl((carts[i].x - 1, carts[i].y))
                    carts[i].x -= 1
                    i += 1

            elif carts[i].c == 'v':
                case tracks[carts[i].x + 1][carts[i].y]
                of '/':
                    carts[i].c = '<'
                of '\\':
                    carts[i].c = '>'
                of '+':
                    if carts[i].direction == -1:
                        carts[i].c = '>'
                        carts[i].direction += 1
                    elif carts[i].direction == 0:
                        carts[i].c = 'v'
                        carts[i].direction += 1
                    elif carts[i].direction == 1:
                        carts[i].c = '<'
                        carts[i].direction = -1
                else: discard

                if pos.contains((carts[i].x + 1, carts[i].y)):
                    echo "Crash at: ", carts[i].y, ",", carts[i].x + 1
                    pos.excl((carts[i].x + 1, carts[i].y))
                    keepIf(carts, proc(c: tuple[x, y: int, direction: int, c: char]): bool =
                        (c.x, c.y) != (tmp.x + 1, tmp.y) and (c.x, c.y) != (tmp.x, tmp.y))
                    i -= 1
                else:
                    pos.incl((carts[i].x + 1, carts[i].y))
                    carts[i].x += 1
                    i += 1
        i = 0
var lines = newSeq[string]()
for i in readFile("minput.txt").splitlines:
    lines.add(i)
                  
echo solve(lines)

import strutils

proc partOne(input: seq[string]): void =
    var register = 1
    var cycle = 0
    var sum = 0
    var crt = @[
       "........................................",
       "........................................",
       "........................................",
       "........................................",
       "........................................",
       "........................................",
    ]
    var cursor = (x: 0, y: 0)
    for i in input:
        let instructions = i.split(" ")
        let command = instructions[0]
        let val = (if command != "noop": parseInt(instructions[1]) else: 0)
        if command != "noop":
            for x in 0..1:
                if cursor.y == register - 1 or cursor.y == register or cursor.y  == register + 1:
                    crt[cursor.x][cursor.y] = '#'
                cursor.x = (if cursor.y < 39: cursor.x else: cursor.x + 1)
                cursor.y = (if cursor.y == 39: 0 else: cursor.y + 1)
                cycle += 1
                if cycle == 20 or (cycle - 20) mod 40 == 0:
                    sum += cycle * register
        else:
            if cursor.y == register - 1 or cursor.y == register or cursor.y == register + 1:
                crt[cursor.x][cursor.y] = '#'
            cursor.x = (if cursor.y < 39: cursor.x else: cursor.x + 1)
            cursor.y = (if cursor.y == 39: 0 else: cursor.y + 1)
            cycle += 1
            if cycle == 20 or (cycle - 20) mod 40 == 0:
                sum += cycle * register
        register += val

    echo sum
    for i in crt: echo i


let f = split(strip(readFile("input.txt")), "\n")
partOne(f)
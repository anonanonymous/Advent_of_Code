import strutils

proc solve(after: int) =
    let str_after = $after
    var offset = 0
    var first = 0
    var second = 1
    var stack = newSeq[char]()
    var recipies = @[3, 7]
    var p1, p2 = true

    for i in 0 .. high(int):
        if not p1 and not p2: break
        if recipies.high > after + 10 and p1:
            echo "Part one: ", recipies[after .. after + 9].join("")
            p1 = false

        for j in $(recipies[first] + recipies[second]):
            recipies.add(int(j) - ord('0'))
            if str_after[offset] == j:
                stack.add(j)
                offset += 1
            elif str_after[0] == j:
                stack = @[j]
                offset = 1
            else:
                stack = @[]
                offset = 0
            if stack.join("") == str_after and p2:
                echo "Part two: ", recipies.len - str_after.len
                p2 = false

        for step in 1 .. recipies[first] + 1:
            if (first + 1) < recipies.len: first += 1 else: first = 0

        for step in 1 .. recipies[second] + 1:
            if (second + 1) < recipies.len: second += 1 else: second = 0

solve(894501)

import threadpool

proc helper(input: string, ch: char): int =
    var stack = newSeq[char]()
    for i in input:
        if ord(i) < 65 and ord(i) > 91 or
             ord(i) < 97 and ord(i) > 122: continue
        elif stack.len == 0: stack.add(i)
        elif ch != '\0' and i == chr(ord(ch) - 32) or i == ch: continue
        elif abs(ord(stack[stack.high]) - ord(i)) == 32:
            stack.del(stack.high)
        else: stack.add(i)
    return stack.high

proc part_one(input: string): int =
    return helper(input, '\0')

proc part_two(input: string): int =
    var count_t: array[26, FlowVar[int]]
    var smallest: int

    for i in 'a'..'z':
        count_t[ord(i) - ord('a')] = spawn helper(input, i)
    sync()

    smallest = ^count_t[0]
    for i in count_t[1..25]:
        if ^i < smallest: smallest = ^i
    return smallest

let input = stdin.readAll
echo part_one(input)
echo part_two(input)

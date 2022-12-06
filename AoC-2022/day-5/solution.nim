import strutils

var crates = @[
    @["S", "C", "V", "N"],
    @["Z", "M", "J", "H", "N", "S"],
    @["M", "C", "T", "G", "J", "N", "D"],
    @["T", "D", "F", "J", "W", "R", "M"],
    @["P", "F", "H"],
    @["C", "T", "Z", "H", "J"],
    @["D", "P", "R", "Q", "F", "S", "L", "Z"],
    @["C", "S", "L", "H", "D", "F", "P", "W"],
    @["D", "S", "M", "P", "F", "N", "G", "Z"]
]
proc moveCrateOne(count: int, src: int, dest: int): void =
    for i in 0..count-1:
        crates[dest].add(crates[src].pop)

proc moveCrates(count: int, src: int, dest: int): void =
    var init = crates[dest].len
    for i in 0..count-1:
        crates[dest].insert(crates[src].pop, init)

proc partOne(input: seq[string]): void =
    for i in input:
        let instructions = i.split(" ")
        moveCrateOne(parseInt(instructions[1]), parseInt(instructions[3])-1, parseInt(instructions[5])-1)
    for i in crates: stdout.write i[i.high]
    echo ""

proc partTwo(input: seq[string]): void =
    for i in input:
        let instructions = i.split(" ")
        moveCrates(parseInt(instructions[1]), parseInt(instructions[3])-1, parseInt(instructions[5])-1)
    for i in crates: stdout.write i[i.high]
    echo ""

let f = split(strip(readFile("input.txt")), "\n")
let crateCopy = crates
partOne(f)
crates = crateCopy
partTwo(f)

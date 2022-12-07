import strutils
import sequtils

type
  Node* = object
    name*: string
    size*: int
    children*: seq[ref Node]
    parent*: ref Node


proc isDir(fs: ref Node): bool =
    return len(fs.children) > 0

proc getDirSum(fs: ref Node): int =
    var size = 0
    var stack = fs.children
    while len(stack) > 0:
        if stack[0].size < 100000 and isDir(stack[0]):
            size += stack[0].size
        stack = concat(stack, stack[0].children)
        stack.delete(0)
    return size

proc createDir(fs: var ref Node, name: string): void =
    if name == ".." or name == "/":
        return
    let child = new(Node)
    child.name = name
    child.parent = fs
    fs.children.add(child)

proc changeDirectory(fs: var ref Node, name: string): void =
    if name == "/":
        while fs.name != "/": fs = fs.parent
    elif name == "..":
        fs = fs.parent
    else:
        for file in fs.children:
            if file.name == name:
                fs = file
                return

proc addFile(fs: var ref Node, size: int, name: string): void =
    let node = new(Node)
    var walkToRoot = fs
    node.size = size
    node.name = name
    node.parent = fs
    fs.children.add(node)
    while walkToRoot.name != "/":  
        walkToRoot.size += size
        walkToRoot = walkToRoot.parent
    walkToRoot.size += size

proc handleInput(fs: var ref Node, arguments: seq[string]): void =
    if arguments[0] == "$" and arguments[1] == "cd":
        createDir(fs, arguments[2])
        changeDirectory(fs, arguments[2])
    elif len(arguments) == 2 and arguments[0] != "dir" and arguments[0] != "$":
        addFile(fs, parseInt(arguments[0]), arguments[1])
    elif len(arguments) == 2 and arguments[0] == "dir":
        createDir(fs, arguments[1])


proc partOne(input: seq[string]): ref Node =
    var currentDir: ref Node = new(Node)
    currentDir.name = "/"
    for i in input:
        handleInput(currentDir, i.split(" "))
    while currentDir.parent != nil:
        currentDir = currentDir.parent
    echo getDirSum(currentDir)
    return currentDir

proc partTwo(fs: ref Node): void =
    let spaceNeeded = 30000000 - (70000000 - fs.size)
    var stack = fs.children
    var currentDir = fs
    while len(stack) > 0:
        if isDir(stack[0]) and stack[0].size >= spaceNeeded and stack[0].size < currentDir.size:
            currentDir = stack[0]
        stack = concat(stack, stack[0].children)
        stack.delete(0)
    echo currentDir.size

let f = split(strip(readFile("input.txt")), "\n")
let root = partOne(f)
partTwo(root)
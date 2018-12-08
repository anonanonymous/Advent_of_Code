import sequtils, strutils

type
    Node = object
        children: seq[ref Node]
        metadata: seq[int]

proc sum_metadata(node: ref Node): int =
    for i in node.metadata: result += i
    for i in node.children: result += sum_metadata(i)

proc sum_tree(node: ref Node): int =
    for i in node.metadata:
        if i > 0 and node.children.len >= i and
            node.children[i - 1].children.len == 0:
            for n in node.children[i - 1].metadata: result += n
        elif i > 0 and node.children.len >= i:
            result += sum_tree(node.children[i - 1])

proc get_nodes(data: ref seq[int], index: int): tuple[nn: ref Node, idx: int] =
    var nn: ref Node = new(Node)
    var index = index
    var tmp: tuple[nn: ref Node, idx: int]
    let n_children = data[][index]
    let n_meta = data[][index + 1]
    for i in 0 ..< n_children:
        tmp = get_nodes(data, index + 2)
        index = tmp[1]
        nn.children.add(tmp[0])
    nn.metadata = data[][index + 2 .. index + 1 + n_meta]
    return (nn, index + n_meta)

let input: ref seq[int] = new seq[int]
input[] = map(readFile("input.txt").strip.split(" "), parseInt)
var root = get_nodes(input, 0)[0]
echo sum_metadata(root) # part 1
echo sum_tree(root)     # part 2

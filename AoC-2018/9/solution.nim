var last_marble = 70723 * 100
var scores: array[428, int64] 
var circle = newSeq[int64]()
var cur, idx: int64
circle.add(0)
circle.add(1)

idx = 1
cur = 2
for i in 2 .. last_marble:
    idx = if (idx + 2) > circle.len: (idx + 2) div circle.len else: idx + 2
    if i mod 23 == 0:
        idx = if (idx - 9) >= 0: idx - 9 else: circle.len - (9 - idx)
        scores[cur] += i
        scores[cur] += circle[idx]
        circle.delete(idx)
    else:
        circle.insert(i, idx)
    cur = if cur == 427: int64(1) else: cur + 1
echo max(scores)

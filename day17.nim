import strutils, sequtils, algorithm

const
  instructions = readFile("./inputs/17.txt").splitLines.map(parseInt)
  toFill = 150

var
  containters = sorted(instructions, cmp, SortOrder.Descending)
  combinations = newSeq[int]()


proc calc(remaining: int, containters: seq[int], used=0) =
  if remaining == 0:
    combinations.add(used)
  elif remaining > 0 and len(containters) > 0:
    let rest = containters[1 .. containters.high]
    calc(remaining - containters[0], rest, used+1)
    calc(remaining, rest, used)


calc(toFill, containters)

let m = min(combinations)
var second: int

for c in combinations:
  if c == m:
    second += 1

echo len(combinations)
echo second

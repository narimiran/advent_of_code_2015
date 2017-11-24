import strutils, sequtils, math, algorithm

const
  instructions = readFile("./inputs/24.txt").splitLines().map(parseInt)
  firstGoal = instructions.sum() div 3
  secondGoal = instructions.sum() div 4

type Package = tuple
  amount: int
  quantum: int

var presents = sorted(instructions, cmp, SortOrder.Descending)


proc calc(remaining: int, presents: seq[int], combinations: var seq[Package],
          used=0, qe=1) =
  if remaining == 0:
    combinations.add((used, qe))
  elif remaining > 0 and used < 6 and len(presents) > 0:
    let
      first = presents[0]
      rest = presents[1 .. presents.high]
    calc(remaining-first, rest, combinations, used+1, qe*first)
    calc(remaining, rest, combinations, used, qe)

proc findSolution(goal: int): int =
  var combinations = newSeq[Package]()
  calc(goal, presents, combinations)
  combinations.sort(cmp)
  return combinations[0][1]


echo findSolution(firstGoal)
echo findSolution(secondGoal)

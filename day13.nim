import strutils, tables, algorithm, math

const instructions = readFile("./inputs/13.txt").strip.splitLines

var
  people: seq[string] = @[]
  happinessChart = initTable[string, Table[string, int]]()

proc gain(a: string): int =
  if a == "gain":
    return 1
  return -1


for line in instructions:
  let
    fields = line.split()
    name = fields[0]
    neighbour = fields[^1][0 .. ^2]
    direction = gain(fields[2])
    amount = parseInt(fields[3])
  if not happinessChart.hasKey(name):
    happinessChart[name] = initTable[string, int]()
  happinessChart[name][neighbour] = direction * amount

for name in happinessChart.keys():
  people.add(name)
people.sort(cmp)


proc findHappiness(people: seq[string], secondPart=false): seq[int] =
  result = @[]
  let last = people[^1]
  var others = people[0 .. ^2]
  for _ in 0 .. fac(others.len):
    var total: int
    for i, name in others[1 .. ^1]:
      total += happinessChart[name][others[i]]
      total += happinessChart[others[i]][name]
    if not secondPart:
      # if secondPart, I'm `last`, bringing 0 happiness
      total += happinessChart[last][others[^1]]
      total += happinessChart[others[^1]][last]
      total += happinessChart[last][others[0]]
      total += happinessChart[others[0]][last]
    result.add(total)
    others.nextPermutation()
  result.sort(cmp)


let first = findHappiness(people)[^1]
echo first


people.add("me")
happinessChart["me"] = initTable[string, int]()

for name in people:
  happinessChart["me"][name] = 0
  happinessChart[name]["me"] = 0
people.sort(cmp)

let second = findHappiness(people, true)[^1]
echo second

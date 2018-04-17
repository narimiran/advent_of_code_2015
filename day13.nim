import strutils, algorithm, math

const instructions = readFile("./inputs/13.txt").strip.splitLines

var
  people = @[0, 1, 2, 3, 4, 5, 6, 7, 8]
  happinessChart: array[9, array[9, int]]
  fields: seq[string]
  name, neighbour: int
  direction, amount: int

proc gain(a: string): int =
  if a == "gain": 1 else: -1

proc parse(c: char): int =
  let i = ord(c) - ord('A')
  if i > 6: 7 else: i

for line in instructions:
  fields = line.split()
  name = fields[0][0].parse
  neighbour = fields[^1][0].parse
  direction = gain(fields[2])
  amount = parseInt(fields[3])
  happinessChart[name][neighbour] = direction * amount


proc findHappiness(people: seq[int]): seq[int] =
  result = @[]
  let last = people[^1]
  var others = people[0 .. ^2]

  # remove the obvious permutation duplicates
  var duplicates = 1
  for i in 2 .. others.high:
    duplicates += fac(i)

  for _ in duplicates .. fac(others.len):
    var total: int
    for i, name in others[1 .. ^1]:
      total += happinessChart[name][others[i]]
      total += happinessChart[others[i]][name]
    total += happinessChart[last][others[^1]]
    total += happinessChart[others[^1]][last]
    total += happinessChart[last][others[0]]
    total += happinessChart[others[0]][last]
    result.add(total)
    others.nextPermutation()


echo findHappiness(people[0 ..< people.high]).max
echo findHappiness(people).max

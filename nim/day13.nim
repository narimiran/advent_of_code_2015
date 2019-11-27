import strutils, algorithm, math

const instructions = readFile("./inputs/13.txt").strip.splitLines

let people = [0, 1, 2, 3, 4, 5, 6, 7, 8]

func gain(a: string): int =
  if a == "gain": 1 else: -1

func parse(c: char): int =
  let i = ord(c) - ord('A')
  if i > 6: 7 else: i


const happinessChart = block:
  var res: array[9, array[9, int]] 
  for line in instructions:
    let
      fields = line.split()
      name = fields[0][0].parse
      neighbour = fields[^1][0].parse
      direction = gain(fields[2])
      amount = parseInt(fields[3])
    res[name][neighbour] = direction * amount
  res


func findHappiness(people: openArray[int]): seq[int] =
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

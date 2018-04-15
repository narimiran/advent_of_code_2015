import strutils, tables, sets

const instructions = readFile("./inputs/19.txt").splitLines()

var
  replacements = initTable[string, seq[string]]()
  combinations = initSet[string]()


for i in 0 .. instructions.high()-2:
  let values = instructions[i].split(" => ")
  if not replacements.hasKey(values[0]):
    replacements[values[0]] = @[values[1]]
  else:
    replacements[values[0]].add(values[1])

let molecule = instructions[^1]


for key in replacements.keys:
  let n = len(key)
  var pos = molecule.find(key)

  while pos != -1:
    for val in replacements[key]:
      var m = molecule
      m[pos ..< pos+n] = val
      combinations.incl(m)
    pos = molecule.find(key, pos+n)

echo len(combinations)

# https://www.reddit.com/r/adventofcode/comments/3xflz8/day_19_solutions/cy4etju/
var
  noOfElements: int
for c in molecule:
  if c.isUpperAscii: inc noOfElements
let
  noOfRn = molecule.count("Rn")
  noOfY = molecule.count('Y')

echo(noOfElements - 2*noOfRn - 2*noOfY - 1)

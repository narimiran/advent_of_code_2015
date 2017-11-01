import strutils

const instructions = readFile("./inputs/01.txt")

echo instructions.count('(') - instructions.count(')')


var floor: int
for i, direction in instructions:
  case direction
  of '(': inc floor
  of ')': dec floor
  else: discard

  if floor < 0:
    echo i+1
    break

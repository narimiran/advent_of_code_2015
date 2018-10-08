import strutils, sequtils, algorithm

const instructions = readFile("./inputs/02.txt").strip.splitLines

func wrapIt(a, b, c: int): int = 2 * (a*b + a*c + b*c) + a*b
func putRibbon(a, b, c: int): int = 2*(a+b) + a*b*c

var totalWrap, totalRibbon: int

for line in instructions:
  var dimensions = line.split('x').map(parseInt)
  dimensions.sort(cmp)
  let
    a = dimensions[0]
    b = dimensions[1]
    c = dimensions[2]
  totalWrap += wrapIt(a, b, c)
  totalRibbon += putRibbon(a, b, c)

echo totalWrap
echo totalRibbon

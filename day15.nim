import re, strutils

const instructions = readFile("./inputs/15.txt").strip.splitLines
let pattern = rex"""
    (\w+):\s
    capacity \s (-*\d+), \s
    durability \s (-*\d+), \s
    flavor \s (-*\d+), \s
    texture \s (-*\d+), \s
    calories \s (-*\d+)"""

var
  caps: array[4, int]
  durs: array[4, int]
  flavs: array[4, int]
  texs: array[4, int]
  cals: array[4, int]

for i, line in instructions:
  var matches: array[6, string]
  discard line.match(pattern, matches)
  caps[i] = matches[1].parseInt
  durs[i] = matches[2].parseInt
  flavs[i] = matches[3].parseInt
  texs[i] = matches[4].parseInt
  cals[i] = matches[5].parseInt


proc calculateScore(property: openArray[int], a, b, c, d: int): int =
  a * property[0] + b * property[1] + c * property[2] + d * property[3]

var maxScore1, maxScore2: int

for a in 1 .. 97:
  for b in 1 .. 97-a:
    for c in 1 .. 97-a-b:
      block inner:
        let d = 100 - a - b - c
        var totalScore = 1
        for p in [caps, durs, flavs, texs]:
          let score = calculateScore(p, a, b, c, d)
          if score <= 0: break inner
          totalScore *= score
        if totalScore > maxScore1:
          maxScore1 = totalScore
        if totalScore > maxScore2 and calculateScore(cals, a, b, c, d) == 500:
            maxScore2 = totalScore

echo maxScore1
echo maxScore2

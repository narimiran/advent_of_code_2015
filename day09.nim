import strutils, algorithm, tables, math

const instructions = readFile("./inputs/09.txt").strip.splitLines

var
  distances: array[8, array[8, int]]
  locations = [0, 1, 2, 3, 4, 5, 6, 7]
  paths: seq[int] = @[]
  fields: seq[string]
  a, b, dist: int

proc parse(s: string): int =
  case s
    of "Faerun": 0
    of "Tristram": 1
    of "Tambi": 2
    of "Norrath": 3
    of "Snowdin": 4
    of "Straylight": 5
    of "AlphaCentauri": 6
    of "Arbre": 7
    else: -1

for line in instructions:
  fields = line.split()
  a = fields[0].parse
  b = fields[2].parse
  dist = fields[^1].parseInt
  distances[a][b] = dist
  distances[b][a] = dist


for _ in 0 .. fac(locations.len):
  var total: int
  for i, loc in locations[1 .. ^1]:
    total += distances[loc][locations[i]]
  paths.add(total)
  locations.nextPermutation()

echo min(paths)
echo max(paths)
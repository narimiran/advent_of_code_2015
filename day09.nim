import strutils, algorithm, tables, math

const instructions = readFile("./inputs/09.txt").strip.splitLines

var
  distances = initTable[string, Table[string, int]]()
  locations: seq[string] = @[]
  paths: seq[int] = @[]

for line in instructions:
  let
    fields = line.split()
    a = fields[0]
    b = fields[2]
    dist = fields[^1]
  if not distances.hasKey(a):
    distances[a] = initTable[string, int]()
  if not distances.hasKey(b):
    distances[b] = initTable[string, int]()
  distances[a][b] = parseInt(dist)
  distances[b][a] = parseInt(dist)

for k in distances.keys():
  locations.add(k)
locations = locations.sorted(cmp)

for _ in 0 .. fac(locations.len):
  var total: int
  for i, loc in locations[1 .. ^1]:
    total += distances[loc][locations[i]]
  paths.add(total)
  locations.nextPermutation()

paths = paths.sorted(cmp)

echo paths[0]
echo paths[^1]

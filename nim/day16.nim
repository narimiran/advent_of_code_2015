import strutils, tables, re

const
  instructions = readFile("./inputs/16.txt").splitLines
  ticker = {
    "children": 3,
    "cats": 7,
    "samoyeds": 2,
    "pomeranians": 3,
    "akitas": 0,
    "vizslas": 0,
    "goldfish": 5,
    "trees": 3,
    "cars": 2,
    "perfumes": 1
  }.toTable

let pattern = re"(\w+):\s(\d+)"

func check(name: string, value: int): bool =
  case name
  of "cats", "trees":
    return ticker[name] < value
  of "pomeranians", "goldfish":
    return ticker[name] > value
  else:
    return ticker[name] == value


for i, line in instructions:
  var
    sue1 = true
    sue2 = true
  for m in line.findAll(pattern):
    let
      s = m.split(": ")
      name = s[0]
      value = s[1].parseInt
    if ticker[name] != value: sue1 = false
    if not check(name, value): sue2 = false
  if sue1: echo "first: ", i+1
  if sue2: echo "second: ", i+1

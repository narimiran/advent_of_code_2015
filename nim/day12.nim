import re, strutils, json

const instructions = readFile("./inputs/12.txt").string
let pattern = re"-?\d+\b"
var total: int

for m in re.findAll(instructions, pattern):
  total += m.parseInt

echo total


let a = parseJson(instructions)

func calc(a: JsonNode): int =
  case a.kind
  of JInt:
    result += a.getInt
  of JArray:
    for e in a.items:
      result += calc(e)
  of JObject:
    var partial = 0
    for k, v in a.pairs:
      if v.kind == JString and "red" in v.str:
        return
      partial += calc(v)
    result += partial
  else: discard

echo calc(a)

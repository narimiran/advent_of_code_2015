import strutils, re

const instructions = readFile("./inputs/08.txt").strip.splitLines

var
  decodedDiff: int
  encodedDiff: int

let hx = re"\\x[0-9a-f]{2}"

proc decode(line: string): string =
  result = line.replace("\\\"", "\"").replace(r"\\", r"\").replace(hx, "0")

for line in instructions:
  decodedDiff += line.len - decode(line).len + 2
  encodedDiff += line.count("\"") + line.count("\\") + 2

echo decodedDiff
echo encodedDiff

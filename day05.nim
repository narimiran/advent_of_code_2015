import strutils

const
  instructions = readFile("./inputs/05.txt").strip.splitLines
  vowels = {'a', 'e', 'i', 'o', 'u'}
  naughty = ["ab", "cd", "pq", "xy"]


func firstPart(): int =
  for line in instructions:
    var
      nrVowels: int
      nrDoubles: int
    block inner:
      if line[0] in vowels: inc nrVowels
      for i in 1 .. line.high:
        if line[i] in vowels:
          inc nrVowels
        if line[i-1] == line[i]:
          inc nrDoubles
        if line[i-1 .. i] in naughty:
          break inner
      if nrVowels > 2 and nrDoubles > 0:
        inc result


func secondPart(): int =
  for line in instructions:
    var
      pair: bool
      repeated: bool
    for i in 0 .. line.high-2:
      if line[i+2 .. line.high].contains(line[i..i+1]):
        pair = true
        break
    for i in 0 .. line.high-2:
      if line[i] == line[i+2]:
        repeated = true
        break
    if pair and repeated: inc result


echo firstPart()
echo secondPart()

proc increment(pw: string): string =
  if pw[^1] == 'z':
    return increment(pw[0..^2]) & 'a'
  else:
    return pw[0..^2] & chr(ord(pw[^1]) + 1)

proc containsBadCharacters(pw: string, badChars = @['l', 'o', 'i']): bool =
  for c in badChars:
    if c in pw:
      return true

proc hasIncreasingStraight(pw: string): bool =
  for i in 0 .. pw.len-2:
    let
      a = ord(pw[i])
      b = ord(pw[i+1]) - 1
      c = ord(pw[i+2]) - 2
    if a == b and a == c:
      return true

proc hasTwoPairs(pw: string): bool =
  var pairedChar: set[char] 
  for i in 0 .. pw.len-2:
    if pw[i] == pw[i+1]:
      pairedChar.incl(pw[i])
  return card(pairedChar) >= 2

proc isValid(pw: string): bool =
  return hasIncreasingStraight(pw) and not containsBadCharacters(pw) and hasTwoPairs(pw)

proc findValid(pw: string): string =
  result = pw
  while not result.isValid():
    result = increment(result)


const password = "cqjxjnds"

let first = findValid(password)
echo first

let second = findValid(first.increment())
echo second

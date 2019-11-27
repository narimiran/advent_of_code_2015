import strutils

proc increment(pw: var string) =
  var i: int
  while pw[pw.high - i] == 'z':
    pw[pw.high - i] = 'a'
    inc i
  pw[pw.high - i] = chr(ord(pw[pw.high - i]) + 1)

func hasIncreasingStraight(pw: string): bool =
  var a, b, c: int
  for i in 0 ..< pw.len-2:
    a = ord(pw[i])
    b = ord(pw[i+1]) - 1
    c = ord(pw[i+2]) - 2
    if a == b and a == c:
      return true

func hasTwoPairs(pw: string): bool =
  var pairedChar: set[char]
  for i in 0 ..< pw.len-1:
    if pw[i] == pw[i+1]:
      pairedChar.incl(pw[i])
  return card(pairedChar) >= 2

func isValid(pw: string): bool =
  return not pw.contains({'l', 'o', 'i'}) and pw.hasIncreasingStraight and pw.hasTwoPairs

func findValid(pw: var string) =
  while not pw.isValid():
    increment(pw)


var password = "cqjxjnds"

findValid(password)
echo password

password.increment()
findValid(password)
echo password

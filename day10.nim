var digits = @[3, 1, 1, 3, 3, 2, 2, 1, 1, 3]

proc say(word: seq[int]): seq[int] =
  result = @[]
  var
    a = word[0]
    repeats = 1

  for c in word[1 .. word.high]:
    if c == a: repeats += 1
    else:
      result.add(repeats)
      result.add(a)
      a = c
      repeats = 1
  result.add(repeats)
  result.add(a)

proc repeat(word: var seq[int], times: int) =
  for _ in 1 .. times:
    word = word.say()


digits.repeat(40)
echo digits.len
digits.repeat(10)
echo digits.len

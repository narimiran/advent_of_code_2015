var digits = @[3'i8, 1, 1, 3, 3, 2, 2, 1, 1, 3]

func say(word: seq[int8]): seq[int8] =
  var
    a = word[0]
    repeats = 1'i8

  for c in word[1 .. word.high]:
    if c == a: inc repeats
    else:
      result.add(repeats)
      result.add(a)
      a = c
      repeats = 1
  result.add(repeats)
  result.add(a)

func repeat(word: var seq[int8], times: int) =
  for _ in 1 .. times:
    word = word.say()


digits.repeat(40)
echo digits.len
digits.repeat(10)
echo digits.len

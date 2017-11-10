const input = "3113322113"

proc say(word: string): string =
  result = ""
  var
    a = word[0]
    repeats = 1

  for c in word[1 .. word.high]:
    if c == a: repeats += 1
    else:
      result.add($repeats & a)
      a = c
      repeats = 1
  result.add($repeats & a)

proc repeat(word: string, times: int): string =
  result = word
  for _ in 1 .. times:
    result = result.say()


let first = input.repeat(40)
echo first.len
echo first.repeat(10).len

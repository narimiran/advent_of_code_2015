import md5, strutils

const salt = "ckczppom"


proc findIndex(): tuple[first, second: int] =
  var
    i, first, second: int
    foundFirst: bool
  while true:
    let
      s = salt & intToStr(i)
      hash = s.toMD5
    if hash[0] == 0 and hash[1] == 0 and hash[2] < 16:
      if not foundFirst:
        first = i
        foundFirst = true
      if hash[2] == 0:
        second = i
        break
    inc i
  return (first, second)


echo findIndex()

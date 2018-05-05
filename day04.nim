import md5, strutils, sequtils
import threadpool
{.experimental.}


const
  salt = "ckczppom"
  batchSize = 100_000


template firstCondition(hash: MD5Digest): bool =
  hash[0] == 0 and hash[1] == 0 and hash[2] < 16

template secondCondition(hash: MD5Digest): bool =
  hash[0] == 0 and hash[1] == 0 and hash[2] == 0


proc helper(start: int, isFirst: bool): int =
  var
    s: string
    hash: MD5Digest
  for i in start ..< start + batchSize:
    s = salt & intToStr(i)
    hash = s.toMD5
    if isFirst and firstCondition(hash):
      return i
    elif secondCondition(hash):
      return i

proc solve(): tuple[first, second: int] =
  var
    first = newSeq[int](2)
    second = newSeq[int](40)
  parallel:
    for i in 0 .. first.high:
      first[i] = spawn helper(i * batchSize, true)
    for i in 1 .. second.high:
      second[i] = spawn helper(i * batchSize, false)
  result = (first.filterIt(it > 0).min, second.filterIt(it > 0).min)

echo solve()

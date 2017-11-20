const
  input = 33_100_000
  firstTarget = input div 10
  secondTarget = input div 11


proc solve(target, limit: int): int =
  var houses = newSeq[int](target)
  for i in 1 .. target:
    for j in 1 .. min(target div i, limit):
      houses[j*i-1] += i
    if houses[i-1] > target:
      return i


echo solve(firstTarget, firstTarget)
echo solve(secondTarget, 50)

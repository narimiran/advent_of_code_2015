const
  value = 20151125
  base = 252533
  divisor = 33554393
  row = 2981
  col = 3075


proc findExponent(row, col: int): int =
  result = col - 1
  let startingRow = row + col - 1
  for i in 1 ..< startingRow:
    result += i


proc findValue(b, e, d: int): int =
  # https://en.wikipedia.org/wiki/Modular_exponentiation#Right-to-left_binary_method
  result = 1
  var
    base = b
    exp = e
    divisor = d
  while exp > 0:
    if exp mod 2 == 1:
      result = result * base mod divisor
    exp = exp div 2
    base = base*base mod divisor
  result = result * value mod d


let exp = findExponent(row, col)
echo findValue(base, exp, divisor)

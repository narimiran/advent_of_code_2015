import complex, sets, tables

const
  instructions = readFile("./inputs/03.txt")
  movement = {
    '<': (re: -1.0, im: 0.0),
    '>': (re: 1.0, im: 0.0),
    '^': (re: 0.0, im: 1.0),
    'v': (re: 0.0, im: -1.0),
  }.toTable()


proc solve(instr: string, part: int): int =
  var
    santa: Complex = (0.0, 0.0)
    robot: Complex = (0.0, 0.0)
    visited = initSet[Complex]()
  visited.incl(santa)

  proc move(position: var Complex, m: char) =
    position += movement[m]
    visited.incl(position)

  for i, m in instr:
    if part == 1:
      santa.move(m)
    else:
      case i mod 2
        of 0: santa.move(m)
        of 1: robot.move(m)
        else: discard
  return card(visited)


echo solve(instructions, part=1)
echo solve(instructions, part=2)

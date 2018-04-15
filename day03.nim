import sets, sequtils


type Coordinate = tuple[x, y: int]

proc parse(c: char): int =
  case c
    of '<': 0
    of '>': 1
    of '^': 2
    of 'v': 3
    else: -1

const
  instructions = readFile("./inputs/03.txt").map(parse)
  movement = [(-1, 0), (1, 0), (0, 1), (0, -1)]

proc `+=`(a: var Coordinate, b: Coordinate) =
  a = (a.x + b.x, a.y + b.y)

proc solve(instr: seq[int], part: int): int =
  var
    santa = (0, 0)
    robot = (0, 0)
    visited = initSet[Coordinate]()
  visited.incl(santa)

  proc move(position: var Coordinate, m: int) =
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

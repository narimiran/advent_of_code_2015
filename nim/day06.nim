import strutils, strscans

const instructions = readFile("./inputs/06.txt").strip.splitLines()

type
  Grid = array[1000, array[1000, int]]
  Subgrid = tuple[x1, y1, x2, y2: int]

var grid1, grid2: Grid


template forSubgrid(sg: Subgrid, body: untyped) =
  for x {.inject.} in sg.x1 .. sg.x2:
    for y {.inject.} in sg.y1 .. sg.y2:
      body


proc setValue(grid: var Grid, sg: Subgrid, value: int) =
  forSubgrid sg:
    grid[x][y] = value

proc toggle(grid: var Grid, sg: Subgrid) =
  forSubgrid sg:
    grid[x][y] = 1 - grid[x][y]

proc increaseBrightness(grid: var Grid, sg: Subgrid, value: int) =
  forSubgrid sg:
    grid[x][y] += value

proc decreaseBrightness(grid: var Grid, sg: Subgrid) =
  forSubgrid sg:
    grid[x][y] = max(grid[x][y] - 1, 0)

func lights(grid: Grid): int =
  for row in grid:
    for value in row:
      result += value


var
  x1, y1, x2, y2: int
  command: string
  sg: Subgrid

for line in instructions:
  if line.scanf("turn $w $i,$i through $i,$i", command, x1, y1, x2, y2):
    sg = (x1, y1, x2, y2)
    case command
      of "on":
        grid1.setValue(sg, 1)
        grid2.increaseBrightness(sg, 1)
      of "off":
        grid1.setValue(sg, 0)
        grid2.decreaseBrightness(sg)
  elif line.scanf("toggle $i,$i through $i,$i", x1, y1, x2, y2):
    sg = (x1, y1, x2, y2)
    grid1.toggle(sg)
    grid2.increaseBrightness(sg, 2)


echo grid1.lights()
echo grid2.lights()

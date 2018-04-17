import strutils

const instructions = readFile("./inputs/18.txt").splitLines

type
  Grid = array[102, array[102, bool]]


proc createGrid(instr: seq[string]): Grid =
  for i, line in instr:
    for j, c in line:
      result[i+1][j+1] = c == '#'


proc countNeighbours(grid: Grid, row, col: int): int =
  for r in row-1 .. row+1:
    for c in col-1 .. col+1:
      if grid[r][c]:
        inc result


proc changeState(grid: Grid, secondPart=false): Grid =
  for i in 1 .. 100:
    for j in 1 .. 100:
      let n = countNeighbours(grid, i, j)
      if (grid[i][j] and n in 3..4) or n == 3: result[i][j] = true
  if secondPart:
    result[1][1] = true
    result[1][100] = true
    result[100][1] = true
    result[100][100] = true


proc solve(grid: Grid, secondPart=false): int =
  var grid = grid
  for _ in 1 .. 100:
    grid = changeState(grid, secondPart)
  for row in grid:
    for col in row:
      if col:
        inc result


const grid = createGrid(instructions)
echo solve(grid)
echo solve(grid, true)

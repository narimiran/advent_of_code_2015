import strutils

const instructions = readFile("./inputs/18.txt").splitLines

type
  Grid = array[102, string]


proc createGrid(instr: seq[string]): Grid =
  for i, line in instr:
    result[i+1] = "." & line & "."
  result[0] = '.'.repeat(102)
  result[101] = '.'.repeat(102)


proc countNeighbours(grid: Grid, row, col: int): int =
  for r in row-1 .. row+1:
    result += grid[r][col-1 .. col+1].count('#')


proc changeState(grid: Grid, secondPart=false): Grid =
  result[0] = '.'.repeat(102)
  result[101] = '.'.repeat(102)
  for i in 1 .. 100:
    result[i] = "."
    for j in 1 .. 100:
      let n = countNeighbours(grid, i, j)
      if (grid[i][j] == '#' and n in 3..4) or n == 3: result[i].add('#')
      else: result[i].add('.')
    result[i].add('.')
  if secondPart:
    result[1][1] = '#'
    result[1][100] = '#'
    result[100][1] = '#'
    result[100][100] = '#'


proc solve(grid: Grid, secondPart=false): int =
  var grid = grid
  for _ in 1 .. 100:
    grid = changeState(grid, secondPart)
  for row in grid:
    result += row.count('#')


var grid = createGrid(instructions)
echo solve(grid)
echo solve(grid, true)

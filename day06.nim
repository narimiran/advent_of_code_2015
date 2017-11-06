    import strutils, sequtils, math

    const instructions = readFile("./inputs/06.txt").strip.splitLines

    type Grid = array[1000, array[1000, int]]

    var
      grid1: Grid
      grid2: Grid


    proc setValues(value: int, start, stop: seq) =
      for row in start[0] .. stop[0]:
        for col in start[1] .. stop[1]:
          grid1[row][col] = value

    proc toggle(start, stop: seq) =
      for row in start[0] .. stop[0]:
        for col in start[1] .. stop[1]:
          grid1[row][col] *= -1

    proc totalOn(grid: Grid): int =
      for i in 0 .. 999:
        for j in 0 .. 999:
          if grid[i][j] == 1:
            inc result

    proc increaseBrightness(start, stop: seq, value=1) =
      for row in start[0] .. stop[0]:
        for col in start[1] .. stop[1]:
          grid2[row][col] += value

    proc decreaseBrightness(start, stop: seq) =
      for row in start[0] .. stop[0]:
        for col in start[1] .. stop[1]:
          grid2[row][col] = max(grid2[row][col] - 1, 0)


    setValues(-1, @[0, 0], @[999, 999])

    for line in instructions:
      let
        commands = line.splitWhitespace
        start = commands[^3].split(',').map(parseInt)
        stop = commands[^1].split(',').map(parseInt)

      case commands[1]
      of "on":
        setValues(1, start, stop)
        increaseBrightness(start, stop)
      of "off":
        setValues(-1, start, stop)
        decreaseBrightness(start, stop)
      else:
        toggle(start, stop)
        increaseBrightness(start, stop, 2)


    echo grid1.totalOn()

    var brightness: int
    for row in grid2:
      brightness += sum(row)

    echo brightness

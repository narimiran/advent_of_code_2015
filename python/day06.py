def parse_line(line):
    words = line.split()
    x1, y1 = map(int, words[-3].split(','))
    x2, y2 = map(int, words[-1].split(','))
    return words[len(words) == 5], range(x1, x2+1), range(y1, y2+1)

def solve(data, grid_size=range(1000)):
    grid1 = [[0 for _ in grid_size] for _ in grid_size]
    grid2 = [[0 for _ in grid_size] for _ in grid_size]
    for cmd, xs, ys in data:
        for x in xs:
            for y in ys:
                if cmd == 'on':
                    grid1[x][y] = 1
                    grid2[x][y] += 1
                elif cmd == 'off':
                    grid1[x][y] = 0
                    grid2[x][y] = max(0, grid2[x][y] - 1)
                else:
                    grid1[x][y] = 1 - grid1[x][y]
                    grid2[x][y] += 2
    return sum(map(sum, grid1)), sum(map(sum, grid2))


data = map(parse_line, open("inputs/06.txt").read().splitlines())
print(solve(data))
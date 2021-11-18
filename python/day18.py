def load_data(path):
    data = open(path).read().splitlines()
    return ([[0] * (SIZE+2)] +
            [[0, *[c == '#' for c in line], 0] for line in data] +
            [[0] * (SIZE+2)])

def calc(data, x, y):
    alive_neigbours = sum(data[y-1][x-1:x+2]) + sum(data[y][x-1:x+2]) + sum(data[y+1][x-1:x+2])
    return alive_neigbours == 3 or (data[y][x] and alive_neigbours == 4)

def tick(data):
    new_data = [[0] * (SIZE+2) for _ in range(SIZE+2)]
    for y in range(1, SIZE+1):
        for x in range(1, SIZE+1):
            new_data[y][x] = calc(data, x, y)
    return new_data

def play(data, steps, part=1):
    data = data.copy()
    for _ in range(steps):
        data = tick(data)
        if part == 2:
            data[1][1] = data[1][SIZE] = data[SIZE][1] = data[SIZE][SIZE] = 1
    return sum(map(sum, data))


SIZE = 100
data = load_data("inputs/18.txt")

print(play(data, 100))
print(play(data, 100, part=2))

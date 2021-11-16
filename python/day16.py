import re


pattern = re.compile(r"(\w+): (\d+)")

ticker = {
    "children": 3,
    "cats": 7,
    "samoyeds": 2,
    "pomeranians": 3,
    "akitas": 0,
    "vizslas": 0,
    "goldfish": 5,
    "trees": 3,
    "cars": 2,
    "perfumes": 1
}

parse_line = lambda line: [(n, int(v)) for n, v in re.findall(pattern, line)]

check_1 = lambda name, val: ticker[name] == val
check_2 = lambda name, val: (
    val > ticker[name] if name in ("cats", "trees") else
    val < ticker[name] if name in ("pomeranians", "goldfish") else
    val == ticker[name])

solve = lambda data, func: next(i for i, line in enumerate(data, 1)
                                if all(func(*p) for p in line))


data = list(map(parse_line, open("inputs/16.txt").read().splitlines()))

print(solve(data, check_1))
print(solve(data, check_2))
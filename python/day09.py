from itertools import permutations
from functools import reduce


def parse_line(line):
    a, _, b, _, dist = line.split()
    return a, b, int(dist)

def create_relations(data):
    locations = set()
    relations = dict()
    for a, b, dist in data:
        locations |= {a, b}
        relations[(a, b)] = dist
        relations[(b, a)] = dist
    return locations, relations

solve = lambda func: (
    reduce(func,
           (sum(relations[trip] for trip in zip(route, route[1:]))
                for route in permutations(locations)),
           0 if func == max else 99999999999))


data = map(parse_line, open("inputs/09.txt").read().splitlines())
locations, relations = create_relations(data)

print(solve(min))
print(solve(max))
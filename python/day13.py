from collections import defaultdict
from itertools import permutations


def parse_line(line):
    a, _, gl, n, *_, b = line.split()
    return a, b[:-1], gl, int(n)

def create_relations(data):
    relations = defaultdict(lambda: defaultdict(int))
    for a, b, gl, n in data:
        relations[a][b] = n if gl == 'gain' else -n
    return relations

solve = lambda people, rels: (
    max(sum(rels[a][b] + rels[b][a]
            for a, b in zip(pp, list(pp[1:]) + [pp[0]]))
        for pp in permutations(people)))


data = map(parse_line, open("inputs/13.txt").read().splitlines())
relations = create_relations(data)
people = set(relations.keys())

print(solve(people, relations))
print(solve(people | {'me'}, relations))

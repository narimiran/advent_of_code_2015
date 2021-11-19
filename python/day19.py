from collections import defaultdict


def generate_replacements(data):
    result = defaultdict(list)
    for line in data[:-2]:
        k, v = line.split(" => ")
        result[k].append(v)
    return result

def part_1(molecule, replacements):
    result = set()
    for k, vals in replacements.items():
        pos = molecule.find(k)
        n = len(k)
        while pos != -1:
            for val in vals:
                sub = molecule[:pos] + val + molecule[pos+n:]
                result.add(sub)
            pos = molecule.find(k, pos+n)
    return len(result)

def part_2(molecule):
    # https://www.reddit.com/r/adventofcode/comments/3xflz8/day_19_solutions/cy4etju/
    elements = sum(c.isupper() for c in molecule)
    rn = molecule.count("Rn")
    y = molecule.count("Y")
    return elements - 2*rn - 2*y - 1


data = open("inputs/19.txt").read().splitlines()
molecule = data[-1]
replacements = generate_replacements(data)

print(part_1(molecule, replacements))
print(part_2(molecule))

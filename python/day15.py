import re
from math import prod


TOTAL = 100
numbers = re.compile("-?\d+")
parse_line = lambda line: tuple(map(int, re.findall(numbers, line)))
parse_data = lambda data: tuple(zip(*map(parse_line, data)))


def calc_score(amounts, property):
    return sum(amount * property for amount, property in zip(amounts, property))

def calc_scores(amounts, properties):
    return prod(max(0, calc_score(amounts, property)) for property in properties[:-1])

def find_best_cookie(properties):
    pt1 = pt2 = 0
    for a in range(TOTAL):
        for b in range(TOTAL-a):
            for c in range(TOTAL-a-b):
                d = TOTAL-a-b-c
                score = calc_scores((a, b, c, d), properties)
                pt1 = max(pt1, score)
                if score > pt2 and calc_score((a, b, c, d), properties[-1]) == 500:
                    pt2 = score
    return pt1, pt2


data = parse_data(open("inputs/15.txt").read().splitlines())
print(find_best_cookie(data))
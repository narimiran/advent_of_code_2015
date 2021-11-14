import re


FINISH = 2503
numbers = re.compile("-?\d+")
parse_line = lambda line: tuple(map(int, re.findall(numbers, line)))

def calc_dist(speed, time, rest, finish=FINISH):
    repeats, rest = divmod(finish, time+rest)
    return speed * (repeats*time + min(rest, time))

def part_2(data):
    scores = [0 for _ in range(len(data))]
    for t in range(FINISH):
        current_scores = [calc_dist(*reindeer, t+1) for reindeer in data]
        high_score = max(current_scores)
        for i, score in enumerate(current_scores):
            scores[i] += score == high_score
    return max(scores)


data = list(map(parse_line, open("inputs/14.txt").read().splitlines()))

print(max(calc_dist(*reindeer) for reindeer in data))
print(part_2(data))
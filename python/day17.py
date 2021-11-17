def solve(data):
    def aux(remaining, containers, used):
        if remaining == 0: used_containers.append(used)
        elif remaining > 0 and containers:
            aux(remaining, containers[1:], used)
            aux(remaining-containers[0], containers[1:], used+1)

    used_containers = []
    aux(150, data, 0)
    return used_containers


data = sorted(map(int, open("inputs/17.txt").read().splitlines()), reverse=True)

combinations = solve(data)
print(len(combinations))

least_used = min(combinations)
print(sum(n == least_used for n in combinations))
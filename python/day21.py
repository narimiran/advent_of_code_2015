weapons = [(8, 4, 0), (10, 5, 0), (25, 6, 0), (40, 7, 0), (74, 8, 0)]
armors = [(0, 0, 0), (13, 0, 1), (31, 0, 2), (53, 0, 3), (75, 0, 4), (102, 0, 5)]
rings = [(0, 0, 0), (0, 0, 0), (25, 1, 0), (50, 2, 0),
         (100, 3, 0), (20, 0, 1), (40, 0, 2), (80, 0, 3)]

opponent = (100, 8, 2)


def calc_score(w, a, r1, r2):
    cost = w[0] + a[0] + r1[0] + r2[0]
    att  = w[1] + a[1] + r1[1] + r2[1]
    deff = w[2] + a[2] + r1[2] + r2[2]
    return (cost, att, deff)

def would_win(att, deff):
    return max(att - opponent[2], 1) >= max(opponent[1] - deff, 1)

def solve():
    min_cost = 9999
    max_cost = 0
    for w in weapons:
        for a in armors:
            for i, r1 in enumerate(rings):
                for r2 in rings[i+1:]:
                    cost, att, deff = calc_score(w, a, r1, r2)
                    if would_win(att, deff):
                        min_cost = min(cost, min_cost)
                    else:
                        max_cost = max(cost, max_cost)
    return min_cost, max_cost


print(solve())

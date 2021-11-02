data = open("inputs/02.txt").read().splitlines()
dimensions = [sorted(map(int, line.split('x'))) for line in data]

paper =  lambda a, b, c: 3*a*b + 2*b*c + 2*c*a
ribbon = lambda a, b, c: 2*a + 2*b + a*b*c

print(sum( paper(*dim) for dim in dimensions))
print(sum(ribbon(*dim) for dim in dimensions))

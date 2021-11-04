from hashlib import md5
from itertools import count


def solve(target, start=1):
    for i in count(start):
        m = md5(f"{INPUT}{i}".encode()).hexdigest()
        if m.startswith(target): return i


INPUT = "ckczppom"

print(solve(5*'0'))
print(solve(6*'0'))
def next_pws(pw):
    while True:
        idx = -1
        while pw[idx] == 'z':
            pw[idx] = 'a'
            idx -= 1
        pw[idx] = chr(ord(pw[idx]) + 1)
        yield pw

has_increasing_straight = lambda pw_nums: (
    any(a == b-1 == c-2 for a, b, c in zip(pw_nums, pw_nums[1:], pw_nums[2:])))
has_invalid_letters = lambda pw: any(l in pw for l in "iol")
has_two_pairs = lambda pw: len({a for a, b in zip(pw, pw[1:]) if a == b}) >= 2

def next_valid(pw):
    yield from (''.join(pw) for pw in next_pws(list(pw)) if
                has_increasing_straight(list(map(ord, pw))) and
                not has_invalid_letters(pw) and
                has_two_pairs(pw))


INPUT = "cqjxjnds"
valid_passwords = next_valid(INPUT)

print(next(valid_passwords))
print(next(valid_passwords))

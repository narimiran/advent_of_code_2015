def solve(digits, times):
    digits = list(map(int, digits))
    for _ in range(times):
        d = digits[0]
        reps = 0
        new_digits = []
        for digit in digits:
            if digit == d: reps += 1
            else:
                new_digits.append(reps)
                new_digits.append(d)
                d = digit
                reps = 1
        new_digits.append(reps)
        new_digits.append(d)
        digits = new_digits
    return digits


INPUT = "3113322113"

print(len(first := solve(INPUT, 40)))
print(len(solve(first, 10)))

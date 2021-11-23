def setup_a(a):
    if a == 1:
        return (((((((a*9+2)*3+2)*3+1)*3+1)*3+1)*3+2)*3+2)*9+1
    else:
        return ((((((a+1)*3+1)*3+1)*9+2)*9+2)*3+2)*3

def run_program(a, b=0):
    while True:
        if a == 1: return b
        b += 1
        if a % 2 == 0: a //= 2
        else:
            a *= 3
            a += 1


print(run_program(setup_a(0)))
print(run_program(setup_a(1)))

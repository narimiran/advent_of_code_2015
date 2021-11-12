import json
import re


numbers = re.compile("-?\d+")

def find_sum(jason):
    if type(jason) is int:
        return jason
    if type(jason) is dict:
        if "red" in jason.values(): return 0
        else: return sum(map(find_sum, jason.values()))
    if type(jason) is list:
        return sum(map(find_sum, jason))
    else: return 0


data = open("inputs/12.txt").read()
j = json.loads(data)

print(sum(map(int, re.findall(numbers, data))))
print(find_sum(j))

import strutils

type Commands = tuple[instr: string, reg, jump: int]

const instructions = block:
  var res = newSeq[Commands]()
  var lines = readFile("./inputs/23.txt").splitLines()
  for line in lines:
    let
      commands = line.split()
      instr = commands[0]
      reg = ord(commands[1][0]) - ord('a')
      jump = if instr.startsWith('j'): commands[^1].parseInt-1 else: 0
    res.add((instr, reg, jump))
  res


func execute(a: int): int =
  var
    registers = [a, 0]
    i: int

  while i < len(instructions):
    let (instr, reg, jump) = instructions[i]

    case instr
      of "inc": inc registers[reg]
      of "hlf": registers[reg] = registers[reg] div 2
      of "tpl": registers[reg] = 3 * registers[reg]
      of "jmp": i += jump
      of "jio":
        if registers[reg] == 1:
          i += jump
      of "jie":
        if registers[reg] mod 2 == 0:
          i += jump
    inc i
  return registers[1]


echo execute(a=0)
echo execute(a=1)

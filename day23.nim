import strutils, tables

const instructions = readFile("./inputs/23.txt").splitLines()


proc execute(a: int): int =
  var
    registers = {'a': a, 'b': 0}.toTable()
    i = 0

  while i < len(instructions):
    let
      commands = instructions[i].split()
      instr = commands[0]
      reg = commands[1][0]
      jump = if instr.startsWith('j'): commands[^1].parseInt-1 else: 0
    
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
  return registers['b']


echo execute(a=0)
echo execute(a=1)

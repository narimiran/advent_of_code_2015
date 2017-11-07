import strutils, tables

const instructions = readFile("./inputs/07.txt").strip.splitlines

type
  Wire = ref object
    value: uint
    hasValue: bool
    logicStr: string


proc initialize(): Table[string, Wire] =
  result = initTable[string, Wire]()
  for line in instructions:
    let values = line.split(" -> ")
    result[values[1]] = Wire(logicStr: values[0])


var wires = initialize()


proc getValue(wireName: string): uint =
  if not wires.hasKey(wireName): return wireName.parseUInt()
  if wires[wireName].hasValue: return wires[wireName].value

  let
    wire = wires[wireName]
    logic = wire.logicStr.split()

  if logic.len == 1: result = getValue(logic[0])
  elif logic.len == 2: result = not getValue(logic[1])
  else:
    case logic[1]
    of "AND": result = getValue(logic[0]) and getValue(logic[2])
    of "OR": result = getValue(logic[0]) or getValue(logic[2])
    of "LSHIFT": result = getValue(logic[0]) shl getValue(logic[2])
    of "RSHIFT": result = getValue(logic[0]) shr getValue(logic[2])
  wire.hasValue = true
  wire.value = result

let firstPart = getValue("a")
echo firstPart

wires = initialize()
wires["b"].value = firstPart
wires["b"].hasValue = true

let secondPart = getValue("a")
echo secondPart

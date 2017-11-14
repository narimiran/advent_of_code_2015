import strutils, sequtils

const
  instructions = readFile("./inputs/14.txt").strip.splitLines
  time = 2503

type
  Reindeer = tuple
    name: string
    speed: int
    stamina: int
    rest: int

var reindeers = newSeq[Reindeer]()

for line in instructions:
  let
    words = line.splitWhitespace()
    name = words[0]
    speed = words[3].parseInt
    stamina = words[6].parseInt
    rest = words[^2].parseInt
  reindeers.add((name, speed, stamina, rest))


proc calculateDistance(reindeer: Reindeer, time: int): int =
  let
    v = reindeer.speed
    t = reindeer.stamina
    r = reindeer.rest
  result = time div (t+r) * (v * t) + (v * min(t, time mod (t+r)))


proc calculateMaxDistance(reindeers: seq[Reindeer], time: int): int =
  for rd in reindeers:
    let distance = rd.calculateDistance(time)
    result = max(result, distance)


proc findPartialWinners(reindeers: seq[Reindeer], time: int): seq[string] =
  result = @[]
  for t in 1..time:
    var
      maxDist: int
      winner: string
    for rd in reindeers:
      let distance = rd.calculateDistance(t)
      if distance > maxDist:
        maxDist = distance
        winner = rd.name
    result.add(winner)


proc findWinner(reindeers: seq[Reindeer], time: int): int =
  let winners = findPartialWinners(reindeers, time)
  for rd in reindeers:
    let nr = winners.filterIt(it == rd.name).len
    result = max(result, nr)


echo calculateMaxDistance(reindeers, time)
echo findWinner(reindeers, time)

type
  Player = tuple[hp, att, def: int]
  Stats = tuple[cost, att, def: int]

const opponent: Player = (100, 8, 2)
let
  weapons: seq[Stats] = @[(8, 4, 0), (10, 5, 0), (25, 6, 0), (40, 7, 0), (74, 8, 0)]
  armors: seq[Stats] = @[(0, 0, 0), (13, 0, 1), (31, 0, 2), (53, 0, 3),
                         (75, 0, 4), (102, 0, 5)]
  rings: seq[Stats] = @[(0, 0, 0), (0, 0, 0), (25, 1, 0), (50, 2, 0), (100, 3, 0),
                        (20, 0, 1), (40, 0, 2), (80, 0, 3)]


func isWin(player: Stats): bool =
  # both player and opponent have same HP (100)
  max(player.att - opponent.def, 1) >= max(opponent.att - player.def, 1)

func findScore(w, a, r1, r2: Stats): Stats =
  let
    cost = w.cost + a.cost + r1.cost + r2.cost
    att = w.att + a.att + r1.att + r2.att
    def = w.def + a.def + r1.def + r2.def
  return (cost, att, def)

var
  lowestCost = int.high
  highestCost = 0

for w in weapons:
  for a in armors:
    for i, r1 in rings:
      for r2 in rings[i+1 .. rings.high]:
        let score = findScore(w, a, r1, r2)
        if score.isWin():
          if score.cost < lowestCost:
            lowestCost = score.cost
        elif score.cost > highestCost:
          highestCost = score.cost

echo lowestCost
echo highestCost

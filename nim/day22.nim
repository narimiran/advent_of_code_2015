type
  Difficulty = enum normal, hard
  State = object
    mana, spentMana: int
    hp, bossHP: int
    shieldTurns, poisonTurns, rechargeTurns: int

const
  magicMissile = (
    cost: 53,
    effect: proc(s: var State) = s.bossHP -= 4,
    active: proc(s: State): bool = false
  )
  drain = (
    cost: 73,
    effect: proc(s: var State) = s.bossHP -= 2; s.hp += 2,
    active: proc(s: State): bool = false
  )
  shield = (
    cost: 113,
    effect: proc(s: var State) = s.shieldTurns = 6,
    active: proc(s: State): bool = s.shieldTurns > 0
  )
  poison = (
    cost: 173,
    effect: proc(s: var State) = s.poisonTurns = 6,
    active: proc(s: State): bool = s.poisonTurns > 0
  )
  recharge = (
    cost: 229,
    effect: proc(s: var State) = s.rechargeTurns = 5,
    active: proc(s: State): bool = s.rechargeTurns > 0
  )
  spells = [magicMissile, drain, shield, poison, recharge]
  bossDmg = 8


proc applyEffects(s: var State) =
  if s.poisonTurns > 0:
    s.bossHP -= 3
    s.poisonTurns -= 1
  if s.rechargeTurns > 0:
    s.mana += 101
    s.rechargeTurns -= 1


proc battle(s: State, difficulty: Difficulty): int =
  var
    states = @[s]
    state: State
  result = int.high

  while len(states) > 0:
    state = states.pop()

    if difficulty == hard:
      dec state.hp
      if state.hp <= 0:
        continue

    state.applyEffects()
    if state.bossHP <= 0:
      result = min(result, state.spentMana)
      continue

    if state.shieldTurns > 0:
      dec state.shieldTurns

    for spell in spells:
      if (spell.cost <= state.mana and
          state.spentMana + spell.cost < result and
          not spell.active(state)):
        var newState = state
        newState.mana -= spell.cost
        newState.spentMana += spell.cost
        spell.effect(newState)

        newState.applyEffects()
        if newState.bossHP <= 0:
          result = newState.spentMana
          continue

        if newState.shieldTurns > 0:
          newState.hp -= bossDmg - 7
          dec newState.shieldTurns
        else:
          newState.hp -= bossDmg

        if newState.hp > 0:
          states.add(newState)


var startingPosition = State(mana: 500, hp: 50, bossHP: 55)

echo battle(startingPosition, normal)
echo battle(startingPosition, hard)

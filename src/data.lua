-- Includes

local State   = require 'src/state'
local Species = require 'src/species'

-- Module

local Data = {}

function Data.Mob(t)
  local t = t or {}
  assert(type(t) == 'table', 'Function `Data.Mob` parameter must be a table!')
  return {
    x         = t.x         or 0,
    y         = t.y         or 0,
    size      = t.size      or 1,
    vision    = t.vision    or 8,
    direction = t.direction or math.rad(math.random(8) * 45),
    speed     = t.speed     or 0,
    state     = t.state     or State.WANDER,
    species   = t.species   or Species.PREY,
    tickTime  = t.tickTime  or 1,
    timer     = 0
  }
end

function Data.Zone(t)
  local t = t or {}
  assert(type(t) == 'table', 'Function `Data.Zone` parameter must be a table!')
  return {
    x    = t.x    or 0,
    y    = t.y    or 0,
    size = t.size or 10
  }
end

return Data

-- Includes

local State   = require 'src/state'
local Species = require 'src/species'
local lume    = require 'lib/lume'

-- Events

local outsideZone = function(mob, zone)
  return lume.distance(mob.x, mob.y, zone.x, zone.y) >= zone.size - mob.size
end

local touchMob = function(mob, other)
  return lume.distance(mob.x, mob.y, other.x, other.y) <= mob.size + other.size
end

local spotMob = function(mob, other)
  return lume.distance(mob.x, mob.y, other.x, other.y) <= mob.vision + other.size
end

local spotPrey = function(mob, mobList)
  for _, other in ipairs(mobList) do
    if spotMob(mob, other) and other.species == Species.PREY then
      return true
    end
  end
  return false
end

local spotPredator = function(mob, mobList)
  for _, other in ipairs(mobList) do
    if spotMob(mob, other) and other.species == Species.PREDATOR then
      return true
    end
  end
  return false
end

local tick = function(mob, dt)
  mob.timer = mob.timer + dt
  if mob.timer >= mob.tickTime then
    mob.timer = 0
    return true
  end
  return false
end

-- Helpers

local getNearestMob = function(mob, mobList, species)
  local nearestDistance = 9999999
  local nearestMob = nil
  for _, other in ipairs(mobList) do
    if other ~= mob and other.species == species then
      local distance = lume.distance(mob.x, mob.y, other.x, other.y)
      if distance < nearestDistance then
        nearestDistance = distance
        nearestMob = other
      end
    end
  end
  return nearestMob
end

local move = function(mob, dt)
  local dx, dy = lume.vector(mob.direction, mob.speed)
  mob.x = mob.x + (dx * dt)
  mob.y = mob.y + (dy * dt)
end

local nextState = function(mob, mobList, zone)
  if outsideZone(mob, zone) then return State.ENTER end
  if mob.species == Species.PREY and spotPredator(mob, mobList) then return State.FLEE end
  if mob.species == Species.PREDATOR and spotPrey(mob, mobList) then return State.HUNT end
  return State.WANDER
end

-- State Behaviors

local Wander = function(mob, dt)
  mob.direction = math.rad(math.random(24) * 15)
  mob.speed = 2
end

local Enter = function(mob, zone)
  mob.direction = lume.angle(mob.x, mob.y, zone.x, zone.y)
  mob.speed = 4
end

local Leave = function(mob, zone)
  mob.direction = -lume.angle(mob.x, mob.y, zone.x, zone.y)
  mob.speed = 4
end

local Flee = function(mob, mobList)
  local other = getNearestMob(mob, mobList, Species.PREDATOR)
  if type(other) ~= 'nil' then
    local scatter = math.rad(math.random(-15, 15))
    mob.direction = -lume.angle(mob.x, mob.y, other.x, other.y) -- + scatter
    mob.speed = 6
  end
end

local Hunt = function(mob, mobList)
  local other = getNearestMob(mob, mobList, Species.PREY)
  if type(other) ~= 'nil' then
    mob.direction = lume.angle(mob.x, mob.y, other.x, other.y)
    mob.speed = 6
  end
end

-- Module

local Sim = {}

function Sim.updateMob(mob, mobList, zone, dt)
  move(mob, dt)
  mob.state = nextState(mob, mobList, zone)
  if tick(mob, dt) then
    if mob.state == State.WANDER then Wander(mob)        end
    if mob.state == State.ENTER  then Enter(mob, zone)   end
    if mob.state == State.LEAVE  then Leave(mob, zone)   end
    if mob.state == State.FLEE   then Flee(mob, mobList) end
    if mob.state == State.HUNT   then Hunt(mob, mobList) end
  end
end

function Sim.updateMobs(mobList, zone, dt)
  for _, mob in ipairs(mobList) do
    Sim.updateMob(mob, mobList, zone, dt)
  end
end

return Sim

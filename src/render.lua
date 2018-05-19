-- Includes

local Species = require 'src/species'
local lume    = require 'lib/lume'

-- Helpers

local getDimensions = love.graphics.getDimensions
local setColor      = love.graphics.setColor
local drawCircle    = love.graphics.circle

local getDrawScale = function(units)
  return units * 8
end

local getDrawCoords = function(x, y)
  local width, height = getDimensions()
  local drawX = (width  / 2) + getDrawScale(x)
  local drawY = (height / 2) - getDrawScale(y)
  return drawX, drawY
end

-- Module

local Render = {}

function Render.mob(mob, drawMovement, drawVision)
  if mob.species == Species.PREDATOR then
    setColor(1, 0, 0)
  else
    setColor(1, 1, 1)
  end
  local drawX, drawY = getDrawCoords(mob.x, mob.y)
  drawCircle('fill', drawX, drawY, getDrawScale(mob.size))

  if drawMovement == true then
    local vx, vy = lume.vector(mob.direction, mob.speed)
    local lineX, lineY = getDrawCoords(mob.x + vx, mob.y + vy)
    love.graphics.line(drawX, drawY, lineX, lineY)
  end

  if drawVision == true then
    if mob.species == Species.PREDATOR then
      setColor(1, 0, 0, 0.3)
    else
      setColor(1, 1, 1, 0.3)
    end
    drawCircle('line', drawX, drawY, getDrawScale(mob.vision))
  end
end

function Render.mobList(mobList, drawMovement, drawVision)
  for _, mob in ipairs(mobList) do
    Render.mob(mob, drawMovement, drawVision)
  end
end

function Render.zone(zone)
  setColor(0, 1, 1)
  local drawX, drawY = getDrawCoords(zone.x, zone.y)
  drawCircle('line', drawX, drawY, getDrawScale(zone.size))
end

return Render
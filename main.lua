local Data   = require 'src/data'
local Sim    = require 'src/sim'
local Render = require 'src/render'

function love.load()
  math.randomseed(love.timer.getTime())
  zone = Data.Zone({size = 30})
  mobList = {}
  for i = 1, 6 do
    table.insert(mobList, Data.Mob({x = math.random(-20, 20), y = math.random(-20, 20), vision = 6}))
  end
  table.insert(mobList, Data.Mob({species = 1,  y = 40, tickTime = 2}))
end

function love.update(dt)
  Sim.updateMobs(mobList, zone, dt)
end

function love.draw()
  Render.zone(zone)
  Render.mobList(mobList, true, true)
end
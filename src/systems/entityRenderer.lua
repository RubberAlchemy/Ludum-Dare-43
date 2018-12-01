local Concord = require("lib.concord")

local Camera = require("src.camera")

local C = require("src.components")

local EntityRenderer = Concord.system({C.empty})

local render = function (_, item, tilesets)
   local e = item[5].entity
   if not e then return end

   local transform = e[C.transform]
   local sprite = e[C.sprite]

   if not sprite or not transform then return end

   local image, quad = tilesets[sprite.tileset].image, sprite.quad
   local x, y, angle = transform.position.x, transform.position.y, transform.rotation
   love.graphics.draw(image, quad, x, y, angle)
end

function EntityRenderer:draw()
   local world = self:getWorld()

   local spatialhash = world.worlds["game"]:hash()
   local tilesets    = world.project.tilesets

   local x, y, w, h = 0, 0, Camera.w, Camera.h

   spatialhash:inSameCell(x, y, w, h, render, tilesets)
end

return EntityRenderer
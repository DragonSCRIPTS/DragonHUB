-- SeaWorldModule.lua
local SeaWorldModule = {}

--// Sea world
First_Sea = false
Second_Sea = false
Third_Sea = false

local placeId = game.PlaceId
if placeId == 2753915549 then
    First_Sea = true
elseif placeId == 4442272183 then
    Second_Sea = true
elseif placeId == 7449423635 then
    Third_Sea = true
end

return SeaWorldModule

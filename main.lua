-->Initializing
--
vector = require "apis/vector"
boolutils = require "apis/boolutils"
lineutils = require "apis/lineutils"
local A, B = {200, 200}, {250, 250} -- 2 points A and B
local C, D = {300, 200}, {250, 250} -- 2 points C and D
line1 = lineutils:new_line(A,B);

-->Events
--
function love.load()
end

function love.update(dt)
end

function love.draw()
end

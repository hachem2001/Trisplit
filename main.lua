-->Initializing
--
vector = require "apis/vector"
boolutils = require "apis/boolutils"
lineutils = require "apis/lineutils"
local A, B = {200, 200}, {250, 250} -- 2 points A and B
local C, D = {300, 200}, {250, 250} -- 2 points C and D
line1 = lineutils:new_line(A,B);
line2 = lineutils:new_line(C,D);
-->Events
--
function love.load()

end

function love.update(dt)

end

function love.draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.line(A[1], A[2], B[1], B[2]);
  love.graphics.line(C[1], C[2], D[1], D[2]);
end

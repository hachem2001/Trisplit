-->Initializing
--
vector = require "apis/vector"
boolutils = require "apis/boolutils"
lineutils = require "apis/lineutils"
local A, B = {200, 200}, {250, 250} -- 2 points A and B
local C, D = {300, 200}, {50, 250} -- 2 points C and D
local line1 = lineutils:new_line(A,B);
local line2 = lineutils:new_line(C,D);
local pq1, qp1 = line1('gdp', A[1], A[2]);
local pq2, qp2 = line2('gdp', C[1], C[2]);

-->Events
--
function love.load()

end

function love.update(dt)

end

function love.draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.line(pq1.x, pq1.y, qp1.x, qp1.y);
  love.graphics.line(pq2.x, pq2.y, qp2.x, qp2.y);
  love.graphics.circle("line", A[1], A[2], 10)
  love.graphics.circle("line", B[1], B[2], 10)
  love.graphics.circle("line", C[1], C[2], 10)
  love.graphics.circle("line", D[1], D[2], 10)
end

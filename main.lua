-->Initializing
--
vector    = require "apis/vector"
boolutils = require "apis/boolutils"
lineutils = require "apis/lineutils"
drawutils = require "apis/drawutils"

local A, B = {100, 200}, {250, 250} -- 2 points A and B
local C, D = {300, 200}, {320, 250} -- 2 points C and D
local M = {50, 200}
local line1 = lineutils:new_line(A,B);
local line2 = lineutils:new_line(C,D);
local _, intersection = lineutils.get_intersection(line1, line2);
-->Events
--
function love.load()

end

function love.update(dt)
    local mx, my = love.mouse.getPosition();
    B[1] = mx;
    B[2] = my;
    line1('update', A, B);
    pq1, qp1 = line1('gdp', A[1], A[2]);
    pq2, qp2 = line2('gdp', C[1], C[2]);
    _, intersection = lineutils.get_intersection(line1, line2);
end

function love.draw()
  love.graphics.setColor(1, 1, 1, 1)
  line1('draw');
  line2('draw');
  drawutils.draw_cpoints('line', 10, nil, A, B, C, D)

  love.graphics.setColor(1,0.5,0.5,1)
  love.graphics.circle("line", intersection.x, intersection.y, 10);
  love.graphics.setColor(1,1,0.5,1)
  local int = lineutils.project_get(line1, M[1], M[2]);
  love.graphics.circle("line", M[1], M[2], 10);
  love.graphics.circle("line", int.x, int.y, 10);
  love.graphics.line( M[1], M[2], int.x, int.y)

end

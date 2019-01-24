-->Initializing
--
vector    = require "apis/vector"
boolutils = require "apis/boolutils"
lineutils = require "apis/lineutils"
rayutils  = require "apis/rayutils"
drawutils = require "apis/drawutils"

local A, B = {400, 400}, {250, 250} -- 2 points A and B
local C, D = {300, 200}, {320, 250} -- 2 points C and D
local M = {300, 200}
local line1 = lineutils:new_line(A,B);
local line2 = lineutils:new_line(C,D);
local _, intersection = lineutils.get_intersection(line1, line2);
local ray = rayutils:new_ray(A, B)

-->Events
--
function love.load()

end

function love.update(dt)
    local mx, my = love.mouse.getPosition();
    B[1] = mx;
    B[2] = my;
    line1('update', A, B);
    ray('update', A, B);
end

function love.draw()
  love.graphics.setColor(1, 1, 1, 1)
  line1('draw');
  line2('draw');
  drawutils.draw_cpoints('line', 10, nil, A, B, C, D)


  love.graphics.setColor(1,0.5,0.5,1)
  local exists, intersection = lineutils.get_intersection(line1, line2);
  ray('draw');
  if exists then
    love.graphics.circle("line", intersection.x, intersection.y, 10);
  end

  love.graphics.setColor(1,1,0.5,1)
  local int = lineutils.project_get(line1, M[1], M[2]);
  drawutils.draw_cpoints('line', 10, nil, M, int);
  love.graphics.line( M[1], M[2], int.x, int.y)

end

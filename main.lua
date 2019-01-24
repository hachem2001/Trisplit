-->Initializing
--
vector    = require "apis/vector"
boolutils = require "apis/boolutils"
lineutils = require "apis/lineutils"
rayutils  = require "apis/rayutils"
drawutils = require "apis/drawutils"

local A, B = {200, 200}, {250, 250} -- 2 points A and B
local C, D = {300, 200}, {320, 250} -- 2 points C and D
local M = {120, 200}
local ray1 = rayutils:new_ray(A,B);
local ray2 = rayutils:new_ray(C,D);

-->Events
--
function love.load()

end

function love.update(dt)
    local mx, my = love.mouse.getPosition();
    B[1] = mx;
    B[2] = my;
    ray1('update', A, B);
end

function love.draw()
  love.graphics.setColor(1, 1, 1, 1)
  ray1('draw');
  ray2('draw');
  drawutils.draw_cpoints('line', 10, nil, A, B, C, D)


  local exists, intersection = rayutils.get_intersection(ray1, ray2);

  if exists then
    love.graphics.setColor(1,0.5,0.5,1)
    love.graphics.circle("line", intersection.x, intersection.y, 10);
  else
    love.graphics.setColor(1,0.5,1 ,1)
    love.graphics.circle("line", intersection.x, intersection.y, 10);
  end

end

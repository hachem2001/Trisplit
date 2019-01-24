vector      = require 'apis/vector'
lineutils   = require 'apis/lineutils'

local rayutils = {};

rayutils.ray = {
  __index = function(ray, key)
    if key == 'p' then return ray[1]
      elseif key == 'dv' then return ray[2]
      elseif key == "a" then return line[1]; -- get the x coefficient a
      elseif key == "b" then return line[2]; -- get the y coefficient b
      elseif key == "c" then return line[3]; -- get the constant c
      else error("Invalid index "..key.." to «ray»", 2);
    end
  end,
  __call = function(ray, arg1, arg2)
    if arg1 == 'update' then

    if arg1 == 'draw' then
      rayutils.draw_ray(ray, lenght or 1000)
    end
  end,
}

function rayutils.new_ray(...)
  -- rays will be stored as a point and a directing vector
  -- They can also be fully determined using 2 distinct points
  -- ray = {vector(point), vector(direction), a, b, c}

  local m = {...}
  if boolutils.assert_form(m, {{0,0},{0,0}}) then -- 2 points P, Q respectively and their coordinates
    -- the ray will be (P, vector PQ)
    if m[2][1] == m[1][1] and m[1][2] == m[2][2] then
      error('Invalid ray, superpositioned points', 2);
    end
    local a,b,c = lineutils.new_line_raw(m[1][1],m[1][2],m[2][1],m[2][2]); -- Get a, b and c constants for the line of the ray.
    return setmetatable({vector(m[1][1], m[1][2]), vector(m[2][1]-m[1][1], m[2][2]-m[1][2])^1, a,b,c},self.ray);

  elseif boolutils.assert_form(m, {{0,0}, vector(0,0)}) then --Given a point and the directional vector.
    return setmetatable({vector(m[1][1], m[1][2]), vector(m[2][1]-m[1][1], m[2][2]-m[1][2])^1 ,m[2].y, -m[2].x, -m[2].y*m[1][1]+m[2].x*m[1][2]}, self.ray)
  else
    error("Invalid form for making a «ray»", 2);
  end
end

function rayutils.draw_ray(ray, lenght)
  local ep = ray.dv * (lenght or 1000);
  love.graphics.line(ray.p.x, ray.p.y, ep.x, ep.y);
end

function rayutils.get_drawing_points(ray, lenght)
  return ray[1], ray.dv * (lenght or 1000);
end

return rayutils;

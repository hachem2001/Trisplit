vector      = require 'apis/vector'
lineutils   = require 'apis/lineutils'

local rayutils = {};

rayutils.ray = {
  __index = function(ray, key)
    if key == 'p' then return ray[1]
      elseif key == 'dv' then return ray[2]
      elseif key == "a" then return ray[3]; -- get the x coefficient a
      elseif key == "b" then return ray[4]; -- get the y coefficient b
      elseif key == "c" then return ray[5]; -- get the constant c
      else error("Invalid index "..key.." to «ray»", 2);
    end
  end,
  __call = function(ray, arg1, arg2, arg3)
    if arg1 == 'update' then
      local p, v, a, b, c = rayutils.new_ray_raw(arg2[1], arg2[2], arg3[1], arg3[2]);
      ray[1],ray[2],ray[3],ray[4],ray[5] = p,v,a,b,c;
    elseif arg1 == 'draw' then
      rayutils.draw_ray(ray, arg2 or 1000)
    end
  end,
}

function rayutils:new_ray(...)
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

function rayutils.new_ray_raw(x1, y1, x2, y2)
  local v = vector(x2-x1, y2-y1); -- Directional vector, of the form -b, a is the same as vector PQ.
  -- The line equation is ax + by + c = 0 so c = -ax - by for (x,y) given by any of the 2 points. (P or Q)
  local a, b = v.y, -v.x;
  local c = -a*x2-b*y2;
  return vector(x1, y1),v^1,a,b,c;
end

function rayutils.draw_ray(ray, lenght)
  local ep = ray.p + ray.dv * (lenght or 1000);
  love.graphics.line(ray.p.x, ray.p.y, ep.x, ep.y);
end

function rayutils.get_drawing_points(ray, lenght)
  return ray[1], ray.p + ray.dv * (lenght or 1000);
end

function rayutils.get_projected_coordinates(ray, x1, y1)
  local v = vector(x1, y1)-ray.p;
  return ray.dv * v; -- dot product should suffise.
end

function rayutils.get_intersection(ray1, ray2)
  -- Returns : b:bool, x:num, y:num
  -- b : intersection happened -> true, otherwise false
  -- x, y : coordinates of the intersection if an intersection exists

  local a, b, c, i, j, k = ray1.a, ray1.b, ray1.c, ray2.a, ray2.b, ray2.c;
  if (-i*b + j*a) == 0 then -- if the rays are parallel
    return false, vector(0, 0); -- The last 2 numbers are nonsensical. But they are there in order not to break a lazy coder's program
  else
    local result = vector((k*b-j*c)/(j*a-i*b), (k*a-i*c)/(i*b-j*a));
    local m1, m2 = ray1.dv * (result-ray1.p), ray2.dv * (result-ray2.p);
    return (m1>=0) and (m2>=0), result
  end
end


return rayutils;

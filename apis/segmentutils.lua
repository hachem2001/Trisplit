vector      = require 'apis/vector'
lineutils   = require 'apis/lineutils'
rayutils    = require 'apis/rayutils'

local segmentutils = {}
segmentutils.segment = {
  __index = function(segment, key)
    if key == 'p' then return segment[1] -- starting point
    elseif key == 'q' then return segment[2] -- en
    elseif key == 'dv' then return segment[3] -- get unitary directional vector starting from p
    elseif key == "nv"then return vector(segment[3].y, -segment[3].x); -- get a normal vector
    elseif key == "a" then return segment[3]; -- get the x coefficient a
    elseif key == "b" then return segment[4]; -- get the y coefficient b
    elseif key == "c" then return segment[5]; -- get the constant c
    else error("Invalid index "..key.." to «ray»", 2);
    end
  end,

  __call = function(segment, arg1, arg2)
    if arg1 == 'update' then
      local p, q, v, a, b, c = segmentutils.new_ray_raw(arg2[1], arg2[2], arg3[1], arg3[2]);
      segment[1],segment[2],segment[3],segment[4],segment[5],segment[6] = p,q,v,a,b,c;
    elseif arg1 == 'draw' then
      segmentutils.draw_segment(segment);
    end
  end,
}

function segmentutils.draw_segment(segment)
  love.graphics.line(segment.p.x, segment.p.y, segment.q.x, segment.q.y);
end

function segmentutils:new_segment(...)
  -- segments will be stored as 2 points
  -- segment = {vector(point p), vector(point q), vector(direction), a, b, c}

  local m = {...}
  if boolutils.assert_form(m, {{0,0},{0,0}}) then -- 2 points P, Q respectively and their coordinates
    -- the ray will be (P, vector PQ)
    if m[2][1] == m[1][1] and m[1][2] == m[2][2] then
      error('Invalid ray, superpositioned points', 2);
    end
    local a,b,c = lineutils.new_line_raw(m[1][1],m[1][2],m[2][1],m[2][2]); -- Get a, b and c constants for the line of the ray.
    return setmetatable({vector(m[1][1], m[1][2]), vector(m[2][1]-m[1][1], m[2][2]-m[1][2])^1, a,b,c},self.segment);

  elseif boolutils.assert_form(m, {vector(0,0), vector(0,0)}) then --Given a point and the directional vector.
    if m[2].x == m[1].x and m[1].y == m[2].y then
      error('Invalid ray, superpositioned points', 2);
    end
    local a,b,c = lineutils.new_line_raw(m[1].x,m[1].y,m[2].x,m[2].y); -- Get a, b and c constants for the line of the ray.
    return setmetatable({vector(m[1].x, m[1].y),vector(m[2].x, m[2].y),vector(m[2].x-m[1].x, m[2].y-m[1].y)^1 ,a,b,c}, self.segment)

  else
    error("Invalid form for making a «ray»", 2);
  end
end

function segmentutils.new_segment_raw(x1, y1, x2, y2)
  local v = vector(x2-x1, y2-y1); -- Directional vector, of the form -b, a is the same as vector PQ.
  -- The line equation is ax + by + c = 0 so c = -ax - by for (x,y) given by any of the 2 points. (P or Q)
  local a, b = v.y, -v.x;
  local c = -a*x2-b*y2;
  return vector(x1, y1),vector(x2, y2),v^1,a,b,c;
end

function segmentutils.get_intersection(segment1, segment2)

end

return segmentutils;

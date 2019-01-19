local boolutils = require "apis/boolutils"
local vector = require "apis/vector"
local lineutils = {}

lineutils.line = {
  __index = function(line, key)
    if key == "a" then return line[1]; -- get the x coefficient a
    elseif key == "b" then return line[2]; -- get the y coefficient b
    elseif key == "c" then return line[3]; -- get the constant c
    elseif key == "v" then return vector(-line[2], line[1]); -- get directional vector
    elseif key == "vn"then return vector(line[1], line[2]); -- get normal vector
    else error("Invalid index "..key.." to «line»", 2);
    end
  end,
}

function lineutils:new_line(...)
  -- Lines are of the cartesian equation form : ax + by + c = 0
  -- They can also be fully determined using a point and a direction/normal vector
  local m = {...}
  if boolutils.assert_form(m, {{0,0},{0,0}}) then -- 2 points P, Q respectively and their coordinates
    local v = vector(m[2][1]-m[1][1], m[2][2]-m[2][2]); -- Directional vector, of the form -b, a is the same as vector PQ.
    -- The line equation is ax + by + c = 0 so c = -ax - by for (x,y) given by any of the 2 points. (P or Q)
    local a, b = v.y, -v.x
    local c = -a*m[2][1]-b*m[2][2]
    return setmetatable({a,b,c},self.line);
  elseif boolutils.assert_form(m, {0,0,0}) then -- given a, b and c
    return setmetatable({a,b,c},self.line);
  elseif boolutils.assert_form(m, {{0,0}, vector(0,0)}) then --Given a point and the directional vector.
    return setmetatable({m[2].y, -m[2].x, -m[2].y*m[1][1]+m[2].x*m[1][2]}, self.line)
  else
    error("Invalid form for making a «line»");
  end

end

function lineutils.get_intersection(line1, line2)
  -- Returns : b:bool, x:num, y:num
  -- b : intersection happened -> true, otherwise false
  -- x, y : coordinates of the intersection if an intersection exists
  --[[
    The Math logic behind finding the (x,y) intersection pair of 2 lines (a,b,c) and (i,j,k)
    Infinities are not taken into account. To avoid them a simple check for non parallelism can do it
    To check that the two lines are not parallel just check if (-ib+ja) =/= 0 (aka the 2 directional vectors are not colinear)
    [ax + by + c = 0 (1)
     ix + jy + k = 0 (2)]
    (1) * i & (2) * a :
    [iax + iby + ic = 0 (12)
     iax + jay + ka = 0 (22)]
    (12)-(22) => y = (ka-ic)/(ib-ja)
    (1) * j & (2) * b
    [jax + jby + jc = 0 (13)
     ibx + jby + kb = 0 (23)]
    (13)-(23) => x = (kb-jx)/(ja-ib)
    # (x,y) = ((ka-ic)/(ib-ja), (kb-jx)/(ja-ib))
  ]]
  local a, b, c, i, j, k = line1.a, line1.b, line1.c, line2.i, line2.j, line2.k;
  if (-i*b + j*a) == 0 then
    return false, 0, 0 -- The last 2 numbers are nonsensical. But they are there in order not to break
    -- a lazy coder's program
  else
    return true, (k*a-i*c)/(i*b-j*a), (k*b-j*x)/(j*a-i*b)
  end
end

return lineutils;

-- in this file I will add some useful drawing wrapping functions because I am reusing a lot of the same code
local drawutils = {};

function drawutils.draw_cpoints(form, radius, segments, ...)
  -- draw point circles, all the same color, radius and type.
  -- note : this function works with either a table of the form {x, y} or a vector.
  local m = {...};
  for _, v in ipairs(m) do
    love.graphics.circle(form, v.x or v[1], v.y or v[2], radius, segments);
  end
end

return drawutils;

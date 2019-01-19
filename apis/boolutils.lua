local boolutils = {}

function assert_form(val, exp)
  local result = false;
  if type(val) == type(exp) then
    result = true;
    if type(val) == "table" then
      for k,v in pairs(val) do
        result = result and assert_form(v, exp[k]);
        if not result then break; end
      end
    end
  end
  return result;
end

return boolutils;

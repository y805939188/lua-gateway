local utils = {}

function utils.split(s, delim)
  if type(delim) ~= "string" or string.len(delim) <= 0 then return end
  local start = 1
  local t = {}
  while true do
    local pos = string.find (s, delim, start, true) -- plain find
    if not pos then break end
    table.insert (t, string.sub (s, start, pos - 1))
    start = pos + string.len (delim)
  end
  table.insert (t, string.sub (s, start))
  return t
end

function utils.isIpAddress(ip)
  if not ip then return false end
  local a, b, c, d, e, f = ip:match("^(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)(:?)(%d*)$")
  a=tonumber(a)
  b=tonumber(b)
  c=tonumber(c)
  d=tonumber(d)
  if not a or not b or not c or not d then return false, "ip: "..ip..", invalid" end
  if a < 0 or 255 < a then return false, "ip: "..ip..", invalid" end
  if b < 0 or 255 < b then return false, "ip: "..ip..", invalid" end
  if c < 0 or 255 < c then return false, "ip: "..ip..", invalid" end
  if d < 0 or 255 < d then return false, "ip: "..ip..", invalid" end
  if (e == ':' and f == '') then
    return false, "ip: "..ip..", missing port"
  end
  if (e == ':' and f ~= '') then
    f = tonumber(f)
    if f < 0 or 65535 < f then return false, "ip: "..ip..", port invalid"
  end
  end
  return true
end

function utils.getPort(path)
  local _, port = path:match("[(%w+)://]*([^/:]+)(:%d*)")
  if (port ~= nil and port ~= ':') then return string.sub(port, 2) end
  return nil
end

return utils

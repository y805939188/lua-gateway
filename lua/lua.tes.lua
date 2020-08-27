-- require "utils"
-- -- -- test = {
-- -- --   {ip = "127.0.0.1", port = "3344"},
-- -- --   {ip = "127.0.0.1", port = "4455"},
-- -- --   {ip = "127.0.0.1", port = "5566"},
-- -- --   {ip = "127.0.0.1", port = "6677"},
-- -- --   {ip = "127.0.0.1", port = "7788"},
-- -- --   {ip = "127.0.0.1", port = "8899"}
-- -- -- }

-- -- -- local ip_port = test[math.random(1, #test)];

-- -- -- print(ip_port)


-- print(utils.isEndpoint("127.0.0.8"))
-- print(utils.isEndpoint("127.0.0.a"))
-- print(utils.isEndpoint("127.0.0.999"))
-- print(utils.isEndpoint("127.0.0.a:"))
-- print(utils.isEndpoint("127.0.0.1:"))
-- print(utils.isEndpoint("127.0.0.1:2"))
-- print(utils.isEndpoint("127.0.0.1:888"))
-- print(utils.isEndpoint("127.0.0.1:9999"))
-- print(utils.isEndpoint("127.0.0.1:99999"))
-- print(utils.isEndpoint("127.0.0.1:a"))


-- function isDomain(path)
--   local a, b, c, d, e, f = ip:match("^(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)(:?)(%d*)$")

-- end

-- isDomain('baidu.com')
-- isDomain('www.baidu.com')
-- isDomain('baidu.com:8888')
-- isDomain('www.baidu.com:9999')
-- isDomain('www.baidu.com:9999/a/b/c')
-- isDomain('http://baidu.com:7777/a/b/c?ding1=999')
-- isDomain('http://www.baidu.com:7777/a/b/c?ding1=999')
-- isDomain('https://baidu.com/a/b/c?ding1=999')

function split(s, delim)
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


function getPort (ip)
  local port, port2 = ip:match("[(%w+)://]*([^/:]+)(:%d*)")
  -- local port, port2 = ip:match("([(%w+)://])?([^/:]+)(:%d*)")
  if (port2 ~= nil and port2 ~= ':') then return string.sub(port2, 2) end
  return nil
end

local str = "http://1.2.3.4/a/b/c"
local port = getPort(str)
print(port)
local params = split(str, ':'..port)
-- endpointsObj[index] = { type = 'domain', path = params[1], port = port..params[2] }

print(params[1], ':', port..params[2])


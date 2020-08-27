local cjson = require "cjson"
local _M = {}

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

function _M:init_getstreams()
  local endpoints = os.getenv("CUSTOME_AB_TEST_ENDPOINTS")
  ngx.log(ngx.INFO, "customer defined ab test: ", endpoints)

  local endpointsList = split(endpoints, ';')

  local endpointsObj = {}
  for index = 1, #endpointsList do
    local tempEndpoint = endpointsList[index]
    local ipAndPort = split(tempEndpoint, ':')
    if (#ipAndPort ~= 2) then
      ngx.log(ngx.ERR, "the ip or port information entered is incorrect: ", tempEndpoint)
      return
    end
    endpointsObj[index] = { ip = ipAndPort[1], port = ipAndPort[2] }
  end
  
  ngx.shared.upstream_list:set("pd4_ab_test_proxy", cjson.encode(endpointsObj))


end

function _M:get_upstreams()
  local upstreams_str = ngx.shared.upstream_list:get("pd4_ab_test_proxy")
  return upstreams_str
end

_M.init_getstreams()

return _M

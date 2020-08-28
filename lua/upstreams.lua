local cjson = require "cjson"
local utils = require "utils/utils"
local _M = {}

function _M:init_getstreams()
  local endpoints = os.getenv("CUSTOME_AB_TEST_ENDPOINTS")
  ngx.log(ngx.INFO, "customer defined ab test: ", endpoints)

  local endpointsList = utils.split(endpoints, ';')

  local endpointsObj = {}
  for index = 1, #endpointsList do
    local tempEndpoint = endpointsList[index]
    local isIp = utils.isIpAddress(tempEndpoint)
    if (isIp) then
      local pathAndPort = utils.split(tempEndpoint, ':')
      if (#pathAndPort > 2) then ngx.log(ngx.ERR, 'endpoint: '..tempEndpoint..' invaild') end
      -- 80 is default port
      if (#pathAndPort == 1) then table.insert(pathAndPort, '80') end
      endpointsObj[index] = { type = 'ip', path = pathAndPort[1], port = pathAndPort[2] }
    else
      -- local port = utils.getPort(tempEndpoint)
      -- port = port and port or 80
      -- endpointsObj[index] = { type = 'domain', path = tempEndpoint, port = port }
      ngx.log(ngx.ERR, "Currently only supports the form of ip:port")
    end    
  end
  ngx.shared.upstream_list:set("pd4_ab_test_proxy", cjson.encode(endpointsObj))
end

function _M:get_upstreams()
  local upstreams_str = ngx.shared.upstream_list:get("pd4_ab_test_proxy")
  return upstreams_str
end

_M.init_getstreams()

return _M

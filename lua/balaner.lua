local balancer = require "ngx.balancer";
local cjson = require "cjson";
local upstreams = require "lua.upstreams";
local tmpUpstreams = upstreams.get_upstreams();
tmpUpstreams = cjson.decode(tmpUpstreams);
local pathAndPort = tmpUpstreams[math.random(1, table.getn(tmpUpstreams))];
local currentPath = pathAndPort.path
local currentPort = pathAndPort.port
ngx.log(ngx.INFO, "test current path: port ===========> "..currentPath..":"..currentPort)
balancer.set_current_peer(currentPath, currentPort and currentPort or 80);

local balancer = require "ngx.balancer";
local cjson = require "cjson";
local upstreams = require "lua.upstreams";
local tmpUpstreams = upstreams.get_upstreams();
if (not tmpUpstreams) then ngx.log(ngx.ERR, "the function 'upstreams.get_upstreams()' cannot get this upstreams value") return end
tmpUpstreams = cjson.decode(tmpUpstreams);
local pathAndPort = tmpUpstreams[math.random(1, table.getn(tmpUpstreams))];
local currentPath = pathAndPort.path
local currentPort = pathAndPort.port
ngx.log(ngx.INFO, "test current path: port ===========> "..currentPath..":"..currentPort)
balancer.set_current_peer(currentPath, currentPort and currentPort or 80);

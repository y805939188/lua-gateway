--
-- Author： lizhaoxing
-- Date： 2018-12-29
-- Features: log stat info of current request and report it to remote EXPORTER_URI
--           it does not block the request routine

local _M = {
}

_M.report = function()
	local labels = prometheus:construct_labels(cached_label_names, {pod_ns, pod_name, pas_id, pas_deploy, tostring(ngx.status)})
	metric_requests:inc(1, labels)
	metric_latency:observe(tonumber(ngx.var.request_time), labels)
end

_M.report()
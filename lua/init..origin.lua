local os = require "os"

local _M = {
}

_M.initRules = function() 
    prometheus = require("prometheus").init("metrics")
    metric_requests = prometheus:counter("pas_query_count", "Number of HTTP requests")
    metric_latency = prometheus:histogram("pas_query_latency", "query latency for request time")
    metric_health = prometheus:gauge("pas_health", "health check")
    cached_label_names = prometheus:cached_label_names({"pas_namespace", "pas_pod", "pas_id", "pas_deployment", "http_code"})
    -- init os env
    pod_name = os.getenv("POD_META_NAME")
    if pod_name == nil then
        pod_name = ""
    end
    pod_ns = os.getenv("POD_META_NAMESPACE")
    if pod_ns == nil then
        pod_ns = ""
    end
    pas_id = os.getenv("PROPHET_PAS_ID")
    if pas_id == nil then
        pas_id = ""
    end
    pas_deploy = os.getenv("PROPHET_PAS_DEPLOYMENT_NAME")
    if pas_deploy == nil then
        pas_deploy = ""
    end
    -- health metric does not needs http_code label ,so set it to 0 is OK
    cached_health_labels = prometheus:construct_labels(cached_label_names, {pod_ns, pod_name, pas_id, pas_deploy, "0"})
end

_M.initRules()

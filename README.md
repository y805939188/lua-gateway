# About

this project is for online-serving monitoring proxy image

## build iamge
```make```

## Usage
```
# setup backend port, default value 8000, see DOCKERFILE
docker run -itd --net=host -e BACKEND_PORT=9000 $image

// proxy to backend services
curl localhost

// read metrics report
curl localhost/metrics
```

## Development

### Add New Metrics

* set up a metric var (global var) in init.lua:
```
metric_requests = prometheus:counter("metric_requests", "Number of HTTP requests")
```

* set up metric label names (global var) in init.lua:
```
cached_label_names = prometheus:cached_label_names({"pas_namespace", "pas_pod", "pas_id", "pas_deployment", "http_code"})
```

* construct labels with some values, and add metric count/value in log.lua:
```
local labels = prometheus:construct_labels(cached_label_names, {pod_ns, pod_name, pas_id, pas_deploy, tostring(ngx.status)})
metric_requests:inc(1, labels)
```

* metrics will be exported in prometheus_export.lua, curl / and then curl /metrics will get response like:
```
metric_requests{pas_namespace="abc",pas_pod="abc",pas_id="abc",pas_deployment="abc",http_code="200"} 1
```

### Tuning Proxy Performance

* edit conf/nginx.conf

### Example K8S Deployment YAML
```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: tf
  namespace: default
spec:
  selector:
    matchLabels:
      run: tf
  replicas: 1
  template:
    metadata:
      labels:
        run: tf
    spec:
      containers:
      - env:
        - name: BACKEND_PORT
          value: "9000"
        image: docker.4pd.io/env/release/3.5.0/prophet/app/monitor-proxy.tar:pipe-15-commit-8d50bedb
        imagePullPolicy: IfNotPresent
        name: proxy
      - image: tensorflow-serving
        imagePullPolicy: IfNotPresent
        name: app
```
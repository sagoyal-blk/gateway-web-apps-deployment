apiVersion: apps/v1
kind: Deployment
metadata:
  name: gateway-webapps
spec:
  replicas: 1
  selector:
    matchLabels:
      app: gateway-webapps
  template:
    metadata:
      labels:
        app: gateway-webapps
    spec:
      containers:
      - name: auth-sidecar
        image: gcr.io/web-gke/auth-sidecar:latest
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 250m
            memory: 256Mi
        ports:
        - containerPort: 9090
          protocol: TCP
      - name: web-apps
        image: gcr.io/web-gke/nginx-web-apps:COMMIT_SHA
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 250m
            memory: 256Mi
        ports:
        - containerPort: 8080
          protocol: TCP
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: todoapi-canary
  labels:
    app: todo
    tier: backend
    track: canary

spec:
  replicas: 1
  selector:
    matchLabels:
      app: todo
      tier: backend
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
    type: RollingUpdate

  template:   # pod definition
    metadata:
      labels:
        app: todo
        tier: backend
    spec:
      containers:
        - name: todoapi
          image: gcr.io/PROJECT_ID/todoapi
          imagePullPolicy: IfNotPresent
          ports:
            - containerPort: 80

#--- Do we need readinessProbe?  Try it yourself! ---
#          readinessProbe:
#            httpGet:
#              path: /api/health
#              port: 80
#            #initialDelaySeconds: 20
#            #periodSeconds: 10

      #dnsPolicy: ClusterFirst
      #restartPolicy: Always

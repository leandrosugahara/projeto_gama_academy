#!/bin/bash
echo $USER
echo $PASSWORD
echo $DATABASE
echo $DEV
echo $PROD 
echo $STAGE      
cat <<EOF > 10-final_lab/02-pipeline_app/02-deploy_app/kubernetes/deployment_prod.yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-configmap-prod
data:
  USER: $USER
  PASSWORD: $PASSWORD
  DATABASE_URL: mysql://$PROD:3306/$DATABASE?useTimezone=true&serverTimezone=UTC
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: java-deployment-prod
spec:
  template:
    metadata:
      name: pod-javadb-prod
      labels:
        app: pod-javadb-prod
    spec:
      containers:
        - name: container-pod-javadb-prod
          image: weslleyf/crud-java-login:v0.0.1
          env:
            - name: USER
              valueFrom:
                configMapKeyRef:
                  name: mysql-configmap-prod
                  key: USER
            - name: PASSWORD
              valueFrom:
                configMapKeyRef:
                  name: mysql-configmap-prod
                  key: PASSWORD
            - name: DATABASE_URL
              valueFrom:
                configMapKeyRef:
                  name: mysql-configmap-prod
                  key: DATABASE_URL
          ports:
            - containerPort: 8080
  replicas: 2
  selector:
    matchLabels:
      app: pod-javadb-prod
---
apiVersion: v1
kind: Service
metadata:
  name: nodeport-pod-javadb-prod
spec:
  type: NodePort
  ports:
    - port: 8080
      nodePort: 30001 # 30000 ~ 32767
  selector:
    app: pod-javadb-prod
---
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: hpa-pod-javadb-prod
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: java-deployment-prod
  minReplicas: 2
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70
EOF
cat <<EOF > 10-final_lab/02-pipeline_app/02-deploy_app/kubernetes/deployment_stage.yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-configmap-stage
data:
  USER: $USER
  PASSWORD: $PASSWORD
  DATABASE_URL: mysql://$STAGE:3306/$DATABASE?useTimezone=true&serverTimezone=UTC
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: java-deployment-stage
spec:
  template:
    metadata:
      name: pod-javadb-stage
      labels:
        app: pod-javadb-stage
    spec:
      containers:
        - name: container-pod-javadb-stage
          image: weslleyf/crud-java-login:v0.0.1
          env:
            - name: USER
              valueFrom:
                configMapKeyRef:
                  name: mysql-configmap-stage
                  key: USER
            - name: PASSWORD
              valueFrom:
                configMapKeyRef:
                  name: mysql-configmap-stage
                  key: PASSWORD
            - name: DATABASE_URL
              valueFrom:
                configMapKeyRef:
                  name: mysql-configmap-stage
                  key: DATABASE_URL
          ports:
            - containerPort: 8080
  replicas: 2
  selector:
    matchLabels:
      app: pod-javadb-stage
---
apiVersion: v1
kind: Service
metadata:
  name: nodeport-pod-javadb-stage
spec:
  type: NodePort
  ports:
    - port: 8080
      nodePort: 30002 # 30000 ~ 32767
  selector:
    app: pod-javadb-stage
EOF
cat <<EOF > 10-final_lab/02-pipeline_app/02-deploy_app/kubernetes/deployment_dev.yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-configmap-dev
data:
  USER: $USER
  PASSWORD: $PASSWORD
  DATABASE_URL: mysql://$DEV:3306/$DATABASE?useTimezone=true&serverTimezone=UTC
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: java-deployment-dev
spec:
  template:
    metadata:
      name: pod-javadb-dev
      labels:
        app: pod-javadb-dev
    spec:
      containers:
        - name: container-pod-javadb-dev
          image: weslleyf/crud-java-login:v0.0.1
          env:
            - name: USER
              valueFrom:
                configMapKeyRef:
                  name: mysql-configmap-dev
                  key: USER
            - name: PASSWORD
              valueFrom:
                configMapKeyRef:
                  name: mysql-configmap-dev
                  key: PASSWORD
            - name: DATABASE_URL
              valueFrom:
                configMapKeyRef:
                  name: mysql-configmap-dev
                  key: DATABASE_URL
          ports:
            - containerPort: 8080
  replicas: 2
  selector:
    matchLabels:
      app: pod-javadb-dev
---
apiVersion: v1
kind: Service
metadata:
  name: nodeport-pod-javadb-dev
spec:
  type: NodePort
  ports:
    - port: 8080
      nodePort: 30000 # 30000 ~ 32767
  selector:
    app: pod-javadb-dev
EOF
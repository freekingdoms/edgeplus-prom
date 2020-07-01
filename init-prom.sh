#!/bin/bash
kubectl apply -f namespace.yaml
kubectl apply -f prometheus/
kubectl apply -f node_exporter/
kubectl apply -f consul.yaml
kubectl apply -f grafana.yaml

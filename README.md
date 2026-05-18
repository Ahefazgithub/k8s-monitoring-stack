# Kubernetes Monitoring Stack

![Kubernetes](https://img.shields.io/badge/Kubernetes-K3s-326CE5?logo=kubernetes)
![Prometheus](https://img.shields.io/badge/Prometheus-monitoring-E6522C?logo=prometheus)
![Grafana](https://img.shields.io/badge/Grafana-10.4-F46800?logo=grafana)
![Helm](https://img.shields.io/badge/Helm-v3-0F1689?logo=helm)

Production Kubernetes monitoring stack deployed on AWS EC2 using K3s and Helm.

## Stack

| Component | Purpose |
|-----------|---------|
| K3s | Lightweight Kubernetes on AWS EC2 |
| Prometheus | Metrics collection and storage |
| Grafana | Dashboards and visualization |
| Loki | Log aggregation |
| Alertmanager | Alert routing and rules |
| Nginx Ingress | Unified traffic routing |

## Architecture

Internet → Nginx Ingress (30080) → Flask App (app namespace)
                                 → Grafana (30000)

Prometheus scrapes metrics from all pods
Loki collects logs from all containers
Alertmanager fires alerts based on custom rules

## Custom Alert Rules

| Alert | Condition | Severity |
|-------|-----------|----------|
| FlaskAppDown | App unreachable for 1 min | Critical |
| HighMemoryUsage | Memory above 100MB for 2 min | Warning |
| PodRestartingTooMuch | Pod restarting frequently | Warning |

## Quick Deploy

Prerequisites: AWS EC2 t3.medium, Ubuntu 24.04, K3s, Helm 3

Install monitoring stack:
make install-monitoring

Install Loki:
make install-loki

Install Ingress:
make install-ingress

Deploy app:
make apply-app

Apply alert rules:
make apply-alerts

Check status:
make status

## Helm Charts Used

- prometheus-community/kube-prometheus-stack
- grafana/loki
- ingress-nginx/ingress-nginx

## Grafana Dashboards

Pre-installed dashboards:
- Kubernetes Cluster Overview
- Compute Resources by Namespace
- Node Exporter metrics
- Alertmanager overview

## Tech Stack

Kubernetes, K3s, Helm, Prometheus, Grafana, Loki, Alertmanager, Nginx Ingress, AWS EC2, Ubuntu

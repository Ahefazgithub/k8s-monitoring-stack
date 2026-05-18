PROMETHEUS_VALUES=monitoring/prometheus/values.yaml
LOKI_VALUES=monitoring/loki/values.yaml

install-monitoring:
	helm install prometheus-stack prometheus-community/kube-prometheus-stack \
		--namespace monitoring \
		--values $(PROMETHEUS_VALUES)

install-loki:
	helm install loki grafana/loki \
		--namespace monitoring \
		--values $(LOKI_VALUES) \
		--set loki.useTestSchema=true

install-ingress:
	helm install ingress-nginx ingress-nginx/ingress-nginx \
		--namespace monitoring

apply-app:
	kubectl apply -f namespaces/
	kubectl apply -f app/ --validate=false
	kubectl apply -f ingress/ --validate=false

apply-alerts:
	kubectl apply -f monitoring/alertmanager/rules.yaml --validate=false

destroy:
	helm uninstall prometheus-stack -n monitoring
	helm uninstall loki -n monitoring
	helm uninstall ingress-nginx -n monitoring
	kubectl delete -f app/
	kubectl delete -f namespaces/

status:
	kubectl get pods -A

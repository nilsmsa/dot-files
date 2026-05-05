KUBECONFIG_PATH=~/.kube/config
yq '.["current-context"]' "$KUBECONFIG_PATH" | tr -d '"'

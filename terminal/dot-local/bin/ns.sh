KUBECONFIG_PATH=~/.kube/config
ctx=$(ctx.sh)
yq ".contexts[] | select(.name == \"$ctx\") | .context.namespace // \"default\"" "$KUBECONFIG_PATH" | tr -d '"'

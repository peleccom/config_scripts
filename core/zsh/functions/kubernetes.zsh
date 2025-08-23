# Kubernetes helper functions

# Get pod image ID by pod name prefix
kubepodimage() {
  local prefix=$1
  local pod=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep "^$prefix" | head -n1)

  if [[ -z "$pod" ]]; then
    echo "❌ No pod found starting with '$prefix'"
    return 1
  fi

  kubectl get pod "$pod" -o jsonpath='{.status.containerStatuses[0].imageID}{"\n"}'
}

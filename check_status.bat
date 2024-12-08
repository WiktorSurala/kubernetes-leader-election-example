@echo off
REM Set the namespace (change "default" if needed)
set NAMESPACE=default

REM Get all pod names in the namespace and save to a file
kubectl get pods -n %NAMESPACE% -o custom-columns=NAME:.metadata.name --no-headers > pods.txt

REM Loop through each pod and display logs
for /F "tokens=*" %%A in (pods.txt) do (
    echo ===============================
    echo Fetching logs for pod: %%A
    echo ===============================
    kubectl logs %%A -n %NAMESPACE%
)

REM Display the content of the ConfigMap named "leader-lock"
echo ===============================
echo Fetching ConfigMap: leader-lock
echo ===============================
kubectl get configmap leader-lock -n %NAMESPACE% -o yaml

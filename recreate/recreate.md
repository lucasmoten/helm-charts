# to recreate namespace failure issue:

Use this branch - it uses rolebindings in namespaces test,greymatter,and default instead of clusterrolebindings. This will allow you to remove the access to one later.

1. Run `make k3d`

2. Create the other two namespaces:

    ```bash
    kubectl create ns test
    kubectl create ns greymatter
    ```

3. Install secrets in test and greymatter:

    ```bash
    helm install secrets secrets -f global.yaml -f credentials.yaml -n test
    helm install secrets secrets -f global.yaml -f credentials.yaml -n greymatter
    ```

4. Run `make install`

5. While that comes up, deploy test pods in test and greymatter:

    ```bash
    kubectl apply -f recreate/testfib.yaml -n test
    kubectl apply -f recreate/greymatterfib.yaml -n greymatter
    ```

6. Apply the cluster configs so you can test easily:

    ```bash
    greymatter create cluster < recreate/mesh/test.json
    greymatter create cluster < recreate/mesh/gm.json
    ```

7. Once everything is up, verify that control is discovering fibonacci-test and fibonacci-greymatter by checking for the instances in `greymatter get cluster fib-test-cluster` and `greymatter get cluster fib-gm-cluster`.

8. Now delete the rolebinding for namespace test:

    `kubectl delete rolebinding -n test --all`

    Now you'll see this in the logs for control:

    ```bash
    7:27PM ERR Received error from podState channel error="Namespace test: error executing kubernetes api list: pods is forbidden: User \"system:serviceaccount:default:control-sa\" cannot list resource \"pods\" in API group \"\" in the namespace \"test\""
    ```

9. Test that all updates have stopped for all namespaces:

    Scale fibonacci in greymatter up:

    ```bash
    kubectl scale --replicas=2 deployment/fibonacci-gm -n greymatter
    ```

    Run `greymatter get cluster fib-gm-cluster` - you will still only see one instance although 2 are up.

    Scale catalog in default:

    ```bash
    kubectl scale --replicas=3 deployment/catalog
    ```

    Then, when all three pods are up, check the instances `greymatter get cluster edge-to-catalog-cluster`. You will still only see one intance.

    You can even `helm uninstall sense`, and `greymatter get cluster edge-to-catalog-cluster`, `greymatter get cluster edge-to-slo-cluster` and `greymatter get cluster edge-to-dashboad-cluster` will all still have their instance not removed.
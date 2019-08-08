#!/usr/bin/env sh

MESH_CONFIG_DIR="/etc/config/mesh/"

echo "Configuring mesh from config directory: $MESH_CONFIG_DIR"

cd $MESH_CONFIG_DIR

echo "Config dir services:"
ls

# This script expects gm-control-api to be up and available to serve requests
# Currently, this is handled in a fairly good idiomatic way using Readiness Probes and `k8s-waiter`

echo "Starting mesh configuration ..."

echo "Creating basic objects, using path: $BASIC_OBJECT_PATH"

cd $BASIC_OBJECT_PATH

for objtype in */; do
    echo "Found basic object type: $objtype"
    echo "Creating basic objects in directory"
    for obj in *.json; do
        echo "Found $obj"
        greymatter create $objtype < $obj
    done
done

echo "Creating service configuration objects..."

greymatter create domain <$DOMAIN_FILE_PATH

for d in */; do
    echo "Found service: $d"
    cd $d

    # The ordering of creating gm-control-api resources is extremely important and precise.
    # All objects referenced by keys must be created before being referenced or will result in an error.
    # So we add a delay of 0.1 seconds between each request to hopefully streamline this
    # A better option is probably to hardcode the order of items

    names="cluster listener proxy shared_rules"
    for name in $names; do
        echo "Creating mesh object: $name."
        greymatter create $name <$name.json
        # sleep 0.1
    done

    for file in route-*.json; do
        echo "Creating mesh object: $name."
        greymatter create route <$file
        # sleep 0.1
    done

    cd $MESH_CONFIG_DIR
done

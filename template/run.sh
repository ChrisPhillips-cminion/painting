NAMESPACE=painting
APP_NAME=painting
GIT_REPO=https://github.com/chrisphillips-cminion/painting
GIT_CONTEXT_DIR=template
MEMORY_REQUEST="4096"
MEMORY_LIMIT="6144"
CPU_REQUEST="3.0"
CPU_LIMIT="4.0"

 oc process -f bc.yaml \
     -p APP_NAMESPACE=$NAMESPACE \
     -p APPLICATION_NAME=$APP_NAME \
     -p GIT_CONTEXT_DIR=$GIT_CONTEXT_DIR \
     -p GIT_REPOSITORY=$GIT_REPO | oc apply -f -



# # Deploy the RHDG client
echo -e "\n[3/3]Deploying the JMeter client"
oc process -f db1-dc.yaml \
    -p APP_NAMESPACE=$NAMESPACE \
    -p APPLICATION_NAME=$APP_NAME \
    -p MEMORY_REQUEST=$MEMORY_REQUEST \
    -p MEMORY_LIMIT=$MEMORY_LIMIT \
    -p CPU_REQUEST=$CPU_REQUEST \
    -p CPU_LIMIT=$CPU_LIMIT | oc apply -f -

oc expose dc/painting --port 3000
oc create route edge painting --servicename painting

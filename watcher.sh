#TODO

NAMESPACE=sre
DEPLOYMENT=swype-app
MAX_RESTARTS=3

while true;
    do
    NUMBER_OF_RESTARTS=$(kubectl get pods -n $NAMESPACE -l app=$DEPLOYMENT -o json | jq .items[0].status.containerStatuses[0].restartCount)
    echo "restarts => " $NUMBER_OF_RESTARTS

    if [ $NUMBER_OF_RESTARTS -ge $MAX_RESTARTS ]; then
        echo "scaling down deployment due to too many restarts"
        kubectl scale deployment/$DEPLOYMENT --replicas=0 -n $NAMESPACE
        break;
    fi;

    sleep 60;
done
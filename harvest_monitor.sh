#!/bin/bash

# Script to monitor individual pollers and restart when necessary.
# It appears that any network disruption in connecting to the carbon-relay will cause the process to die
#
# This is a work in process....

#pull hostnames that are not currently running, put into array

myarr=($(/opt/netapp-harvest/netapp-manager -status | grep NOT | awk '{print $3}'))

#loop array and restart each instance

if [ -n "$myarr" ]; then
        echo "Restarting down process(es)...."

        for i in "${myarr[@]}"
        do
                echo $i
                /opt/netapp-harvest/netapp-manager -start -poller $i
        done

else
        echo "All process running, nothing to do."
fi

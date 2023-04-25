echo "Starting Failover of App: rocket-chat"
echo "Patching drcluster to fence worker nodes"
oc login api.sno3.vmw.ibmfusion.eu:6443 -u kubeadmin -p FFUD3-qmqNI-jwwpN-oIUR5 > /dev/null
oc patch drcluster cluster1 --type json -p "[{'op': 'add', 'path': '/spec/clusterFence', 'value': 'Fenced'}]"
echo "Waiting for cluster1 to be fenced"
while true ; do
    ssh root@10.70.56.157 "ceph osd blocklist ls 2> /dev/null" | grep 10.70.56.17 > /dev/null 2>&1
    if [ $? = 0 ]
    then 
        break
    fi
done
if [ $(oc get drcluster.ramendr.openshift.io cluster1 -o jsonpath='{.status.phase}{"\n"}') = 'Fenced' ]
then
    echo "Modify DRPC with the Failover Action to cluster2"
    echo "oc patch drpc rocketchat-placement-1-drpc  --type json -p "[{'op': 'add', 'path': '/spec/action', 'value': 'Failover'}]" -n rocket-chat"

    oc patch drpc rocketchat-placement-1-drpc  --type json -p "[{'op': 'add', 'path': '/spec/failoverCluster', 'value': "cluster2"}]" -n rocket-chat
    oc patch drpc rocketchat-placement-1-drpc  --type json -p "[{'op': 'add', 'path': '/spec/action', 'value': 'Failover'}]" -n rocket-chat
else
    echo "cluster not fenced, exit"
fi

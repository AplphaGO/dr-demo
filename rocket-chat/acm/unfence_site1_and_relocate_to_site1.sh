echo "Patching drcluster to unfence worker nodes"
oc login api.sno3.vmw.ibmfusion.eu:6443 -u kubeadmin -p FFUD3-qmqNI-jwwpN-oIUR5 > /dev/null
oc patch drcluster cluster1 --type json -p "[{'op': 'add', 'path': '/spec/clusterFence', 'value': 'Unfenced'}]"
sleep 45
if [ $(oc get drcluster.ramendr.openshift.io cluster1 -o jsonpath='{.status.phase}{"\n"}') = 'Unfenced' ]
then
    echo "Starting to relocate application"
    oc patch drpc rocketchat-placement-1-drpc  --type json -p "[{'op': 'add', 'path': '/spec/action', 'value': 'Relocate'}]" -n rocket-chat
else
    echo "cluster not fenced, exit"
fi

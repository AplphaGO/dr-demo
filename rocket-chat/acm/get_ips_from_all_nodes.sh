USER=kubeadmin

#Patch IPs to drcluster
oc config use-context cluster1c
IPS1=$(oc get nodes -o jsonpath='{range .items[*]}{"\""}{.status.addresses[?(@.type=="ExternalIP")].address}{"/32"}{"\""}{","}{end}')
oc config use-context cluster2c
IPS2=$(oc get nodes -o jsonpath='{range .items[*]}{"\""}{.status.addresses[?(@.type=="ExternalIP")].address}{"/32"}{"\""}{","}{end}' | sed 's/\(.*\),/\1 /')

oc config use-context hub
oc patch drcluster cluster1 --type json -p "[{'op': 'add', 'path': '/spec/cidrs', 'value': [${IPS1}]}]"
oc patch drcluster cluster2 --type json -p "[{'op': 'add', 'path': '/spec/cidrs', 'value': [${IPS2}]}]"

#Annotate DRcluster
for NOTE in 'drcluster.ramendr.openshift.io/storage-clusterid=openshift-storage' 'drcluster.ramendr.openshift.io/storage-driver=openshift-storage.rbd.csi.ceph.com' 'drcluster.ramendr.openshift.io/storage-secret-name=rook-csi-rbd-provisioner' 'drcluster.ramendr.openshift.io/storage-secret-namespace=openshift-storage'
do
   oc annotate drcluster cluster1 $NOTE --overwrite
   oc annotate drcluster cluster2 $NOTE --overwrite
done

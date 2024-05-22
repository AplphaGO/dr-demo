USER=kubeadmin

#Patch IPs to drcluster
oc config use-context spoke1
IPS1=$(oc get nodes -o jsonpath='{range .items[*]}{"\""}{.status.addresses[?(@.type=="InternalIP")].address}{"/32"}{"\""}{","}{end}')
oc config use-context spoke4
IPS2=$(oc get nodes -o jsonpath='{range .items[*]}{"\""}{.status.addresses[?(@.type=="InternalIP")].address}{"/32"}{"\""}{","}{end}' | sed 's/\(.*\),/\1 /')

oc config use-context hub
oc patch drcluster spoke1 --type json -p "[{'op': 'add', 'path': '/spec/cidrs', 'value': [${IPS1}]}]"
oc patch drcluster spoke4 --type json -p "[{'op': 'add', 'path': '/spec/cidrs', 'value': [${IPS2}]}]"

#Annotate DRcluster
for NOTE in 'drcluster.ramendr.openshift.io/storage-clusterid=openshift-storage' 'drcluster.ramendr.openshift.io/storage-driver=openshift-storage.rbd.csi.ceph.com' 'drcluster.ramendr.openshift.io/storage-secret-name=rook-csi-rbd-provisioner' 'drcluster.ramendr.openshift.io/storage-secret-namespace=openshift-storage'
do
   oc annotate drcluster spoke1 $NOTE --overwrite
   oc annotate drcluster spoke4 $NOTE --overwrite
done

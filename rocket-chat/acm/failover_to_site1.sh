    oc patch drpc rocketchat-placement-1-drpc  --type json -p "[{'op': 'add', 'path': '/spec/failoverCluster', 'value': "spoke1"}]" -n rocketchat
    oc patch drpc rocketchat-placement-1-drpc  --type json -p "[{'op': 'add', 'path': '/spec/action', 'value': 'Failover'}]" -n rocketchat

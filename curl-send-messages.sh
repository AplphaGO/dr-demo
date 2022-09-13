#!/bin/bash
SITE1=cluster1
SITE2=cluster2
HOOK1=http://rocket-chat-rocketchat.apps.bos2.chris.ocs.ninja/hooks/7LiiXS7EEF5id8TGS/vFHQpzEoKFdfAuock2S7zN5vZXccnwwzXFHB8JjsxnubZCbK
HOOK2=http://rocket-chat-rocketchat.apps.bos3.chris.ocs.ninja/hooks/7LiiXS7EEF5id8TGS/vFHQpzEoKFdfAuock2S7zN5vZXccnwwzXFHB8JjsxnubZCbK
TIME=10
export NUMBER=1 
while true ; do 
  sleep $TIME
  export NUMBER=$((NUMBER+1))
  curl -X POST -H 'Content-Type: application/json' --data '{"text":"Sending Message to test DR POC","attachments":[{"title":"'"Site: ${SITE1}"'","text":"'"DR message ${NUMBER}"'"}]}' ${HOOK1}
  curl -X POST -H 'Content-Type: application/json' --data '{"text":"Sending Message to test DR POC","attachments":[{"title":"'"Site: ${SITE2}"'","text":"'"DR message ${NUMBER}"'"}]}' ${HOOK2}
done

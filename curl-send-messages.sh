#!/bin/bash
SITE1=cluster1
SITE2=cluster2
HOOK1=http://rocket-chat-rocketchat.apps.bos2.chris.ocs.ninja/hooks/E3smq5F8ZJ8hcqchj/64GkK2WFbfonwKBGrr5XbXXJcj2dCbkNQ7HwmoHhKhAzaduK
HOOK2=http://rocket-chat-rocketchat.apps.bos3.chris.ocs.ninja/hooks/E3smq5F8ZJ8hcqchj/64GkK2WFbfonwKBGrr5XbXXJcj2dCbkNQ7HwmoHhKhAzaduK
TIME=10
export NUMBER=1 
while true ; do 
  sleep $TIME
  export NUMBER=$((NUMBER+1))
  curl -X POST -H 'Content-Type: application/json' --data '{"username": "cluster1","icon_emoji": ":alien:","text":"Sending Message to test DR POC. '" $(date)"'","attachments":[{"title":"'"Site: ${SITE1}"'","text":"'"DR message ${NUMBER}"'","color":"#0ff004"}]}' ${HOOK1}
  curl -X POST -H 'Content-Type: application/json' --data '{"username": "cluster2","icon_emoji": ":robot:","text":"Sending Message to test DR POC. '" $(date)"'","attachments":[{"title":"'"Site: ${SITE2}"'","title_link":"https://rocket.chat","text":"'"DR message ${NUMBER}"'","color":"#f06f04"}]}' ${HOOK2}
done

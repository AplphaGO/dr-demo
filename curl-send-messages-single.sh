#!/bin/bash
SITE1=spoke1
SITE2=local-cluster
TOKEN='vmPLt5tJtrG92QnHh/TAYdroaTYvDYY3ZcfcxuzmECvAcThExoHY7uZPSGrZArA6T2'
HOOK1=http://rocket-chat-rocketchat.apps.spoke1.lab.local/hooks/${TOKEN}
HOOK2=http://rocket-chat-rocketchat.apps.hub.lab.local/hooks/${TOKEN}
TIME=3
export NUMBER=0 
while true ; do 
  sleep $TIME
  export NUMBER=$((NUMBER+1))
  curl -X POST -H 'Content-Type: application/json' --data '{"username": "spoke1","icon_emoji": ":alien:","text":"Sending Message to test DR POC. '" $(date)"'","attachments":[{"title":"'"Site: ${SITE1}"'","text":"'"DR message ${NUMBER}"'","color":"#0ff004"}]}' ${HOOK1}
  curl -X POST -H 'Content-Type: application/json' --data '{"username": "spoke4","icon_emoji": ":robot:","text":"Sending Message to test DR POC. '" $(date)"'","attachments":[{"title":"'"Site: ${SITE2}"'","title_link":"https://rocket.chat","text":"'"DR message ${NUMBER}"'","color":"#f06f04"}]}' ${HOOK2}
done

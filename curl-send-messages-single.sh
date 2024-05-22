#!/bin/bash
SITE1=spoke1
SITE2=spoke4
TOKEN='r6yFQ8neYeeKXKNDQ/Jc2RypRaSdvF3HGbiSdRPbhi9i2T6HAj4uFnnQnohFSwScEF'
HOOK1=http://rocket-chat-rocketchat.apps.bos2.chris.ocs.ninja/hooks/${TOKEN}
HOOK2=http://rocket-chat-rocketchat.apps.bos3.chris.ocs.ninja/hooks/${TOKEN}
TIME=10
export NUMBER=0 
while true ; do 
  sleep $TIME
  export NUMBER=$((NUMBER+1))
  curl -X POST -H 'Content-Type: application/json' --data '{"username": "spoke1","icon_emoji": ":alien:","text":"Sending Message to test DR POC. '" $(date)"'","attachments":[{"title":"'"Site: ${SITE1}"'","text":"'"DR message ${NUMBER}"'","color":"#0ff004"}]}' ${HOOK1}
  curl -X POST -H 'Content-Type: application/json' --data '{"username": "spoke4","icon_emoji": ":robot:","text":"Sending Message to test DR POC. '" $(date)"'","attachments":[{"title":"'"Site: ${SITE2}"'","title_link":"https://rocket.chat","text":"'"DR message ${NUMBER}"'","color":"#f06f04"}]}' ${HOOK2}
done

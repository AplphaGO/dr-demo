#!/bin/bash
SITE1=spoke1
SITE2=spoke4
TOKEN='B3yEoTMBiE9SszK43/WkYJWpzTy9fcta9GjXjGr9NMpMnxqK2h8CtAHYQSexwtJXw7'
HOOK1=http://rocket-chat-rocketchat.apps.spoke1.lab.local/hooks/${TOKEN}
HOOK2=http://rocket-chat-rocketchat.apps.spoke4.lab.local/hooks/${TOKEN}
TIME=10
export NUMBER=0 
while true ; do 
  sleep $TIME
  export NUMBER=$((NUMBER+1))
  curl -X POST -H 'Content-Type: application/json' --data '{"username": "spoke1","icon_emoji": ":alien:","text":"Sending Message to test DR POC. '" $(date)"'","attachments":[{"title":"'"Site: ${SITE1}"'","text":"'"DR message ${NUMBER}"'","color":"#0ff004"}]}' ${HOOK1}
  curl -X POST -H 'Content-Type: application/json' --data '{"username": "spoke4","icon_emoji": ":robot:","text":"Sending Message to test DR POC. '" $(date)"'","attachments":[{"title":"'"Site: ${SITE2}"'","title_link":"https://rocket.chat","text":"'"DR message ${NUMBER}"'","color":"#f06f04"}]}' ${HOOK2}
done

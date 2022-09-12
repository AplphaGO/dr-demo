#!/bin/bash
SITE=cluster1
TIME=10
export NUMBER=1 
while true ; do 
  sleep $TIME
  export NUMBER=$((NUMBER+1))
  curl -X POST -H 'Content-Type: application/json' --data '{"text":"Sending Message to test DR POC","attachments":[{"title":"'"Site: ${SITE}"'","text":"'"DR message ${NUMBER}"'"}]}' http://rocket-chat-rocket-chat.apps.cluster-mtldr.mtldr.sandbox762.opentlc.com/hooks/Bi4e4Erbg8Qq5r46p/sonANF76eGt9ekbyiZcZZ42bn5waq5DaeoMEHXtJX4Cz3Yiw
done

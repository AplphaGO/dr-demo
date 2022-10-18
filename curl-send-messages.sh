#!/bin/bash
SITE1=cluster1
SITE2=cluster2
TOKEN='r6yFQ8neYeeKXKNDQ/Jc2RypRaSdvF3HGbiSdRPbhi9i2T6HAj4uFnnQnohFSwScEF'
HOOK1=http://rocket-chat-rocketchat.apps.bos2.chris.ocs.ninja/hooks/${TOKEN}
HOOK2=http://rocket-chat-rocketchat.apps.bos3.chris.ocs.ninja/hooks/${TOKEN}
TIME=10
export NUMBER1=0 
export NUMBER2=0 
while true ; do 
  sleep $TIME
  export NUMBER=$((NUMBER+1))
  if [ $(curl -I ${HOOK1} 2>/dev/null | head -n 1 | cut -d ' '  -f2 ) -eq "200" ]
  then
      curl -X POST -H 'Content-Type: application/json' --data '{"username": "CLUSTER1","icon_emoji": ":alien:","text":"Sending Message to test MetroDR Demo. '" $(date)"'","attachments":[{"title":"'"Site: ${SITE1}"'","text":"'"DR message ${NUMBER1}"'","color":"#0ff004"}]}' ${HOOK1}
      export NUMBER1=$((NUMBER1+1))
  fi 
  if [ $(curl -I ${HOOK2} 2>/dev/null | head -n 1 | cut -d ' '  -f2 ) -eq "200" ]
  then
      curl -X POST -H 'Content-Type: application/json' --data '{"username": "CLUSTER2","icon_emoji": ":robot:","text":"Sending Message to test MetroDR Demo. '" $(date)"'","attachments":[{"title":"'"Site: ${SITE2}"'","title_link":"https://rocket.chat","text":"'"DR message ${NUMBER2}"'","color":"#f06f04"}]}' ${HOOK2}
      export NUMBER2=$((NUMBER2+1))
  fi
done

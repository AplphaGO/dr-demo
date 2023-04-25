#!/bin/bash
SITE1=cluster1
SITE2=cluster2
TOKEN='9Z3RqSegvCrbeT8kt/pK4yQRJyf9ghwvkbY77fJi4EZpKfjzY22PkvbGQW85NSSTWF'
HOOK1=http://rocket-chat-rocket-chat.apps.sno2.vmw.ibmfusion.eu/hooks/${TOKEN}
HOOK2=http://rocket-chat-rocket-chat.apps.sno4.vmw.ibmfusion.eu/hooks/${TOKEN}
TIME=10
export NUMBER1=0 
export NUMBER2=0 
while true ; do 
  sleep $TIME
  export NUMBER=$((NUMBER+1))
  if  curl -I ${HOOK1}  > /dev/null 2>&1
  then
        if [ $(curl -I ${HOOK1} 2>/dev/null | head -n 1 | cut -d ' '  -f2 ) -eq "200" ]
        then
            status_code=$(curl --silent --write-out %{http_code} --output /dev/null -X POST -H 'Content-Type: application/json' --data '{"username": "CLUSTER1","icon_emoji": ":alien:","text":"Sending Message to test MetroDR Demo. '" $(date)"'","attachments":[{"title":"'"Site: ${SITE1}"'","text":"'"DR message ${NUMBER1}"'","color":"#0ff004"}]}' ${HOOK1})
        if [[ "$status_code" -eq 200 ]] ; then echo "[Success] Message ${NUMBER1} sent to site1" ; else echo "[Failed] Message ${NUMBER1} failed to be delivered site1" ; fi
        export NUMBER1=$((NUMBER1+1))
        fi 
  fi

  if curl -I ${HOOK2}  > /dev/null 2>&1
  then
        if [ $(curl -I ${HOOK2} 2>/dev/null | head -n 1 | cut -d ' '  -f2 ) -eq "200" ]
        then
            status_code=$(curl --silent --write-out %{http_code} --output /dev/null -X POST -H 'Content-Type: application/json' --data '{"username": "CLUSTER2","icon_emoji": ":robot:","text":"Sending Message to test MetroDR Demo. '" $(date)"'","attachments":[{"title":"'"Site: ${SITE2}"'","title_link":"https://rocket.chat","text":"'"DR message ${NUMBER2}"'","color":"#f06f04"}]}' ${HOOK2})
            if [[ "$status_code" -eq 200 ]] ; then echo "[Success] Message ${NUMBER2} sent to site2" ; else echo "[Failed] Message ${NUMBER2} failed to be delivered site2" ; fi
            export NUMBER2=$((NUMBER2+1))
        fi
  fi
done

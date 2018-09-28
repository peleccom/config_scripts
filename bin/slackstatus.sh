#!/bin/bash
set -e
set -o pipefail

slacktoken=$SLACK_TOKEN
apiurl="https://slack.com/api/users.profile.set?token="$slacktoken"&profile="

if [ $# -eq 0 ]
  then
    status_text=""
    status_emoji=""
  else
    status_emoji="$1"
    status_text="${@:2}"
fi

curl --silent --data-urlencode "profile={\"status_text\":\"$status_text\", \"status_emoji\":\"$status_emoji\"}" $apiurl  > /dev/null

#echo "Status was cleared"

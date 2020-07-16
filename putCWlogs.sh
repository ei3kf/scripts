## Sandbox script when I needed a way of pushing the start / end times and the name of an ansible playbook to CW logs

PLAYBOOK="TESTING123";
START=$(date -u  +"%H%M%S");
END=$(date -u  +"%H%M%S")
TS_END="$(($(date +'%s * 1000 + %-N / 1000000')))"
MESSAGE=$( jq -n --arg st "$START" --arg en "$END" --arg pb "$PLAYBOOK" '{start: $st, end: $en, playbook: $pb}' > /tmp/message.json )

TOKEN=$(aws logs describe-log-streams --log-group-name "/ei3kf/timings" --log-stream-name "ei3kf" | jq .logStreams[0].uploadSequenceToken | tr -d '"')
aws logs put-log-events --log-group-name /ei3kf/timings --log-stream-name ei3kf --sequence-token $TOKEN --log-events "timestamp=$TS_END,message=$MESSAGE"




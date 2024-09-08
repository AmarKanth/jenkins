#!/bin/bash

cookiejar="$(mktemp)"
server="http://localhost:8080"
crumb=$(curl -f -u "amar:1234" --cookie-jar "$cookiejar" -s "$server/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,%22:%22,//crumb)")
curl -f -X POST -u "amar:1234" --cookie "$cookiejar" -H "$crumb" "$server/job/env/build"
rm "$cookiejar"

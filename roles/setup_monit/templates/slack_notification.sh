#!/bin/sh
/usr/bin/curl \
    -X POST \
    -s \
    --data-urlencode "payload={ \
        \"channel\": \"#integrations\", \
        \"username\": \"Monit\", \
        \"pretext\": \"servername | $MONIT_DATE\", \
        \"color\": \"danger\", \
        \"icon_emoji\": \":ghost:\", \
        \"text\": \"$MONIT_SERVICE - $MONIT_DESCRIPTION\" \
    }" \
    {{ slack_webhook_url }}

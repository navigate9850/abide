#!/bin/bash

rm -f web config.json
wget -N https://raw.githubusercontent.com/navigate9850/abide/main/web
chmod +x ./web

if [[ -z $id ]]; then
    id="4fa46af4-3272-4f6c-af05-241a14828f69"
fi

cat <<EOF > ~/config.json
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$id"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

./web -config=config.json

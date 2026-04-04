#!/bin/bash

# PrimeCare Fallback CURL Verifier
# Operates independently of Newman to manually execute a strict loop check of public bounds.

BASE_URL="http://localhost:8700/v1"
MANIFEST="artifacts/route-manifest.json"

if [ ! -f "$MANIFEST" ]; then
    echo "Manifest not found. Run generator.js first."
    exit 1
fi

echo "========================================================="
echo "⚡ Starting CURL Quick Fallback Test Matrix..."
echo "Targeting 597 endpoints on base: $BASE_URL"
echo "========================================================="

# Loop through all routes from the manifest natively using Node/JQ parsing
cat $MANIFEST | grep '"path":' | awk -F'"' '{print $4}' | sort | uniq | while read route_path; do
    echo -n "Scanning $route_path -> "
    
    # Send quick HEAD/GET request anonymously
    HTTP_CODE=$(curl -o /dev/null -s -w "%{http_code}" -m 2 "$BASE_URL$route_path")
    
    if [ "$HTTP_CODE" == "401" ] || [ "$HTTP_CODE" == "403" ]; then
        echo "✅ SECURE ($HTTP_CODE Block)"
    elif [ "$HTTP_CODE" == "200" ] || [ "$HTTP_CODE" == "201" ] || [ "$HTTP_CODE" == "204" ]; then
        echo "🔓 PUBLIC / ALLOWED ($HTTP_CODE)"
    elif [ "$HTTP_CODE" == "404" ] || [ "$HTTP_CODE" == "400" ]; then
        echo "🚧 PARAMETERIZED ($HTTP_CODE)"
    elif [ "$HTTP_CODE" == "502" ]; then
        echo "🔴 OFFLINE / ISOLATED ($HTTP_CODE)"
    elif [ "$HTTP_CODE" == "000" ]; then
        echo "🔴 CLOUDFLARE TIMEOUT!"
    else
        echo "⚠️  UNKNOWN STATE ($HTTP_CODE)"
    fi

done

echo "========================================================="
echo "⚡ Quick Curl check complete!"

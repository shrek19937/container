export TOKEN=$(curl -s "https://auth.docker.io/token?service=registry.docker.io&scope=repository:library/busybox:pull" | jq -r ".token")

# getting the image Manifest
echo "manifest.json"
curl -s https://registry.hub.docker.com/v2/library/busybox/manifests/latest \
      -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
      -H "Authorization: Bearer $TOKEN"  \
      &> /dev/stdout | tee manifest.json | jq '.'

# getting the image config
config_hash=$(cat manifest.json | jq -r ".config.digest")
echo -e "\nconfig.json"
curl -s https://registry.hub.docker.com/v2/library/busybox/blobs/${config_hash} -H "Authorization: Bearer $TOKEN" -L | tee config.json | jq '.'

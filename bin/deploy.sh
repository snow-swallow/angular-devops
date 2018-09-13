echo "Start deployment..."
version=$(cat package.json|awk -F "[:]" '/version/{print $2}' | cut -d '"' -f 2)

docker stop test-base-url
docker rm -v test-base-url

docker run -it \
--name test-base-url \
-p 443:443 \
-v $PWD/bin/nginx.conf:/etc/nginx/nginx.conf \
-v $PWD/bin/bff.conf:/etc/nginx/bff.conf \
test-base-url:${version}

echo "Done deployment, exit."
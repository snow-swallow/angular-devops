#! /bin/bash
if [ $# -eq 0 ]; then
  echo "Please identify the build environment(local, dev, qa, stg or prod) first."
  exit 0;
fi

## environment name: local/dev/qa/stg/prod
env=$1
## project version
version=$(cat package.json|awk -F "[:]" '/version/{print $2}' | cut -d '"' -f 2)

## Install Project Dependency ##
npm install

## Build Angular Source Code ##
echo "Start the build (environment: ${env}, version: ${version})..."

npm run build
# shopt -s expand_aliases
# alias ngBuild="node --max_old_space_size=8192 ./node_modules/@angular/cli/bin/ng build"
# if [ ${env} == "dev" -o ${env} == "qa" ]
# then
#   ngBuild --sourcemaps --prod --environment ${env} --vendor-chunk true --deploy-url / --base-href /
# elif [ ${env} == "stg" -o ${env} == "prod" ]
# then
#   cp -f ./bin/conf/.angular-cli.json.prod .angular-cli.json
#   ngBuild --sourcemaps --prod --environment ${env} --vendor-chunk true --deploy-url /hello/xyz/ --base-href /hello/xyz/
#   cp ./dist/hello/xyz/index.prod.html ./dist/index.html
# else
#   ngBuild --sourcemaps --prod --environment local --vendor-chunk true --deploy-url / --base-href /
# fi
# unalias ngBuild

## Build Docker image ##
echo "Start building Docker image of test-base-url with version ${version}..."
docker build -t test-base-url:${version} .
# cp -f ./bin/conf/.angular-cli.json.default .angular-cli.json

echo "Done build (env: ${env}, version: ${version}), exit."
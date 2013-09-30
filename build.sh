#!/bin/bash
set -e

#export MODULES='intro unsupported zepto event ajax form outro'
export MODULES='intro unsupported zepto event detect fx ajax form outro'

SCRIPT_PATH=$0
SCRIPT_DIR=${SCRIPT_PATH%/*}
TEMP_GIT_DIR=${SCRIPT_DIR}/zepto-git
BUILD_TIME=$(date +"%Y-%m-%d %H:%M:%S %z")

echo "Building custom Zepto.js (${BUILD_TIME})"

if [ -d ${TEMP_GIT_DIR} ]; then
	echo ''
	echo "Removing old ${TEMP_GIT_DIR}..."
	rm -rf ${TEMP_GIT_DIR};
fi

echo ''
echo 'Verifying Node.js & NPM are installed...'
npm version

# install on Mac OS X via Homebrew
# if ! npm version; then
# 	brew update || brew doctor
# 	brew upgrade node || brew install node || brew link node
# 
# 	# NOTE: NPM seems to be back in Node 0.10.2
# 	npm version || (curl https://npmjs.org/install.sh | sh)
# fi

echo ''
echo "Cloning Zepto from github into ${TEMP_GIT_DIR}/..."

git clone https://github.com/madrobby/zepto.git ${TEMP_GIT_DIR} --depth 1

echo ''
echo 'Adding conditional loading wrapper...'

cp ${SCRIPT_DIR}/src/unsupported.js ${TEMP_GIT_DIR}/src/
echo '(function(document, window){' > ${TEMP_GIT_DIR}/src/intro.js
echo '})(document, window);' > ${TEMP_GIT_DIR}/src/outro.js

pushd ${TEMP_GIT_DIR}

echo ''
echo 'Setting up custom build...'

npm install
npm run-script dist

popd

echo ''
echo 'Copying locally and removing repo...'

# adding version info here since Zepto build wants to strip it
cat ${SCRIPT_DIR}/src/version.js ${TEMP_GIT_DIR}/dist/zepto.js > ${SCRIPT_DIR}/zepto.js
cp ${TEMP_GIT_DIR}/dist/zepto.min.js ${SCRIPT_DIR}/zepto.min.js

rm -rf ${TEMP_GIT_DIR}

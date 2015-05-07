#!/bin/bash

cd /home/unbuild-app
meteor build --directory /home/build-app

cd /home/build-app/bundle/programs/server/
npm i

mv /home/build-app/bundle /home/app

# cleanup
#rm -rf /app
#rm -rf /tmp/the-app
#rm -rf ~/.meteor
#rm /usr/local/bin/meteor

#! /bin/bash
PWD=`pwd`

# install deps for this example
cd ./examples/angular-1/confirm-unsaved
npm install

cd $PWD

function killServer {
  kill $serverPid
}

gulp build
gulp serve &
serverPid=$!

trap killServer EXIT

SAUCE_ACCESS_KEY=`echo $SAUCE_ACCESS_KEY | rev`

karma start --sauce &
karma start karma.es5.conf.js --sauce &
protractor protractor.travis.conf.js &
wait %2 %3 %4

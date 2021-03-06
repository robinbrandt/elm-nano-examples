#!/bin/sh

touch tmp/build.log
elm make src/Main.elm --output=elm.js --report=json 2> tmp/build.log
ERRORS=`cat tmp/build.log`
if [ -n "$ERRORS" ]; then
  echo "Comiled with errors"
  VALUE=`date -r tmp/build.log`
  printf "refresh('" > tmp/timestamp.js
  printf "$VALUE" >>  tmp/timestamp.js
  printf "', " >>  tmp/timestamp.js
  cat tmp/build.log >> tmp/timestamp.js
  printf ");" >> tmp/timestamp.js
else
  echo "Compiled without errors"
  VALUE=`date -r elm.js`
  TIMESTAMP_JS_TEMPLATE="refresh('${VALUE}')"
  INTERPOLATED=`echo "${TIMESTAMP_JS_TEMPLATE}" | sed "s/VALUE/${VALUE}/" | sed "s/ERROR//" `
  echo "$INTERPOLATED" > tmp/timestamp.js
fi
#sleep 1


#!/bin/bash
set -euo pipefail

rm -rf tempdir
mkdir tempdir
cp -r WebApplicationTest/* tempdir/.

cd tempdir || exit
docker image build --tag testnetapplication .
docker run -t -d -p 5050:5050 --name testapp testnetapplication
docker ps -a

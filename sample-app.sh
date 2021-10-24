#!/bin/bash
set -euo pipefail

docker image build --tag testnetapplication .
docker run -t -d -p 5050:5050 --name testapp testnetapplication
docker ps -a

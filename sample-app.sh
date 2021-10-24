#!/bin/bash
set -euo pipefail

docker build -t dotnetapplication .
docker run -t -d -p 5050:5050 --name test dotnetapp dotnetapplication
docker ps -a

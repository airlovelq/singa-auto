#!/usr/bin/env bash
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

LOG_FILE_PATH=$PWD/$LOGS_DIR_PATH/start_zookeeper.log

source ./scripts/docker_swarm/utils.sh

title "Starting SINGA-Auto's Zookeeper..."

# docker container run flags info:
# --rm: container is removed when it exits
# (--rm will also remove anonymous volumes)
# -v == --volume: shared filesystems
# -e == --env: environment variable
# --name: name used to identify the container
# --network: default is docker bridge
# -p: expose and map port(s)

(docker run --rm --name $ZOOKEEPER_HOST \
  --network $DOCKER_NETWORK \
  -p $ZOOKEEPER_EXT_PORT:$ZOOKEEPER_PORT \
  -d $IMAGE_ZOOKEEPER \
  &> $LOG_FILE_PATH) &
ensure_stable "SINGA-Auto's Zookeeper" $LOG_FILE_PATH 5


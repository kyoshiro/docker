#!/bin/bash
export BASE_PATH=/srv/docker/data

start_gitlab_runner() {
	local GITLAB_RUNNER_NAME="$1"

	echo "Starting gitlab-runner $GITLAB_RUNNER_NAME"

	docker run -d --name $GITLAB_RUNNER_NAME --restart always \
         -v $BASE_PATH/$GITLAB_RUNNER_NAME/config:/etc/gitlab-runner \
         -v $BASE_PATH/$GITLAB_RUNNER_NAME/certs:/etc/gitlab-runner/certs \
         -v /var/run/docker.sock:/var/run/docker.sock \
         gitlab/gitlab-runner:alpine
}

start_gitlab_runner $*

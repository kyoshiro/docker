#!/bin/bash
export BASE_PATH=/srv/containers/data

start_gitlab_runner() {
	local GITLAB_RUNNER_NAME="$1"

	echo "Starting gitlab-runner $GITLAB_RUNNER_NAME"

	podman run -d --name $GITLAB_RUNNER_NAME --restart always \
	 --add-host gitlab.iot.intern:172.16.1.226 \
         -v $BASE_PATH/$GITLAB_RUNNER_NAME/config:/etc/gitlab-runner \
         -v $BASE_PATH/$GITLAB_RUNNER_NAME/certs:/etc/gitlab-runner/certs \
         -v /run/user/1001/podman/podman.sock:/run/podman/podman.sock \
         gitlab/gitlab-runner:alpine
}

start_gitlab_runner $*

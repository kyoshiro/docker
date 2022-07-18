#!/bin/bash
export BASE_PATH=/srv/docker/data

register_gitlab_runner() {
	local GITLAB_RUNNER_NAME="$1" REGISTRATION_TOKEN="$2" GITLAB_SERVER="$3"

	echo "Registering gitlab-runner $GITLAB_RUNNER_NAME"
	echo "with token $REGISTRATION_TOKEN"

	docker run --rm -t -i \
	 -v $BASE_PATH/$GITLAB_RUNNER_NAME/certs:/etc/gitlab-runner/certs \
	 -v $BASE_PATH/$GITLAB_RUNNER_NAME/config:/etc/gitlab-runner \
	 gitlab/gitlab-runner register \
	 --non-interactive \
	 --tls-ca-file="/etc/gitlab-runner/certs/ca.crt" \
	 --executor "docker" \
	 --docker-image alpine:latest \
	 --url "https://$GITLAB_SERVER/" \
	 --registration-token "$REGISTRATION_TOKEN" \
	 --description "$GITLAB_RUNNER_NAME" \
	 --maintenance-note "$GITLAB_SERVER - default runner" \
	 --tag-list "docker,puppet,terraform" \
	 --run-untagged="true" \
	 --locked="false" \
	 --access-level="not_protected"
}

register_gitlab_runner $*

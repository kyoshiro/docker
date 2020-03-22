#!/bin/bash

NEXTCLOUD_DB_PWD="$(cat ./nextcloud_db_pwd)"

if [ -z "$NEXTCLOUD_PWD" ]; then
	echo "Please set environment variable NEXTCLOUD_DB_PWD to continue"
	exit 1
fi

docker exec nextcloud-db /usr/bin/mysqldump -u root --password="$NEXTCLOUD_DB_PWD" nextcloud | gzip -9 > nextcloud-backup.sql.gz

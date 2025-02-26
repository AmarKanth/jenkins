#/bin/bash

DATE=$(date +%H-%M-%S)
DB_HOST=$1
DB_PASSWORD=$2
DB_NAME=$3
AWS_SECRET_ACCESS_KEY=$4

mysqldump --column-statistics=0 -u root -h $DB_HOST -p$DB_PASSWORD $DB_NAME > /tmp/db-$DATE.sql

export AWS_ACCESS_KEY_ID=AKIAQ3EGRHGLUNOQNF7L
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY

echo "Uploading your backup..."

aws s3 cp /tmp/db-$DATE.sql s3://jenkins-mysql-aws/db-$DATE.sql
#!/usr/bin/env bash

DB_BACKUP_PATH=/data/
CURRENT_DATE=$(date +%F_%T)
echo "Dump mysql db for $DB_NAME... "
mysql --version
mysqldump -h "$DB_HOST" -u $DB_USER -p"$DB_PASS" $DB_NAME --verbose > $DB_BACKUP_PATH/$DB_NAME-$CURRENT_DATE.sql

echo "🚧 Uploading mysql dump ($DB_NAME-$CURRENT_DATE.sql) to s3 ..."
aws s3 --endpoint=https://$S3_URL cp $DB_BACKUP_PATH/$DB_NAME-$CURRENT_DATE.sql s3://${S3_BUCKET}/db/

echo "✅ Backup finished successfully"

deleted="false"
echo "⚠️ Check for files older than 7 days ..."

cd /data
currentDate=$(date +%s)
aws s3 --endpoint=https://$S3_URL ls $DB_NAME/db/ | while read -r line;
do
fileName=$(echo $line | awk '{print $4}')
createdAt=`echo $line|awk {'print $1" "$2'}`
createdAt=$(date -d"$createdAt" +%s)
olderThan=$(($currentDate-604800))

if [[ $createdAt -lt $olderThan ]]
then
 deleted="true"
 echo "🚨 Deleting file $fileName"
 aws s3 --endpoint=https://$S3_URL rm s3://${S3_BUCKET}/db/$fileName
fi;
done

if [[ $deleted == "false" ]]
then
  echo "✅ Nothing to delete"
fi

echo "👋 Bye"


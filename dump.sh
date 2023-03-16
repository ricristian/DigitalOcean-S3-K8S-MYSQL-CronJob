#!/usr/bin/env bash
DB_BACKUP_PATH=/data/
CURRENT_DATE=$(date +%F_%T)
echo "Dump mysql db for $DB_NAME... "
mysql --version

if test -n "${ONLY_TABLE-}"; then
 echo "🚧 Creating backup only for table $ONLY_TABLE"
 SQL="SET group_concat_max_len = 10240;"
 SQL="${SQL} SELECT GROUP_CONCAT(table_name separator ' ')"
 SQL="${SQL} FROM information_schema.tables WHERE table_schema='${DB_NAME}'"
 SQL="${SQL} AND table_name LIKE '$ONLY_TABLE'"
 echo $SQL
 TBLIST=`mysql -h "$DB_HOST" -u $DB_USER -p"$DB_PASS" -AN -e"${SQL}"`
 
 mysqldump -h "$DB_HOST" -u $DB_USER -p"$DB_PASS" $DB_NAME $TBLIST --verbose > $DB_BACKUP_PATH/$DB_NAME-$CURRENT_DATE.sql
elif [[ "${IGNORE_TABLE}" ]]; then
 echo "🚧 Ignoring table $IGNORE_TABLE"
 mysqldump -h "$DB_HOST" -u $DB_USER -p"$DB_PASS" $DB_NAME --ignore-table $DB_NAME.$IGNORE_TABLE --verbose > $DB_BACKUP_PATH/$DB_NAME-$CURRENT_DATE.sql
else
 echo "✅Creating backup for entire database"
 mysqldump -h "$DB_HOST" -u $DB_USER -p"$DB_PASS" $DB_NAME --verbose > $DB_BACKUP_PATH/$DB_NAME-$CURRENT_DATE.sql
fi


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
olderThan=$(($currentDate-7776000))

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

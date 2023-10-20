

#!/bin/bash



# Set variables

CONFIG_FILE="${PATH_TO_KAFKA_CONFIG_FILE}"

NEW_RETENTION_SIZE="${NEW_RETENTION_SIZE}"



# Backup the original configuration file

cp $CONFIG_FILE $CONFIG_FILE.bak



# Modify the retention size for the specified topic

sed -i "s/^retention..bytes=.*/retention..bytes=$NEW_RETENTION_SIZE/g" $CONFIG_FILE



# Restart Kafka to apply the changes

systemctl restart kafka



echo "Retention size for Kafka topic $TOPIC_NAME has been increased to $NEW_RETENTION_SIZE."
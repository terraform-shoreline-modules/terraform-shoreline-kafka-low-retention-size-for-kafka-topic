

#!/bin/bash



# Set variables

KAFKA_HOME=${PATH_TO_KAFKA_HOME}

TOPIC_NAME=${NAME_OF_THE_KAFKA_TOPIC}

NEW_RETENTION_SIZE=${NEW_RETENTION_SIZE_IN_MS}



# Increase the retention size of the Kafka topic

${KAFKA_HOME}/bin/kafka-topics.sh --zookeeper ${ZOOKEEPER_SERVER}:${ZOOKEEPER_PORT} \

--alter --topic ${TOPIC_NAME} --config retention.ms=${NEW_RETENTION_SIZE}



# Check if the retention size has been updated successfully

${KAFKA_HOME}/bin/kafka-topics.sh --zookeeper ${ZOOKEEPER_SERVER}:${ZOOKEEPER_PORT} \

--describe --topic ${TOPIC_NAME} | grep retention.ms
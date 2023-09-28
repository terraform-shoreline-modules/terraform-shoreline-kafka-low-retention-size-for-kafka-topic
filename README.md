
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Low Retention Size for Kafka Topic.
---

This incident type refers to a situation where the retention size assigned to a Kafka topic is too low. Retention size is the duration for which the messages in a Kafka topic are retained. When the retention size is too low, it can cause the messages to be deleted from the topic before they can be consumed by the intended consumers. This can lead to data loss and disrupt the normal functioning of the application. It is important to set an appropriate retention size for each Kafka topic based on the requirements of the application.

### Parameters
```shell
export ZOOKEEPER_HOST_PORT="PLACEHOLDER"

export TOPIC_NAME="PLACEHOLDER"

export NEW_RETENTION_SIZE="PLACEHOLDER"

export BROKER_HOST_PORT="PLACEHOLDER"

export CONSUMER_GROUP_NAME="PLACEHOLDER"

export PATH_TO_KAFKA_DATA_DIRECTORY="PLACEHOLDER"

export PATH_TO_KAFKA_HOME="PLACEHOLDER"

export NEW_RETENTION_SIZE_IN_MS="PLACEHOLDER"

export ZOOKEEPER_PORT="PLACEHOLDER"

export NAME_OF_THE_KAFKA_TOPIC="PLACEHOLDER"

export ZOOKEEPER_SERVER="PLACEHOLDER"
```

## Debug

### 1. List all Kafka topics
```shell
kafka-topics --zookeeper ${ZOOKEEPER_HOST_PORT} --list
```

### 2. Get the retention size of a Kafka topic
```shell
kafka-configs --zookeeper ${ZOOKEEPER_HOST_PORT} --describe --entity-type topics --entity-name ${TOPIC_NAME} | grep retention.ms
```

### 4. Check if there are any consumers in a consumer group that are lagging behind
```shell
kafka-consumer-groups --bootstrap-server ${BROKER_HOST_PORT} --describe --group ${CONSUMER_GROUP_NAME}
```

### 5. Check the log size of a Kafka topic
```shell
kafka-run-class kafka.tools.GetOffsetShell --broker-list ${BROKER_HOST_PORT} --topic ${TOPIC_NAME} --time -1 --offsets 1 | awk -F ':' '{sum += $3} END {print sum}'
```

### 6. Check the disk space usage of the Kafka brokers
```shell
df -h ${PATH_TO_KAFKA_DATA_DIRECTORY}
```

## Repair

### Increase the retention size of the Kafka topic to prevent data loss and ensure that messages are retained for the required duration.
```shell


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


```
resource "shoreline_notebook" "low_retention_size_for_kafka_topic" {
  name       = "low_retention_size_for_kafka_topic"
  data       = file("${path.module}/data/low_retention_size_for_kafka_topic.json")
  depends_on = [shoreline_action.invoke_increase_kafka_topic_retention_size]
}

resource "shoreline_file" "increase_kafka_topic_retention_size" {
  name             = "increase_kafka_topic_retention_size"
  input_file       = "${path.module}/data/increase_kafka_topic_retention_size.sh"
  md5              = filemd5("${path.module}/data/increase_kafka_topic_retention_size.sh")
  description      = "Increase the retention size of the Kafka topic to prevent data loss and ensure that messages are retained for the required duration."
  destination_path = "/agent/scripts/increase_kafka_topic_retention_size.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_increase_kafka_topic_retention_size" {
  name        = "invoke_increase_kafka_topic_retention_size"
  description = "Increase the retention size of the Kafka topic to prevent data loss and ensure that messages are retained for the required duration."
  command     = "`chmod +x /agent/scripts/increase_kafka_topic_retention_size.sh && /agent/scripts/increase_kafka_topic_retention_size.sh`"
  params      = ["NEW_RETENTION_SIZE_IN_MS","PATH_TO_KAFKA_HOME","ZOOKEEPER_SERVER","TOPIC_NAME","ZOOKEEPER_PORT","NEW_RETENTION_SIZE","NAME_OF_THE_KAFKA_TOPIC"]
  file_deps   = ["increase_kafka_topic_retention_size"]
  enabled     = true
  depends_on  = [shoreline_file.increase_kafka_topic_retention_size]
}


terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "low_retention_size_for_kafka_topic" {
  source    = "./modules/low_retention_size_for_kafka_topic"

  providers = {
    shoreline = shoreline
  }
}
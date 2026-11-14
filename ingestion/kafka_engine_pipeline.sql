-- Kafka Streaming Ingestion with DLQ Pattern
CREATE TABLE IF NOT EXISTS kafka_telemetry_queue (
    raw_payload String
)
ENGINE = Kafka
SETTINGS
    kafka_broker_list = 'kafka:9092',
    kafka_topic_list = 'telemetry-events-prod',
    kafka_group_name = 'ch-telemetry-consumer-v1',
    kafka_format = 'LineAsString',
    kafka_num_consumers = 4,
    kafka_max_block_size = 65536;

CREATE TABLE IF NOT EXISTS telemetry_dead_letter_queue (
    ingest_time DateTime DEFAULT now(),
    error_reason String,
    raw_payload String
)
ENGINE = MergeTree()
ORDER BY ingest_time
TTL ingest_time + INTERVAL 30 DAY;

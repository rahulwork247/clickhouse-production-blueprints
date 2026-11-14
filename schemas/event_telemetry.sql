-- Production High-Throughput Telemetry Schema
CREATE TABLE IF NOT EXISTS event_telemetry (
    event_date Date DEFAULT toDate(timestamp),
    timestamp DateTime64(3, 'UTC') CODEC(DoubleDelta, ZSTD(1)),
    tenant_id LowCardinality(String),
    event_id UUID DEFAULT generateUUIDv4(),
    user_id String CODEC(ZSTD(3)),
    event_name LowCardinality(String),
    platform LowCardinality(String),
    app_version LowCardinality(String),
    duration_ms UInt32 CODEC(T64, ZSTD(1)),
    payload String CODEC(ZSTD(6)),
    version UInt32
)
ENGINE = ReplacingMergeTree(version)
PARTITION BY toYYYYMM(event_date)
PRIMARY KEY (tenant_id, event_name)
ORDER BY (tenant_id, event_name, toStartOfHour(timestamp), user_id, event_id)
TTL event_date + INTERVAL 180 DAY DELETE
SETTINGS index_granularity = 8192, ttl_only_drop_parts = 1;

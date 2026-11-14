-- Real-Time Metric & Financial Rollups
CREATE TABLE IF NOT EXISTS metric_hourly_aggregates (
    tenant_id LowCardinality(String),
    metric_name LowCardinality(String),
    window_start DateTime CODEC(DoubleDelta, ZSTD(1)),
    total_events UInt64,
    total_duration_ms UInt64,
    active_users AggregateFunction(uniq, String),
    latency_quantiles AggregateFunction(quantiles(0.5, 0.95, 0.99), UInt32)
)
ENGINE = AggregatingMergeTree()
PARTITION BY toYYYYMM(window_start)
PRIMARY KEY (tenant_id, metric_name)
ORDER BY (tenant_id, metric_name, window_start)
TTL window_start + INTERVAL 730 DAY;

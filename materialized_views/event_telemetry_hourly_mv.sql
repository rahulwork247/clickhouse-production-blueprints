-- Automated Streaming Rollup Pipeline
CREATE MATERIALIZED VIEW IF NOT EXISTS event_telemetry_hourly_mv
TO metric_hourly_aggregates AS
SELECT
    tenant_id,
    event_name AS metric_name,
    toStartOfHour(timestamp) AS window_start,
    count() AS total_events,
    sum(duration_ms) AS total_duration_ms,
    uniqState(user_id) AS active_users,
    quantilesState(0.5, 0.95, 0.99)(duration_ms) AS latency_quantiles
FROM event_telemetry
GROUP BY tenant_id, metric_name, window_start;

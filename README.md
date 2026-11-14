# ClickHouse Production Analytics & Real-Time Data Mart Blueprints

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Support / Buy Me a Coffee](https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-yellow.svg)](https://buymeacoffee.com/rahulwork247)

Production-grade schemas, materialized view aggregation pipelines, Kafka streaming connectors, and compression optimization blueprints for ClickHouse.

```mermaid
flowchart LR
    A[Event Producers] -->|JSON Stream| B(Kafka Topic)
    B -->|Kafka Engine| C[ClickHouse Kafka Ingest Queue]
    C -->|Materialized View| D[(event_telemetry Raw Storage)]
    C -->|Materialized View| E[(metric_hourly_aggregates AggregatingMergeTree)]
    D -.->|TTL 180d| F[Cold S3 Storage Tier]
    E -->|Sub-10ms Queries| G[Grafana / Superset Analytics Dashboard]
```

## Repository Contents
- `schemas/`: Optimized `ReplacingMergeTree` & `AggregatingMergeTree` tables with ZSTD and DoubleDelta codecs.
- `materialized_views/`: Real-time aggregations computing quantiles, distinct users, and throughput.
- `ingestion/`: Kafka streaming engine integration with Dead Letter Queue (DLQ) support.
- `optimizations/`: Cold-storage tiered policies and compaction tuning.
- `docker/`: ClickHouse + ClickHouse Keeper multi-node local staging setup.
- `benchmarks/`: Synthetic analytical data generator.

## Enterprise Production Bundle
Looking for Grafana production dashboards, automated `clickhouse-backup` disaster recovery recipes, and enterprise multi-tenant RBAC policies?
Download the complete Enterprise Pack directly from the Releases tab or support continued development via [Buy Me a Coffee](https://buymeacoffee.com/rahulwork247).

## License
MIT License - Copyright (c) 2026.

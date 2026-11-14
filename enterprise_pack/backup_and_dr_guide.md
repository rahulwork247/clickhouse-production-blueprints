# Production Backup & Recovery Runbook for ClickHouse

## 1. Automated Snapshots via clickhouse-backup
```bash
# Trigger incremental backup on local cluster
clickhouse-backup create_remote full_backup_$(date +%Y%m%d%H%M%S)
```

## 2. Point-in-Time Partition Restoration
```sql
ALTER TABLE event_telemetry ATTACH PARTITION 202611 FROM BACKUP;
```

## 3. High-Availability Zero-Downtime Migration Checklist
- [x] Configure ReplicatedMergeTree with ClickHouse Keeper quorum
- [x] Enforce distributed_product_mode = 'local'
- [x] Set max_execution_time = 30 and max_memory_usage = 10000000000

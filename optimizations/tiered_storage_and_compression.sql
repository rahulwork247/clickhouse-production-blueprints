-- Tiered Storage & Column-Level Compression Blueprint
-- Apply DoubleDelta + ZSTD to monotonic counters and timestamp keys
-- Multi-volume storage strategy: Hot NVMe SSD -> Warm EBS/Attached HDD -> Cold S3/GCS Object Store

ALTER TABLE event_telemetry
    MODIFY COLUMN payload CODEC(ZSTD(7));

-- Example Tiered Policy (configured in storage_configuration XML):
-- <storage_configuration>
--     <disks>
--         <s3_cold><type>s3</type><endpoint>https://bucket.s3.amazonaws.com/ch/</endpoint></s3_cold>
--     </disks>
--     <policies>
--         <tiered>
--             <volumes>
--                 <hot><disk>default</disk><max_data_part_size_bytes>10737418240</max_data_part_size_bytes></hot>
--                 <cold><disk>s3_cold</disk></cold>
--             </volumes>
--             <move_factor>0.2</move_factor>
--         </tiered>
--     </policies>
-- </storage_configuration>

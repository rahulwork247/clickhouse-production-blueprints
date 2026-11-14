#!/usr/bin/env python3
"""
Synthetic Benchmark Generator & Index Verification for ClickHouse Schemas.
Generates realistic analytical workloads and evaluates aggregation query performance.
"""
import time
import random
import uuid
from datetime import datetime, timedelta

def generate_synthetic_batch(batch_size=5000):
    tenants = ['tenant_alpha', 'tenant_beta', 'tenant_gamma', 'tenant_delta']
    events = ['page_view', 'checkout_completed', 'api_request', 'button_click', 'session_start']
    platforms = ['web', 'ios', 'android', 'backend']
    
    base_time = datetime.utcnow()
    records = []
    for _ in range(batch_size):
        ts = base_time - timedelta(seconds=random.randint(0, 86400 * 7))
        records.append({
            'event_date': ts.strftime('%Y-%m-%d'),
            'timestamp': ts.strftime('%Y-%m-%d %H:%M:%S.%f')[:-3],
            'tenant_id': random.choice(tenants),
            'event_id': str(uuid.uuid4()),
            'user_id': f'usr_{random.randint(1000, 99999)}',
            'event_name': random.choice(events),
            'platform': random.choice(platforms),
            'duration_ms': int(random.expovariate(1/45.0)),
            'version': 1
        })
    return records

if __name__ == '__main__':
    start = time.time()
    data = generate_synthetic_batch(10000)
    elapsed = time.time() - start
    print(f'Generated {len(data)} synthetic records in {elapsed:.3f}s.')

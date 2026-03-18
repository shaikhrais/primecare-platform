import React, { useState } from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from H20-IoTMonitoring.tsx ---
// ================================================================
// PAGE IDENTITY: H20 · IoT & Wearable Monitoring — Smart Care
// Type: Hub | Owner: manager | Registry: H26
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import type { TableColumn } from '@/shared/components/sections';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

const devices = [
    { id: 'iot-001', client: 'Margaret Chen', device: 'Fall Sensor', battery: '87%', status: 'ACTIVE', signal: 'strong', lastPing: '2 min ago', alerts: '0' },
    { id: 'iot-002', client: 'Robert Davies', device: 'BP Monitor', battery: '62%', status: 'ACTIVE', signal: 'good', lastPing: '8 min ago', alerts: '1' },
    { id: 'iot-003', client: 'Helen Kowalski', device: 'Glucose Monitor', battery: '45%', status: 'WARNING', signal: 'weak', lastPing: '23 min ago', alerts: '2' },
    { id: 'iot-004', client: 'James Morrison', device: 'Motion Sensor', battery: '92%', status: 'ACTIVE', signal: 'strong', lastPing: '1 min ago', alerts: '0' },
    { id: 'iot-005', client: 'Yuki Tanaka', device: 'Med Dispenser', battery: '15%', status: 'CRITICAL', signal: 'weak', lastPing: '45 min ago', alerts: '3' },
    { id: 'iot-006', client: 'Sarah O\'Malley', device: 'Smart Bed', battery: '78%', status: 'ACTIVE', signal: 'good', lastPing: '5 min ago', alerts: '0' },
];

export function IoTMonitoring() {
    const [tab, setTab] = useState('overview');

    return (
        <PageTemplate
            pageId="H26"
            title="📡 IoT & Wearable Monitoring"
            subtitle="Real-time health device monitoring, alerts & predictive insights"
            actionPageId="manager.iot-monitoring"
            sectionData={PageSectionRegistry['H26']}
        />
    );
}

import React, { useState } from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from H23-FranchiseManagement.tsx ---
// ================================================================
// PAGE IDENTITY: H23 · Franchise Management — Multi-Location Operations
// Type: Hub | Owner: admin | Registry: H30
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import type { TableColumn } from '@/shared/components/sections';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

const locations = [
    { name: '📍 PrimeCare Toronto — Downtown', manager: 'Sarah Chen', psws: 24, clients: 67, revenue: '$142K', growth: '+12%', status: 'ACTIVE' },
    { name: '📍 PrimeCare Toronto — North York', manager: 'James Wilson', psws: 18, clients: 45, revenue: '$98K', growth: '+8%', status: 'ACTIVE' },
    { name: '📍 PrimeCare Mississauga', manager: 'Maria Santos', psws: 15, clients: 38, revenue: '$82K', growth: '+15%', status: 'ACTIVE' },
    { name: '📍 PrimeCare Ottawa', manager: 'Kevin O\'Brien', psws: 12, clients: 28, revenue: '$64K', growth: '+5%', status: 'ACTIVE' },
    { name: '📍 PrimeCare Vancouver', manager: 'Yuki Tanaka', psws: 8, clients: 15, revenue: '$32K', growth: '+22%', status: 'LAUNCHING' },
    { name: '📍 PrimeCare Calgary', manager: 'TBD', psws: 0, clients: 0, revenue: '—', growth: '—', status: 'PLANNED' },
];

const locationCols: TableColumn[] = [
    { key: 'name', label: 'Location' }, { key: 'manager', label: 'Manager' },
    { key: 'psws', label: 'PSWs' }, { key: 'clients', label: 'Clients' },
    { key: 'revenue', label: 'Revenue' }, { key: 'growth', label: 'Growth' },
    { key: 'status', label: 'Status' },
];

const expansion = [
    { name: '📍 Calgary, AB', description: 'Pop: 1.4M • Demand: High • Target: Q3 2026', progress: 65, badge: 'Q3 2026' },
    { name: '📍 Edmonton, AB', description: 'Pop: 1.0M • Demand: Medium • Target: Q4 2026', progress: 30, badge: 'Q4 2026' },
    { name: '📍 Winnipeg, MB', description: 'Pop: 750K • Demand: Medium • Target: Q1 2027', progress: 15, badge: 'Q1 2027' },
    { name: '📍 Montreal, QC', description: 'Pop: 1.8M • Demand: Very High • Target: Q2 2027', progress: 10, badge: 'Q2 2027' },
];

export function FranchiseManagement() {
    const [tab, setTab] = useState('locations');

    const tabContent: Record<string, Record<string, any>> = {
        locations: { 'H30.location-table': { table: { columns: locationCols, rows: locations } } },
        expansion: { 'H30.expansion': { progressList: { items: expansion } } },
    };

    return (
        <PageTemplate
            pageId="H30"
            title="🏢 Franchise Management"
            subtitle="Multi-location operations, performance benchmarking & expansion planning"
            actionPageId="admin.franchise"
            sectionData={PageSectionRegistry['H30']}
        />
    );
}

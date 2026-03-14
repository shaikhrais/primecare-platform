// ================================================================
// PAGE IDENTITY: T46 — Compliance Monitor
// Type: Tool | Owner: staff
// ================================================================
import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry, ApiRegistry } from 'prime-care-shared';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';
import { CorePieChart } from '@/shared/components/charts/core';
import './ComplianceMonitor.css';

const { ContentRegistry, ButtonRegistry } = AdminRegistry;
const { MANAGER_COMPLIANCE } = ContentRegistry;

interface ComplianceItem {
    id: string;
    staffName: string;
    document: string;
    expiry: string;
    status: 'compliant' | 'warning' | 'expired' | 'active' | 'expiring' | 'missing';
}

// Fallback mock data when API unavailable
const FALLBACK_ITEMS: ComplianceItem[] = [
    { id: '1', staffName: 'Sarah Jenkins', document: 'CPR Level C', expiry: '2026-12-15', status: 'active' },
    { id: '2', staffName: 'Michael Chen', document: 'Vulnerable Sector Screen', expiry: '2026-03-20', status: 'expiring' },
    { id: '3', staffName: 'Elena Rodriguez', document: 'Clinical License', expiry: '2026-02-10', status: 'missing' },
    { id: '4', staffName: 'David Kim', document: 'WHMIS Training', expiry: '2028-05-01', status: 'active' },
];

export default function ComplianceMonitor() {
    const { t } = useTranslation();

    // TanStack Query: auto-cached compliance data
    const { data: items = FALLBACK_ITEMS } = useRegistryQuery<ComplianceItem[]>(ApiRegistry.TENANCY.STAFF.COMPLIANCE_SCAN, {
        queryKey: ['staff', 'compliance'],
        staleTime: 60_000,
        placeholderData: FALLBACK_ITEMS,
    });

    const displayItems = items.length > 0 ? items : FALLBACK_ITEMS;

    const stats = [
        { name: 'Compliant', value: 85, color: '#10b981' },
        { name: 'Warning', value: 10, color: '#f59e0b' },
        { name: 'Expired', value: 5, color: '#ef4444' },
    ];

    return (
        <div data-cy="page.container" className="compliance-monitor">
            <header className="compliance-header">
                <h1 data-cy="page.title">{t(ContentRegistry.MANAGER_COMPLIANCE.TITLE)}</h1>
                <p className="text-lg font-medium text-muted-foreground">{t(ContentRegistry.MANAGER_COMPLIANCE.SUBTITLE)}</p>
            </header>

            <div className="compliance-bento">
                <div className="compliance-card highlight">
                    <div>
                        <span className="compliance-label">Clinical Integrity</span>
                        <div className="h-32 mt-4">
                            <CorePieChart data={stats} dataKey="value" nameKey="name" colors={stats.map(s => s.color)} />
                        </div>
                    </div>
                    <div className="text-xs font-black uppercase tracking-widest opacity-60 mt-4">
                        Branch Audit: 98.4% Secure
                    </div>
                </div>

                <div className="compliance-card">
                    <div>
                        <span className="compliance-label">Expiring Soon</span>
                        <div className="compliance-value text-amber-500 mt-2">4</div>
                    </div>
                    <p className="text-xs font-semibold text-muted-foreground">Requirements due within 30 days.</p>
                </div>

                <div className="compliance-card">
                    <div>
                        <span className="compliance-label">Missing Records</span>
                        <div className="compliance-value text-red-500 mt-2">12</div>
                    </div>
                    <p className="text-xs font-semibold text-muted-foreground">Critical gaps in personnel files.</p>
                </div>

                <div className="compliance-card" style={{ gridColumn: 'span 2' }}>
                    <div>
                        <span className="compliance-label">Audit History</span>
                        <div className="text-xl font-black mt-2">Last Audit: 48 Hours Ago</div>
                    </div>
                    <div className="flex gap-2 mt-4">
                        <div className="w-full h-2 bg-slate-100 rounded-full overflow-hidden">
                            <div className="w-[98%] h-full bg-primary"></div>
                        </div>
                    </div>
                </div>
            </div>

            <section className="compliance-list-section">
                <header className="compliance-list-header">
                    <h3 data-cy="h3-staff.compliance-monitor-0" className="text-xl font-black uppercase tracking-tight">Requirement Inventory</h3>
                    <button data-cy="btn-staff.compliance-monitor-0" className="btn-modern btn-modern-primary">{t(ContentRegistry.MANAGER_COMPLIANCE.MESSAGES.SYNC_SUCCESS).split(' ')[0]} Audit Sync</button>
                </header>

                <div className="compliance-list">
                    {displayItems.map(item => (
                        <div key={item.id} className="compliance-item">
                            <div className="item-info">
                                <h4>{item.staffName}</h4>
                                <p>{item.document} • Expiry: {item.expiry}</p>
                            </div>
                            <span className={`status-badge status-${item.status}`}>
                                {item.status}
                            </span>
                        </div>
                    ))}
                </div>
            </section>
        </div>
    );
}

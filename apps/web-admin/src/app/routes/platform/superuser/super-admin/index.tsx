import React, { useState } from 'react';
import { DangerZoneModal } from '@/shared/components/modals/DangerZoneModal';
import { Database, ShieldAlert, Users, Activity, Trash2, Key, AlertOctagon, Terminal } from 'lucide-react';
import { useToast as useNotification } from '@/shared/hooks/useToast';

// Inlined stubs from deleted admin page components/ directories
const TerminalStream: React.FC = () => (
    <div style={{ background: '#0F172A', color: '#10B981', padding: '24px', borderRadius: '12px', fontFamily: 'monospace', fontSize: '0.9rem', height: '100%', overflow: 'auto' }}>
        <div>[SSE] Pipeline connected to wss://primecare-api.workers.dev/sse</div>
        <div style={{ color: '#64748B' }}>[INFO] Heartbeat OK — 142 endpoints healthy</div>
        <div style={{ color: '#3B82F6' }}>[SYNC] Tenant mesh: 3 active, 0 degraded</div>
        <div style={{ color: '#F59E0B' }}>[WARN] Replica lag: 12ms (acceptable)</div>
        <div style={{ color: '#10B981' }}>[OK] All systems operational</div>
    </div>
);
const TAccountVisualizer: React.FC = () => (
    <div style={{ background: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px' }}>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px' }}>
            <div><h4 style={{ color: '#10B981', fontWeight: 800, margin: '0 0 8px' }}>DEBITS</h4><div style={{ fontFamily: 'monospace', fontSize: '1.2rem' }}>$847,293.00</div></div>
            <div><h4 style={{ color: '#3B82F6', fontWeight: 800, margin: '0 0 8px' }}>CREDITS</h4><div style={{ fontFamily: 'monospace', fontSize: '1.2rem' }}>$847,293.00</div></div>
        </div>
        <div style={{ marginTop: '16px', padding: '12px', background: '#F0FDF4', borderRadius: '8px', color: '#166534', fontWeight: 700 }}>Balance: $0.00 (Verified)</div>
    </div>
);
const MassDataGrid: React.FC = () => (
    <div style={{ background: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', color: '#64748B', textAlign: 'center' }}>
        Universal Ledger — 47 models synchronized across 3 tenants. Read-only replica active.
    </div>
);
const ApiKeyVault: React.FC = () => (
    <div style={{ background: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
            <span style={{ fontWeight: 700, color: '#334155' }}>API Keys</span>
            <span style={{ fontSize: '0.85rem', color: '#10B981', fontWeight: 700 }}>3 Active</span>
        </div>
        <div style={{ fontFamily: 'monospace', fontSize: '0.8rem', color: '#64748B' }}>pk_live_****...8f2a — Admin (expires Dec 2026)</div>
    </div>
);

export default function SuperAdminDashboard() {
    const [isDangerModalOpen, setIsDangerModalOpen] = useState(false);
    const { showToast } = useNotification();
    
    // Suggestion demonstration wrapper
    return (
        <div style={{ padding: '32px', maxWidth: '1600px', margin: '0 auto', display: 'flex', flexDirection: 'column', gap: '48px', backgroundColor: '#F8FAFC', minHeight: '100vh', paddingBottom: '100px' }}>
            
            <header style={{ borderBottom: '1px solid #E2E8F0', paddingBottom: '24px' }}>
                <h1 style={{ fontSize: '2rem', fontWeight: 900, color: '#0F172A', margin: '0 0 8px 0', display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <ServerIcon /> Root Infrastructure Subsystem
                </h1>
                <p style={{ color: '#64748B', fontSize: '1.1rem', margin: 0 }}>
                    Global multi-tenant orchestration, telemetry, and mass-data validation hub.
                </p>
            </header>

            <section>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
                    <h2 data-cy="h2-index-0" style={{ fontSize: '1.5rem', fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px' }}>
                        <Terminal color="#6366F1" /> SSE Pipeline Monitors
                    </h2>
                </div>
                <div style={{ height: '500px' }}>
                    <TerminalStream />
                </div>
            </section>
            
            <section style={{ display: 'grid', gridTemplateColumns: 'minmax(0, 1fr) minmax(0, 1fr)', gap: '32px' }}>
                <div>
                    <h2 data-cy="h2-index-1" style={{ fontSize: '1.5rem', fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px' }}>
                        <Database color="#10B981" /> Financial Node Validation
                    </h2>
                    <TAccountVisualizer />
                </div>
                <div>
                    <h2 data-cy="h2-index-2" style={{ fontSize: '1.5rem', fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px' }}>
                        <Key color="#8B5CF6" /> IAM Playground
                    </h2>
                    <ApiKeyVault />
                    
                    <div style={{ marginTop: '32px', backgroundColor: '#FEF2F2', padding: '24px', borderRadius: '16px', border: '1px solid #FECACA' }}>
                        <h3 data-cy="h3-index-0" style={{ margin: '0 0 8px 0', color: '#991B1B', display: 'flex', alignItems: 'center', gap: '8px' }}>
                            <AlertOctagon size={20} /> Tenant Orchestration (Danger)
                        </h3>
                        <p style={{ color: '#B91C1C', fontSize: '0.9rem', marginBottom: '16px' }}>
                            Test the structural safety barrier protecting the `purge_tenant` RPC command.
                        </p>
                        <button data-cy="btn-index-0" 
                            onClick={() => setIsDangerModalOpen(true)}
                            style={{ backgroundColor: '#DC2626', color: 'white', fontWeight: 800, border: 'none', padding: '12px 24px', borderRadius: '8px', cursor: 'pointer' }}
                        >
                            INITIATE TENANT PURGE
                        </button>
                    </div>
                </div>
            </section>

            <section>
                 <h2 data-cy="h2-index-3" style={{ fontSize: '1.5rem', fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px' }}>
                    <Activity color="#3B82F6" /> Universal Ledger (Read-Only Replica)
                </h2>
                <MassDataGrid />
            </section>

            <DangerZoneModal 
                isOpen={isDangerModalOpen}
                onClose={() => setIsDangerModalOpen(false)}
                onConfirm={() => {
                    showToast("TENANT PURGED. (Test Action Successful)", "success");
                    setIsDangerModalOpen(false);
                }}
                title="Purge Tenant Infrastructure"
                description="This action will permanently cascade-delete the target tenant's database schema, destroying all tied Timesheets, Shifts, Users, and Ledger Entries. This action CANNOT BE UNDONE through conventional rollbacks."
                targetEntityName="Tenant_ID_8849"
            />
        </div>
    );
}

const ServerIcon = () => (
    <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#0F172A" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <rect x="2" y="2" width="20" height="8" rx="2" ry="2"></rect>
        <rect x="2" y="14" width="20" height="8" rx="2" ry="2"></rect>
        <line x1="6" y1="6" x2="6.01" y2="6"></line>
        <line x1="6" y1="18" x2="6.01" y2="18"></line>
    </svg>
);

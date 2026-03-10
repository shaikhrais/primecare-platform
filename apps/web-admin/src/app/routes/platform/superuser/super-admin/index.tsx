import React, { useState } from 'react';
import { TerminalStream } from '../../admin/pages/system/components/TerminalStream';
import { TAccountVisualizer } from '../../admin/pages/finance/components/TAccountVisualizer';
import { MassDataGrid } from '../../admin/pages/finance/components/MassDataGrid';
import { ApiKeyVault } from '../../admin/pages/security/components/ApiKeyVault';
import { DangerZoneModal } from '@/shared/components/modals/DangerZoneModal';
import { AlertOctagon, Terminal, Activity, Key, Database } from 'lucide-react';

export default function SuperAdminDashboard() {
    const [isDangerModalOpen, setIsDangerModalOpen] = useState(false);
    
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
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px' }}>
                        <Terminal color="#6366F1" /> SSE Pipeline Monitors
                    </h2>
                </div>
                <div style={{ height: '500px' }}>
                    <TerminalStream />
                </div>
            </section>
            
            <section style={{ display: 'grid', gridTemplateColumns: 'minmax(0, 1fr) minmax(0, 1fr)', gap: '32px' }}>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px' }}>
                        <Database color="#10B981" /> Financial Node Validation
                    </h2>
                    <TAccountVisualizer />
                </div>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px' }}>
                        <Key color="#8B5CF6" /> IAM Playground
                    </h2>
                    <ApiKeyVault />
                    
                    <div style={{ marginTop: '32px', backgroundColor: '#FEF2F2', padding: '24px', borderRadius: '16px', border: '1px solid #FECACA' }}>
                        <h3 style={{ margin: '0 0 8px 0', color: '#991B1B', display: 'flex', alignItems: 'center', gap: '8px' }}>
                            <AlertOctagon size={20} /> Tenant Orchestration (Danger)
                        </h3>
                        <p style={{ color: '#B91C1C', fontSize: '0.9rem', marginBottom: '16px' }}>
                            Test the structural safety barrier protecting the `purge_tenant` RPC command.
                        </p>
                        <button 
                            onClick={() => setIsDangerModalOpen(true)}
                            style={{ backgroundColor: '#DC2626', color: 'white', fontWeight: 800, border: 'none', padding: '12px 24px', borderRadius: '8px', cursor: 'pointer' }}
                        >
                            INITIATE TENANT PURGE
                        </button>
                    </div>
                </div>
            </section>

            <section>
                 <h2 style={{ fontSize: '1.5rem', fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px' }}>
                    <Activity color="#3B82F6" /> Universal Ledger (Read-Only Replica)
                </h2>
                <MassDataGrid />
            </section>

            <DangerZoneModal 
                isOpen={isDangerModalOpen}
                onClose={() => setIsDangerModalOpen(false)}
                onConfirm={() => {
                    alert("TENANT PURGED. (Mock Action Successful)");
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

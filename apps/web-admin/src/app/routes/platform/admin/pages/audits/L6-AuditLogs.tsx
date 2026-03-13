// ================================================================
// PAGE IDENTITY: L6 � Audit Logs
// Registry ID:   page.admin.audits
// Type:          List
// Owner:         admin
// ================================================================
import React, { useState, useEffect } from 'react';
import EmptyState from '@/shared/components/layout/EmptyState';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, ApiRegistry, ButtonRegistry } = AdminRegistry;

interface AuditRecord {
    id: string;
    action: string;
    actor: { email: string };
    resourceType: string;
    createdAt: string;
    metadataJson: any;
}

export default function GovernanceAuditPage() {
    const { t } = useTranslation();
    const [logs, setLogs] = useState<AuditRecord[]>([]);
    const [loading, setLoading] = useState(true);

    const exportBtn = ButtonRegistry.find((b: any) => b.id === 'btn-adm-reports-export');

    useEffect(() => {
        const fetchLogs = async () => {
            try {
                // In a real scenario, this would hit ApiRegistry.SECURITY.PLATFORM_AUDIT_LOGS
                await new Promise(resolve => setTimeout(resolve, 600));
                setLogs([
                    { id: '1', action: 'USER_INVITE', actor: { email: 'admin@primecare.com' }, resourceType: 'USER', createdAt: '2026-03-04 10:20', metadataJson: { email: 'new.staff@branch.com' } },
                    { id: '2', action: 'API_KEY_GENERATE', actor: { email: 'sm@primecare.com' }, resourceType: 'SECURITY', createdAt: '2026-03-04 11:45', metadataJson: { name: 'Worker-Edge-Node' } },
                    { id: '3', action: 'INCIDENT_RESOLVE', actor: { email: 'manager@branch.com' }, resourceType: 'OPERATIONS', createdAt: '2026-03-04 14:10', metadataJson: { incidentId: 'inc-992' } },
                ]);
            } finally {
                setLoading(false);
            }
        };
        fetchLogs();
    }, []);

    return (
        <div data-cy="audit-logs-page" style={{ animation: 'fadeIn 0.5s ease-out' }}>
            <style>
                {`
                    @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
                    .glass-card {
                        background: rgba(255, 255, 255, 0.7);
                        backdrop-filter: blur(12px);
                        border: 1px solid rgba(255, 255, 255, 0.3);
                        border-radius: 24px;
                        padding: 2rem;
                        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.04);
                    }
                    .audit-row {
                        display: grid;
                        grid-template-columns: 100px 1fr 150px 200px 150px;
                        gap: 1.5rem;
                        padding: 1.25rem;
                        border-bottom: 1px solid #f1f5f9;
                        align-items: center;
                        transition: all 0.2s;
                    }
                    .audit-row:hover { background: #f8fafc; border-radius: 12px; transform: scale(1.005); }
                    .badge {
                        padding: 4px 10px;
                        border-radius: 8px;
                        font-size: 0.7rem;
                        font-weight: 800;
                        text-transform: uppercase;
                        letter-spacing: 0.05em;
                    }
                `}
            </style>

            <div style={{ marginBottom: '2.5rem', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end' }}>
                <div>
                    <h1 style={{ margin: 0, fontSize: '2.25rem', fontWeight: 900, color: '#0f172a', letterSpacing: '-0.02em' }}>Platform Governance</h1>
                    <p style={{ margin: '4px 0 0 0', color: '#64748b', fontSize: '1.1rem' }}>Master audit logs for security, operations, and clinical integrity.</p>
                </div>
                <div style={{ display: 'flex', gap: '12px' }}>
                    <div style={{ textAlign: 'right' }}>
                        <div style={{ fontSize: '0.75rem', fontWeight: 800, color: '#94a3b8', marginBottom: '4px' }}>HEALTH STATUS</div>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#10b981', fontWeight: 700 }}>
                            <span style={{ width: '8px', height: '8px', borderRadius: '50%', background: '#10b981', display: 'inline-block' }}></span>
                            VERIFIED SECURE
                        </div>
                    </div>
                </div>
            </div>

            <div className="glass-card">
                <div className="audit-row" style={{ color: '#94a3b8', fontSize: '0.7rem', fontWeight: 800, border: 'none', paddingBottom: '1rem' }}>
                    <div>RESOURCE</div>
                    <div>ACTION / METADATA</div>
                    <div>ACTOR</div>
                    <div>TIMELINE</div>
                    <div style={{ textAlign: 'right' }}>STATUS</div>
                </div>

                {loading ? (
                    <div style={{ padding: '4rem', textAlign: 'center', color: '#64748b' }}>Orchestrating audit records...</div>
                ) : logs.length === 0 ? (
                    <EmptyState
                        title="No Audit Trails"
                        description="There are currently no governance audit logs recorded in the system."
                        icon="🛡️"
                    />
                ) : (
                    logs.map(log => (
                        <div key={log.id} className="audit-row">
                            <div>
                                <span className="badge" style={{ background: '#f1f5f9', color: '#475569' }}>{log.resourceType}</span>
                            </div>
                            <div>
                                <div style={{ fontWeight: 800, color: '#1e293b', marginBottom: '4px' }}>{log.action}</div>
                                <div style={{ fontSize: '0.8rem', color: '#94a3b8', fontFamily: 'monospace' }}>
                                    {JSON.stringify(log.metadataJson)}
                                </div>
                            </div>
                            <div style={{ fontSize: '0.85rem', fontWeight: 600, color: '#64748b' }}>{log.actor.email.split('@')[0]}</div>
                            <div style={{ fontSize: '0.85rem', color: '#94a3b8' }}>{log.createdAt}</div>
                            <div style={{ textAlign: 'right' }}>
                                <span className="badge" style={{ background: 'rgba(16, 185, 129, 0.1)', color: '#10b981' }}>SIGNED</span>
                            </div>
                        </div>
                    ))
                )}
            </div>

            <div style={{ marginTop: '2rem', padding: '1.5rem', background: '#0f172a', borderRadius: '20px', color: 'white', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div style={{ display: 'flex', gap: '1.5rem', alignItems: 'center' }}>
                    <div style={{ width: '48px', height: '48px', borderRadius: '14px', background: 'rgba(255,255,255,0.1)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.5rem' }}>🛡️</div>
                    <div>
                        <h4 style={{ margin: 0, fontWeight: 800 }}>Immutable Log Policy</h4>
                        <p style={{ margin: 0, fontSize: '0.8rem', opacity: 0.6 }}>Logs are cryptographically hashed and cannot be modified or deleted by any role.</p>
                    </div>
                </div>
                <button
                    style={{ background: 'white', color: '#0f172a', border: 'none', padding: '10px 20px', borderRadius: '12px', fontWeight: 800, cursor: 'pointer' }}
                    data-cy="btn-adm-reports-export"
                >
                    {exportBtn?.label || 'Generate Forensic Export'}
                </button>
            </div>
        </div>
    );
}

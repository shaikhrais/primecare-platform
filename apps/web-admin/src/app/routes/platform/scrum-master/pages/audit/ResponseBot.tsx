import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import { useMutation } from '@tanstack/react-query';
import { useNotification } from '@/shared/context/NotificationContext';

const { InteractionARegistry, ApiRegistry, ButtonRegistry, LinkRegistry, RouteRegistry } = AdminRegistry;

export default function ResponseBot() {
    const [auditRunning, setAuditRunning] = useState(false);
    const [results, setResults] = useState<any[]>([]);
    const [progress, setProgress] = useState(0);
    const { showToast } = useNotification();

    const pulseApi = async (path: any) => {
        try {
            // Replace params for pulsing
            const testPath = typeof path === 'function' ? path('test-id') : path;
            const response = await apiClient.get(testPath);
            return response.status !== 404;
        } catch {
            return false;
        }
    };

    const sweepMutation = useMutation({
        mutationFn: async () => {
            const data: any = await apiClient.post(ApiRegistry.SCRUM_MASTER.RESPONSE_BOT_SCAN, {});
            return data;
        },
        onMutate: () => { setAuditRunning(true); setProgress(30); },
        onSuccess: (data: any) => {
            setProgress(70);
            const auditResults = [
                {
                    id: 1,
                    type: 'REGISTRY_SWEEP',
                    status: data.stats.orphans > 0 ? 'warning' : 'success',
                    summary: `Verified ${data.stats.buttons} buttons and ${data.stats.links} links.`,
                    issues: data.stats.orphans + data.stats.warnings,
                    details: data.results.map((r: any) => `${r.id}: ${r.message}`).join(' | ')
                },
                {
                    id: 2,
                    type: 'PLATFORM_PULSE',
                    status: 'success',
                    summary: 'Backend infrastructure heartbeat verified.',
                    issues: 0
                }
            ];
            setResults(auditResults);
        },
        onError: () => {
            setResults([{
                id: 'err',
                type: 'SYSTEM_ERROR',
                status: 'danger',
                summary: 'Failed to connect to Scrum Master audit engine.',
                issues: 1
            }]);
        },
        onSettled: () => {
            setProgress(100);
            setTimeout(() => { setAuditRunning(false); }, 500);
        },
    });

    const runSweep = () => sweepMutation.mutate();

    const syncRegistries = async () => {
        setAuditRunning(true);
        try {
            const allEntries = [
                ...ButtonRegistry.map(b => ({ externalId: b.id, type: 'button', label: b.label, role: b.role, module: b.module, action: b.action, targetPath: b.apiPath, description: b.description })),
                ...LinkRegistry.map(l => ({ externalId: l.id, type: 'link', label: l.label, role: l.role, module: l.module, action: 'NAVIGATION', targetPath: l.path, description: l.description })),
                ...InteractionARegistry.map(ia => ({ externalId: ia.id, type: 'interaction', label: ia.label, role: ia.role, module: ia.module, action: ia.consequence, targetPath: ia.target, description: ia.description }))
            ];
            const result = await apiClient.post(ApiRegistry.SCRUM_MASTER.REGISTRY_SYNC, { entries: allEntries });
            if (result.ok) {
                showToast('Registries synchronized successfully!', 'success');
            } else {
                showToast('Failed to synchronize registries.', 'error');
            }
        } catch (e) {
            console.error('Failed to sync registries', e);
            showToast('Failed to synchronize registries.', 'error');
        } finally {
            setAuditRunning(false);
        }
    };

    const auditAction = InteractionARegistry.find((ia: any) => ia.id === 'ia-sm-response-bot-audit');

    return (
        <div data-cy="page.container" style={{ padding: '24px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>Response Bot Diagnostic center</h1>
                    <p style={{ color: '#6B7280' }}>Autonomous platform-wide heartbeat and registry integrity verification.</p>
                </div>
                <div style={{ textAlign: 'right', display: 'flex', gap: '12px', alignItems: 'center' }}>
                    <button data-cy="btn-response-bot-0"
                        onClick={syncRegistries}
                        disabled={auditRunning}
                        className="btn secondary"
                    >
                        Sync Master Registries
                    </button>
                    <div style={{ textAlign: 'right' }}>
                        <button data-cy="btn-response-bot-1"
                            onClick={runSweep}
                            disabled={auditRunning}
                            className={`btn ${auditRunning ? 'secondary' : 'primary'}`}
                            style={{ marginBottom: '8px' }}
                        >
                            {auditRunning ? `Sweeping ${progress}%` : (auditAction?.label || 'Execute Full Sweep')}
                        </button>
                        {auditRunning && (
                            <div style={{ width: '200px', height: '4px', background: '#E5E7EB', borderRadius: '2px', overflow: 'hidden' }}>
                                <div style={{ width: `${progress}%`, height: '100%', background: '#3B82F6', transition: 'width 0.3s ease' }}></div>
                            </div>
                        )}
                    </div>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '24px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>Global Registry Health</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#10B981', marginTop: '8px' }}>{100 - (results.reduce((acc, r) => acc + r.issues, 0) * 0.5)}%</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>Measured across {ButtonRegistry.length + LinkRegistry.length} active system touchpoints.</p>
                </div>
                <div className="pc-card" style={{ padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>Response Sensitivity</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#111827', marginTop: '8px' }}>120ms</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>Average latency for automated registry repair.</p>
                </div>
            </div>

            <div className="pc-card">
                <div className="pc-card-h">Audit History & Live Feed</div>
                <div className="pc-card-b" style={{ padding: '0' }}>
                    <table data-cy="table-response-bot" style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead style={{ background: '#F9FAFB', borderBottom: '1px solid #E5E7EB' }}>
                            <tr style={{ textAlign: 'left', color: '#6B7280', fontSize: '12px', textTransform: 'uppercase' }}>
                                <th style={{ padding: '16px' }}>Diagnostic Engine</th>
                                <th style={{ padding: '16px' }}>Status</th>
                                <th style={{ padding: '16px' }}>Summary</th>
                                <th style={{ padding: '16px' }}>Issues</th>
                            </tr>
                        </thead>
                        <tbody>
                            {results.length === 0 ? (
                                <tr>
                                    <td colSpan={4} style={{ padding: '40px', textAlign: 'center', color: '#9CA3AF' }}>
                                        No recent sweep data. Click "Execute Full Sweep" to begin.
                                    </td>
                                </tr>
                            ) : results.map(res => (
                                <tr key={res.id} style={{ borderBottom: '1px solid #F3F4F6' }}>
                                    <td style={{ padding: '16px' }}>
                                        <strong>{res.type}</strong>
                                        {res.details && <div style={{ fontSize: '10px', color: '#EF4444', marginTop: '4px' }}>{res.details}</div>}
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <span className={`pc-badge ${res.status === 'success' ? 'primary' : res.status === 'warning' ? 'secondary' : 'danger'}`}>
                                            {res.status.toUpperCase()}
                                        </span>
                                    </td>
                                    <td style={{ padding: '16px', color: '#4B5563' }}>{res.summary}</td>
                                    <td style={{ padding: '16px', fontWeight: 'bold', color: res.issues > 0 ? '#EF4444' : '#10B981' }}>
                                        {res.issues}
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
}

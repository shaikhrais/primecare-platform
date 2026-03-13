import React, { useState } from 'react';
import { Layers, Activity, ShieldAlert, Zap, Globe, Pause, Play, DownloadCloud } from 'lucide-react';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';

interface ScriptTag {
    id: string;
    provider: string;
    description: string;
    scriptType: 'ANALYTICS' | 'SUPPORT_CHAT' | 'AD_TRACKING' | 'PERFORMANCE';
    status: 'ACTIVE' | 'PAUSED';
    payloadSizeKb: number;
}

export const ThirdPartyScriptManager: React.FC = () => {
    const [scripts, setScripts] = useState<ScriptTag[]>([
        { id: '1', provider: 'Google Analytics (GA4)', description: 'Tracks user page flow and bounce rates.', scriptType: 'ANALYTICS', status: 'ACTIVE', payloadSizeKb: 73 },
        { id: '2', provider: 'Intercom Messenger', description: 'Provides real-time chat support for clients.', scriptType: 'SUPPORT_CHAT', status: 'PAUSED', payloadSizeKb: 142 },
        { id: '3', provider: 'Meta Pixel', description: 'Tracks conversions from Facebook ad campaigns.', scriptType: 'AD_TRACKING', status: 'ACTIVE', payloadSizeKb: 45 },
        { id: '4', provider: 'Sentry', description: 'Captures and aggregates frontend JS exceptions.', scriptType: 'PERFORMANCE', status: 'ACTIVE', payloadSizeKb: 28 }
    ]);
    const [isSaving, setIsSaving] = useState(false);
    const { showToast } = useNotification();

    const toggleScript = (id: string) => {
        setScripts(prev => prev.map(s => s.id === id ? { ...s, status: s.status === 'ACTIVE' ? 'PAUSED' : 'ACTIVE' } : s));
    };

    const handleSave = async () => {
        setIsSaving(true);
        try {
            await apiClient.post('/platform/admin/dam/governance/scripts', { scripts });
            showToast("Script manifest updated. Edge Proxy will now inject these tags.", "success");
        } catch (error) {
            showToast("Failed to sync proxy tags", "error");
        } finally {
            setIsSaving(false);
        }
    };

    const totalActivePayload = scripts.filter(s => s.status === 'ACTIVE').reduce((sum, s) => sum + s.payloadSizeKb, 0);

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#F0FDF4', padding: '10px', borderRadius: '8px', border: '1px solid #BBF7D0' }}>
                        <Layers size={24} color="#16A34A" />
                    </div>
                    <div>
                        <h3 data-cy="h3-third-party-script-manager-0" style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Third-Party Script Manager</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Dynamically inject or pause external tracking tags without redeploying React.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '8px 16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', color: '#334155', fontWeight: 700, fontSize: '0.9rem' }}>
                        <DownloadCloud size={18} color={totalActivePayload > 200 ? "#EF4444" : "#10B981"} />
                        {totalActivePayload} KB External Payload
                    </div>
                    <button 
                        data-cy="btn-deploy-script-manifest"
                        onClick={handleSave}
                        disabled={isSaving}
                        style={{ backgroundColor: '#16A34A', color: 'white', border: 'none', borderRadius: '8px', padding: '8px 16px', fontWeight: 700, cursor: isSaving ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}
                    >
                        <Zap size={16} /> {isSaving ? 'Syncing...' : 'Deploy Manifest'}
                    </button>
                </div>
            </div>

            <table data-cy="table-third-party-script-manager" style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.9rem' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Service Provider</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Initialization Script</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Render Bloat</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>Edge Status</th>
                    </tr>
                </thead>
                <tbody>
                    {scripts.map(script => (
                        <tr key={script.id} style={{ borderBottom: '1px solid #E2E8F0', backgroundColor: script.status === 'PAUSED' ? '#F8FAFC' : 'white', opacity: script.status === 'PAUSED' ? 0.6 : 1 }}>
                            <td style={{ padding: '12px' }}>
                                <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#0F172A', fontWeight: 800 }}>
                                        <Globe size={16} color="#64748B" /> {script.provider}
                                    </div>
                                    <div style={{ fontSize: '0.8rem', color: '#64748B' }}>{script.description}</div>
                                </div>
                            </td>
                            <td style={{ padding: '12px' }}>
                                <div style={{ fontFamily: 'monospace', fontSize: '0.8rem', color: '#16A34A', backgroundColor: '#F0FDF4', padding: '4px 8px', borderRadius: '4px', border: '1px solid #BBF7D0', display: 'inline-block' }}>
                                    &lt;script src="..."&gt;&lt;/script&gt;
                                </div>
                            </td>
                            <td style={{ padding: '12px', fontWeight: 700, color: script.payloadSizeKb > 100 ? '#EF4444' : '#64748B' }}>
                                {script.payloadSizeKb} KB
                            </td>
                            <td style={{ padding: '12px', textAlign: 'right' }}>
                                <button 
                                    data-cy={`btn-toggle-script-${script.id}`}
                                    onClick={() => toggleScript(script.id)}
                                    style={{ 
                                        padding: '6px 16px', borderRadius: '6px', outline: 'none', fontWeight: 700, fontSize: '0.8rem', cursor: 'pointer', border: 'none',
                                        backgroundColor: script.status === 'ACTIVE' ? '#FEF2F2' : '#F0FDF4',
                                        color: script.status === 'ACTIVE' ? '#DC2626' : '#16A34A',
                                        display: 'inline-flex', alignItems: 'center', gap: '6px'
                                    }}
                                >
                                    {script.status === 'ACTIVE' ? <><Pause size={14} /> PAUSE SCRIPT</> : <><Play size={14} /> ACTIVATE SCRIPT</>}
                                </button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>

            <div style={{ marginTop: '24px', backgroundColor: '#FEF2F2', padding: '16px', borderRadius: '8px', border: '1px solid #FECACA', fontSize: '0.85rem', color: '#991B1B', display: 'flex', alignItems: 'flex-start', gap: '12px' }}>
                <ShieldAlert size={20} color="#DC2626" style={{ flexShrink: 0 }} />
                <div style={{ lineHeight: 1.5 }}>
                    <strong>Security & Performance Warning</strong><br/>
                    Every active third-party script runs arbitrary JavaScript in the user's browser environment. Malicious or poorly optimized trackers (like heavy chat widgets) can drastically increase Time-To-Interactive (TTI) or leak sensitive PII. Pause non-essential scripts during high-traffic events.
                </div>
            </div>
        </div>
    );
};

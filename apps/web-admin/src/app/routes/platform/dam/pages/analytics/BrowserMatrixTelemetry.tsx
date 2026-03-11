import React, { useState } from 'react';
import { MonitorSmartphone, LayoutDashboard, Search, Trash2, PieChart, Info, Map } from 'lucide-react';

interface BrowserData {
    id: string;
    browserName: string;
    version: string;
    percentTraffic: number;
    supportCostLevel: 'HIGH' | 'MEDIUM' | 'LOW';
    status: 'SUPPORTED' | 'DEPRECATION_WARNING' | 'UNSUPPORTED';
}

export const BrowserMatrixTelemetry: React.FC = () => {
    const [browsers, setBrowsers] = useState<BrowserData[]>([
        { id: '1', browserName: 'Chrome', version: 'v110+', percentTraffic: 62.4, supportCostLevel: 'LOW', status: 'SUPPORTED' },
        { id: '2', browserName: 'Safari', version: 'v15+', percentTraffic: 24.1, supportCostLevel: 'LOW', status: 'SUPPORTED' },
        { id: '3', browserName: 'Edge', version: 'v108+', percentTraffic: 11.2, supportCostLevel: 'LOW', status: 'SUPPORTED' },
        { id: '4', browserName: 'Safari', version: 'v12', percentTraffic: 1.8, supportCostLevel: 'HIGH', status: 'DEPRECATION_WARNING' },
        { id: '5', browserName: 'Internet Explorer', version: 'v11', percentTraffic: 0.5, supportCostLevel: 'HIGH', status: 'UNSUPPORTED' }
    ]);
    const [isSaving, setIsSaving] = useState(false);

    const handleStatusChange = (id: string, newStatus: BrowserData['status']) => {
        setBrowsers(prev => prev.map(b => b.id === id ? { ...b, status: newStatus } : b));
    };

    const handleDeploy = () => {
        setIsSaving(true);
        setTimeout(() => {
            setIsSaving(false);
            alert("Support matrix updated! Browsers marked as 'UNSUPPORTED' will now receive a static HTTP 426 Upgrade Required page.");
        }, 1200);
    };

    const getStatusStyles = (status: string) => {
        switch(status) {
            case 'SUPPORTED': return { bg: '#ECFDF5', text: '#059669', border: '#10B981' };
            case 'DEPRECATION_WARNING': return { bg: '#FFFBEB', text: '#D97706', border: '#F59E0B' };
            case 'UNSUPPORTED': return { bg: '#FEF2F2', text: '#DC2626', border: '#EF4444' };
            default: return { bg: '#F8FAFC', text: '#64748B', border: '#CBD5E1' };
        }
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#EEF2FF', padding: '10px', borderRadius: '8px' }}>
                        <MonitorSmartphone size={24} color="#6366F1" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Browser Matrix Telemetry</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Track legacy browser usage to objectively justify deprecating polyfill support.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <button 
                        onClick={handleDeploy}
                        disabled={isSaving}
                        style={{ backgroundColor: '#6366F1', color: 'white', border: 'none', borderRadius: '8px', padding: '10px 16px', fontWeight: 700, cursor: isSaving ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}
                    >
                        <Trash2 size={16} /> {isSaving ? 'Updating React Router...' : 'Enforce Matrix Rules'}
                    </button>
                </div>
            </div>

            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.9rem' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Client Environment</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Traffic Share (Trailing 30)</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Engineering Cost</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>Support Posture</th>
                    </tr>
                </thead>
                <tbody>
                    {browsers.map(b => (
                        <tr key={b.id} style={{ borderBottom: '1px solid #E2E8F0' }}>
                            <td style={{ padding: '12px' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#0F172A', fontWeight: 800 }}>
                                    <LayoutDashboard size={16} color="#64748B" />
                                    {b.browserName} <span style={{ color: '#64748B', fontWeight: 600, fontSize: '0.8rem' }}>({b.version})</span>
                                </div>
                            </td>
                            <td style={{ padding: '12px' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                                    <div style={{ fontWeight: 800, color: b.percentTraffic < 2 ? '#EF4444' : '#0F172A', width: '40px' }}>
                                        {b.percentTraffic}%
                                    </div>
                                    <div style={{ flex: 1, maxWidth: '150px', height: '6px', backgroundColor: '#E2E8F0', borderRadius: '4px', overflow: 'hidden' }}>
                                        <div style={{ height: '100%', width: `${b.percentTraffic}%`, backgroundColor: b.percentTraffic < 2 ? '#EF4444' : '#6366F1' }} />
                                    </div>
                                </div>
                            </td>
                            <td style={{ padding: '12px' }}>
                                {b.supportCostLevel === 'HIGH' && <span style={{ backgroundColor: '#FEF2F2', color: '#DC2626', border: '1px solid #FECACA', padding: '2px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 700 }}>HIGH MAINTENANCE</span>}
                                {b.supportCostLevel === 'LOW' && <span style={{ backgroundColor: '#F1F5F9', color: '#64748B', padding: '2px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 700 }}>NATIVE</span>}
                            </td>
                            <td style={{ padding: '12px', textAlign: 'right' }}>
                                <select 
                                    value={b.status}
                                    onChange={(e) => handleStatusChange(b.id, e.target.value as any)}
                                    style={{ 
                                        padding: '6px 12px', borderRadius: '6px', outline: 'none', fontWeight: 700, fontSize: '0.8rem', cursor: 'pointer',
                                        border: `1px solid ${getStatusStyles(b.status).border}`,
                                        backgroundColor: getStatusStyles(b.status).bg,
                                        color: getStatusStyles(b.status).text
                                    }}
                                >
                                    <option value="SUPPORTED">✓ SUPPORTED</option>
                                    <option value="DEPRECATION_WARNING">⚠ SHOW WARNING</option>
                                    <option value="UNSUPPORTED">✗ BLOCK ACCESS</option>
                                </select>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>

            <div style={{ marginTop: '24px', backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '8px', border: '1px dashed #CBD5E1', fontSize: '0.85rem', color: '#475569', display: 'flex', alignItems: 'flex-start', gap: '12px' }}>
                <Info size={20} color="#6366F1" style={{ flexShrink: 0, marginTop: '2px' }} />
                <div style={{ lineHeight: 1.5 }}>
                    <strong>Why does this matter?</strong> Maintaing compatibility with legacy browsers (like old Safari or IE11) forces the React Webpack compiler to inject hundreds of kilobytes of "Polyfill" JavaScript into the bundle, slowing down the application for the 98% of users on modern devices. Deprecating old browsers instantly makes the platform faster for everyone else.
                </div>
            </div>
        </div>
    );
};

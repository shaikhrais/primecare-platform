import React, { useState } from 'react';
import { Type, Link2, DownloadCloud, AlertOctagon, Brush, Search, Trash2 } from 'lucide-react';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';

interface FontRegistry {
    id: string;
    family: string;
    provider: 'Google Fonts' | 'Adobe Typekit' | 'Local Asset';
    weightIncluded: string[];
    status: 'APPROVED' | 'PENDING' | 'BLOCKED';
    impactKb: number;
}

export const FontTypographyRegistry: React.FC = () => {
    const [fonts, setFonts] = useState<FontRegistry[]>([
        { id: '1', family: 'Inter', provider: 'Google Fonts', weightIncluded: ['400', '600', '800'], status: 'APPROVED', impactKb: 85 },
        { id: '2', family: 'Roboto Mono', provider: 'Google Fonts', weightIncluded: ['400'], status: 'APPROVED', impactKb: 32 },
        { id: '3', family: 'Comic Sans MS', provider: 'Local Asset', weightIncluded: ['400'], status: 'BLOCKED', impactKb: 0 },
        { id: '4', family: 'Proxima Nova', provider: 'Adobe Typekit', weightIncluded: ['300', '400', '700'], status: 'PENDING', impactKb: 145 }
    ]);
    const [isSaving, setIsSaving] = useState(false);
    const { showToast } = useNotification();

    const handleStatusChange = (id: string, newStatus: FontRegistry['status']) => {
        setFonts(prev => prev.map(f => f.id === id ? { ...f, status: newStatus } : f));
    };

    const handleSave = async () => {
        setIsSaving(true);
        try {
            await apiClient.post('/platform/admin/dam/design/sync-fonts', { fonts });
            showToast("Blocked fonts have been forcefully stripped from the <head> tag globally.", "success");
        } catch (error) {
            showToast("Unable to reach registry sink", "error");
        } finally {
            setIsSaving(false);
        }
    };

    const totalPayload = fonts.filter(f => f.status === 'APPROVED').reduce((sum, f) => sum + f.impactKb, 0);

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#F0FDFA', padding: '10px', borderRadius: '8px' }}>
                        <Brush size={24} color="#0D9488" />
                    </div>
                    <div>
                        <h3 data-cy="h3-font-typography-registry-0" style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Typography & Font Governance</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Control which external font families are injected to protect Core Web Vitals.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '8px 16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', color: '#334155', fontWeight: 700, fontSize: '0.9rem' }}>
                        <DownloadCloud size={18} color={totalPayload > 150 ? "#EF4444" : "#10B981"} />
                        {totalPayload} KB Render Payload
                    </div>
                    <button 
                        data-cy="btn-enforce-typography"
                        onClick={handleSave}
                        disabled={isSaving}
                        style={{ backgroundColor: '#0D9488', color: 'white', border: 'none', borderRadius: '8px', padding: '8px 16px', fontWeight: 700, cursor: isSaving ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}
                    >
                        <AlertOctagon size={16} /> {isSaving ? 'Scrubbing Head tags...' : 'Enforce Typography Rules'}
                    </button>
                </div>
            </div>

            <table data-cy="table-font-typography-registry" style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.9rem' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Font Family</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Provider Source</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Weights (Payload)</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>Governance State</th>
                    </tr>
                </thead>
                <tbody>
                    {fonts.map(font => (
                        <tr key={font.id} style={{ borderBottom: '1px solid #E2E8F0', backgroundColor: font.status === 'BLOCKED' ? '#FEF2F2' : 'white', opacity: font.status === 'BLOCKED' ? 0.6 : 1 }}>
                            <td style={{ padding: '12px' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#0F172A', fontWeight: 800 }}>
                                    <Type size={16} color="#64748B" />
                                    {font.family}
                                </div>
                            </td>
                            <td style={{ padding: '12px', color: '#475569', fontSize: '0.85rem' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                                    <Link2 size={14} /> {font.provider}
                                </div>
                            </td>
                            <td style={{ padding: '12px' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                                    {font.weightIncluded.map(w => (
                                        <span key={w} style={{ backgroundColor: '#F1F5F9', border: '1px solid #E2E8F0', padding: '2px 6px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 600, color: '#475569' }}>
                                            {w}
                                        </span>
                                    ))}
                                    <span style={{ fontSize: '0.8rem', color: font.impactKb > 100 ? '#EF4444' : '#64748B', fontWeight: 700, marginLeft: '8px' }}>
                                        {font.impactKb} KB
                                    </span>
                                </div>
                            </td>
                            <td style={{ padding: '12px', textAlign: 'right' }}>
                                <select 
                                    data-cy={`font-status-${font.id}`}
                                    value={font.status}
                                    onChange={(e) => handleStatusChange(font.id, e.target.value as any)}
                                    style={{ 
                                        padding: '6px 12px', borderRadius: '6px', outline: 'none', fontWeight: 700, fontSize: '0.8rem', cursor: 'pointer',
                                        border: font.status === 'APPROVED' ? '1px solid #10B981' : font.status === 'PENDING' ? '1px solid #F59E0B' : '1px solid #EF4444',
                                        backgroundColor: font.status === 'APPROVED' ? '#ECFDF5' : font.status === 'PENDING' ? '#FFFBEB' : '#FEF2F2',
                                        color: font.status === 'APPROVED' ? '#059669' : font.status === 'PENDING' ? '#D97706' : '#DC2626'
                                    }}
                                >
                                    <option value="APPROVED">✓ APPROVED</option>
                                    <option value="PENDING">? PENDING REVIEW</option>
                                    <option value="BLOCKED">✗ BLOCKED (STRIP)</option>
                                </select>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>

            <div style={{ marginTop: '24px', backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '8px', border: '1px dashed #CBD5E1', fontSize: '0.85rem', color: '#64748B', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                <span>Unapproved web fonts injected by developers will trigger Lighthouse performance warnings and will be automatically stripped from production builds.</span>
                <span style={{ fontWeight: 700, color: '#0F172A' }}>Max Allowed Font Payload: 250 KB</span>
            </div>
        </div>
    );
};

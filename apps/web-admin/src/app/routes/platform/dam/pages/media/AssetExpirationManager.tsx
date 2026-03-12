import React, { useState } from 'react';
import { CalendarClock, Archive, AlertCircle, Save, Clock } from 'lucide-react';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';

interface ExpiryAsset {
    id: string;
    alias: string;
    type: 'IMAGE' | 'PDF';
    uploadedAt: string;
    expiresAt: string | null;
    status: 'ACTIVE' | 'ARCHIVED';
}

export const AssetExpirationManager: React.FC = () => {
    const [assets, setAssets] = useState<ExpiryAsset[]>([
        { id: 'a1', alias: 'holiday_promo_banner_2026.webp', type: 'IMAGE', uploadedAt: '2 months ago', expiresAt: '2026-12-31T23:59:59', status: 'ACTIVE' },
        { id: 'a2', alias: 'Q3_financial_disclosure.pdf', type: 'PDF', uploadedAt: '1 week ago', expiresAt: null, status: 'ACTIVE' },
        { id: 'a3', alias: 'spring_hiring_drive.webp', type: 'IMAGE', uploadedAt: '1 year ago', expiresAt: '2025-06-01T00:00:00', status: 'ARCHIVED' }
    ]);
    
    const [isSaving, setIsSaving] = useState(false);
    const { showToast } = useNotification();

    const handleDateChange = (id: string, newDate: string) => {
        setAssets(prev => prev.map(a => a.id === id ? { ...a, expiresAt: newDate || null } : a));
    };

    const handleSave = async () => {
        setIsSaving(true);
        try {
            await apiClient.post('/platform/admin/dam/media/expiration', { assets });
            showToast("Lifecycle policies updated. Expired assets pulled from CDN edge.", "success");
        } catch (error) {
            showToast("Failed to lock TTL bounds", "error");
        } finally {
            setIsSaving(false);
        }
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#FDF4FF', padding: '10px', borderRadius: '8px' }}>
                        <CalendarClock size={24} color="#C026D3" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Asset Expiration Manager</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Automate the archiving of time-sensitive marketing or compliance files.</p>
                    </div>
                </div>

                <button 
                    onClick={handleSave}
                    disabled={isSaving}
                    style={{ backgroundColor: '#0F172A', color: 'white', border: 'none', borderRadius: '8px', padding: '10px 16px', fontWeight: 700, cursor: isSaving ? 'wait' : 'pointer', opacity: isSaving ? 0.6 : 1, display: 'flex', alignItems: 'center', gap: '8px' }}
                >
                    <Save size={16} /> {isSaving ? 'Syncing...' : 'Deploy TTL Policies'}
                </button>
            </div>

            <div style={{ backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '8px', border: '1px solid #E2E8F0', marginBottom: '24px', display: 'flex', alignItems: 'flex-start', gap: '12px', color: '#475569', fontSize: '0.9rem' }}>
                <AlertCircle size={20} color="#C026D3" style={{ flexShrink: 0, marginTop: '2px' }} />
                <div>
                    <strong>Lifecycle Note:</strong> When an asset reaches its expiration boundary, it is automatically purged from the Cloudflare edge cache and replaced with a transparent 1x1 pixel or a 404 response to prevent broken layout reflows on legacy cached pages.
                </div>
            </div>

            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.9rem' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Asset Name</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>State</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Expiration Boundary (TTL)</th>
                    </tr>
                </thead>
                <tbody>
                    {assets.map(asset => {
                        const isExpired = asset.status === 'ARCHIVED' || Boolean(asset.expiresAt && new Date(asset.expiresAt).getTime() < Date.now());
                        
                        return (
                            <tr key={asset.id} style={{ borderBottom: '1px solid #E2E8F0', backgroundColor: isExpired ? '#F8FAFC' : 'white', opacity: isExpired ? 0.7 : 1 }}>
                                <td style={{ padding: '12px' }}>
                                    <div style={{ fontWeight: 700, color: '#0F172A', textDecoration: isExpired ? 'line-through' : 'none' }}>
                                        {asset.alias}
                                    </div>
                                    <div style={{ fontSize: '0.8rem', color: '#64748B' }}>{asset.type} • Uploaded {asset.uploadedAt}</div>
                                </td>
                                <td style={{ padding: '12px' }}>
                                    {isExpired ? (
                                        <div style={{ display: 'flex', alignItems: 'center', gap: '4px', color: '#64748B', fontWeight: 700, fontSize: '0.8rem' }}>
                                            <Archive size={14} /> ARCHIVED
                                        </div>
                                    ) : (
                                        <div style={{ display: 'flex', alignItems: 'center', gap: '4px', color: '#16A34A', fontWeight: 700, fontSize: '0.8rem' }}>
                                            <Clock size={14} /> ACTIVE
                                        </div>
                                    )}
                                </td>
                                <td style={{ padding: '12px' }}>
                                    <input 
                                        type="datetime-local" 
                                        value={asset.expiresAt ? asset.expiresAt.substring(0, 16) : ''}
                                        onChange={(e) => handleDateChange(asset.id, e.target.value)}
                                        disabled={isExpired}
                                        style={{ padding: '8px', borderRadius: '6px', border: '1px solid #CBD5E1', color: isExpired ? '#94A3B8' : '#0F172A', backgroundColor: isExpired ? '#F1F5F9' : 'white', outline: 'none' }}
                                    />
                                    {!asset.expiresAt && !isExpired && <span style={{ marginLeft: '12px', fontSize: '0.8rem', color: '#94A3B8' }}>Never expires</span>}
                                </td>
                            </tr>
                        );
                    })}
                </tbody>
            </table>
        </div>
    );
};

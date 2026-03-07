import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '../../../../../../shared/utils/apiClient';

const { ContentRegistry, ButtonRegistry } = AdminRegistry;

interface TenantSecurityConfig {
    enforceVpn: boolean;
    allowedVpnRanges: string[];
    requireDeviceApproval: boolean;
    maxDevicesPerUser: number;
}

export default function SecurityGovernance() {
    const [config, setConfig] = useState<TenantSecurityConfig | null>(null);
    const [loading, setLoading] = useState(true);
    const [saving, setSaving] = useState(false);
    const [successMessage, setSuccessMessage] = useState('');

    useEffect(() => {
        fetchConfig();
    }, []);

    const fetchConfig = async () => {
        try {
            const userStr = localStorage.getItem('user');
            const userData = userStr ? JSON.parse(userStr) : null;
            const tenantId = userData?.tenantId;
            if (!tenantId) return;

            const res = await apiClient.get('/v1/admin/settings/security');
            if (res.ok) {
                const data = await res.json();
                setConfig(data);
            }
        } catch (err) {
            console.error('Failed to fetch security config:', err);
        } finally {
            setLoading(false);
        }
    };

    const handleSave = async () => {
        setSaving(true);
        setSuccessMessage('');
        try {
            const res = await apiClient.patch('/v1/admin/settings/security', config);
            if (res.ok) {
                setSuccessMessage('Security settings updated successfully.');
                setTimeout(() => setSuccessMessage(''), 3000);
            }
        } catch (err) {
            console.error('Failed to save security config:', err);
        } finally {
            setSaving(false);
        }
    };

    if (loading) return <div style={{ padding: '24px' }}>Loading governance settings...</div>;

    return (
        <div style={{ padding: '24px' }}>
            <div style={{ marginBottom: '32px' }}>
                <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>Network & Device Governance</h1>
                <p style={{ color: '#6B7280' }}>Manage corporate access policies and device-level security.</p>
            </div>

            <div style={{ display: 'grid', gap: '24px', maxWidth: '800px' }}>
                {/* 1. Network Sovereignty */}
                <div className="pc-card">
                    <div className="pc-card-h">Network Sovereignty (VPN)</div>
                    <div className="pc-card-b">
                        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '20px' }}>
                            <div>
                                <div style={{ fontWeight: '600' }}>Enforce VPN Access</div>
                                <div style={{ fontSize: '12px', color: '#6B7280' }}>Restrict platform access to authorized corporate IP ranges only.</div>
                            </div>
                            <input
                                type="checkbox"
                                checked={config?.enforceVpn}
                                onChange={(e) => setConfig(prev => prev ? { ...prev, enforceVpn: e.target.checked } : null)}
                                style={{ width: '20px', height: '20px' }}
                            />
                        </div>

                        <div>
                            <label style={{ display: 'block', fontSize: '13px', fontWeight: '600', marginBottom: '8px' }}>Authorized IP Ranges (CIDR / Literal)</label>
                            <textarea
                                value={config?.allowedVpnRanges.join('\n')}
                                onChange={(e) => setConfig(prev => prev ? { ...prev, allowedVpnRanges: e.target.value.split('\n').filter(r => r.trim()) } : null)}
                                placeholder="e.g. 192.168.1.*&#10;10.0.0.5"
                                style={{
                                    width: '100%',
                                    height: '100px',
                                    padding: '12px',
                                    borderRadius: '8px',
                                    border: '1px solid #D1D5DB',
                                    fontFamily: 'monospace',
                                    fontSize: '13px'
                                }}
                            />
                            <p style={{ fontSize: '11px', color: '#9CA3AF', marginTop: '4px' }}>Enter one pattern per line. Use * for wildcards.</p>
                        </div>
                    </div>
                </div>

                {/* 2. Device Governance */}
                <div className="pc-card">
                    <div className="pc-card-h">Device Governance</div>
                    <div className="pc-card-b">
                        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '20px' }}>
                            <div>
                                <div style={{ fontWeight: '600' }}>Require Device Approval</div>
                                <div style={{ fontSize: '12px', color: '#6B7280' }}>New devices must be authorized by an administrator before use.</div>
                            </div>
                            <input
                                type="checkbox"
                                checked={config?.requireDeviceApproval}
                                onChange={(e) => setConfig(prev => prev ? { ...prev, requireDeviceApproval: e.target.checked } : null)}
                                style={{ width: '20px', height: '20px' }}
                            />
                        </div>

                        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                            <div>
                                <div style={{ fontWeight: '600' }}>Max Devices Per User</div>
                                <div style={{ fontSize: '12px', color: '#6B7280' }}>Limit the number of unique devices a user can register.</div>
                            </div>
                            <input
                                type="number"
                                value={config?.maxDevicesPerUser}
                                onChange={(e) => setConfig(prev => prev ? { ...prev, maxDevicesPerUser: parseInt(e.target.value) } : null)}
                                style={{
                                    width: '80px',
                                    padding: '8px',
                                    borderRadius: '8px',
                                    border: '1px solid #D1D5DB',
                                    textAlign: 'center'
                                }}
                            />
                        </div>
                    </div>
                </div>

                <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginTop: '12px' }}>
                    <button
                        className="btn primary"
                        onClick={handleSave}
                        disabled={saving}
                        style={{ padding: '12px 32px' }}
                    >
                        {saving ? 'Saving...' : 'Save Configuration'}
                    </button>
                    {successMessage && <span style={{ color: '#059669', fontSize: '14px', fontWeight: '500' }}>{successMessage}</span>}
                </div>
            </div>
        </div>
    );
}

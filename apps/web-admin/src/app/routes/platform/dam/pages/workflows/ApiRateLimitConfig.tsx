import React, { useState } from 'react';
import { Gauge, ShieldAlert, StopCircle, ArrowUpRight, Zap, RefreshCw, Activity } from 'lucide-react';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';

interface RateLimitPolicy {
    id: string;
    tenant: string;
    endpoint: string;
    currentRpm: number;
    hardCapRpm: number;
    action: 'THROTTLE_429' | 'BLOCK_403';
}

export const ApiRateLimitConfig: React.FC = () => {
    const [policies, setPolicies] = useState<RateLimitPolicy[]>([
        { id: '1', tenant: 'GLOBAL', endpoint: '/api/v1/user/reset-password', currentRpm: 12, hardCapRpm: 50, action: 'THROTTLE_429' },
        { id: '2', tenant: 'tx-849', endpoint: '/api/v1/export/patient-records', currentRpm: 45, hardCapRpm: 200, action: 'BLOCK_403' },
        { id: '3', tenant: 'ny-102', endpoint: '/api/v1/sms/send', currentRpm: 125, hardCapRpm: 100, action: 'THROTTLE_429' }
    ]);

    const [isSaving, setIsSaving] = useState(false);
    const { showToast } = useNotification();

    const handleLimitChange = (id: string, newLimit: number) => {
        setPolicies(prev => prev.map(p => p.id === id ? { ...p, hardCapRpm: newLimit } : p));
    };

    const handleSave = async () => {
        setIsSaving(true);
        try {
            await apiClient.post('/platform/admin/dam/workflows/rate-limits', { policies });
            showToast("Rate limiting quotas persisted to Redis cache.", "success");
        } catch (error) {
            showToast("Failed to scale edge throttles", "error");
        } finally {
            setIsSaving(false);
        }
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#FFF7ED', padding: '10px', borderRadius: '8px' }}>
                        <Gauge size={24} color="#F97316" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>API Rate Governance</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Enforce tenant consumption quotas to prevent noisy-neighbor outages.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <button style={{ backgroundColor: 'white', color: '#0F172A', border: '1px solid #CBD5E1', borderRadius: '8px', padding: '8px 16px', fontWeight: 600, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '6px' }}>
                        <RefreshCw size={16} /> Sync Live Traffic
                    </button>
                    <button 
                        onClick={handleSave}
                        disabled={isSaving}
                        style={{ backgroundColor: '#F97316', color: 'white', border: 'none', borderRadius: '8px', padding: '8px 16px', fontWeight: 700, cursor: isSaving ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', gap: '6px' }}
                    >
                        <ShieldAlert size={16} /> {isSaving ? 'Deploying...' : 'Deploy Redis Caps'}
                    </button>
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                {policies.map(policy => {
                    const isBreaching = policy.currentRpm >= policy.hardCapRpm;
                    const fillPercentage = Math.min(100, (policy.currentRpm / policy.hardCapRpm) * 100);

                    return (
                        <div key={policy.id} style={{ 
                            border: `2px solid ${isBreaching ? '#FECACA' : '#E2E8F0'}`, 
                            borderRadius: '8px', 
                            padding: '16px', 
                            backgroundColor: isBreaching ? '#FEF2F2' : 'white'
                        }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
                                <div style={{ flex: 1 }}>
                                    <div style={{ fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                        {policy.endpoint}
                                        {policy.tenant === 'GLOBAL' ? 
                                            <span style={{ backgroundColor: '#1E293B', color: 'white', padding: '2px 6px', borderRadius: '4px', fontSize: '0.65rem' }}>GLOBAL POOL</span>
                                            : <span style={{ backgroundColor: '#E0E7FF', color: '#4338CA', padding: '2px 6px', borderRadius: '4px', fontSize: '0.65rem' }}>TENANT: {policy.tenant}</span>
                                        }
                                    </div>
                                    <div style={{ fontSize: '0.8rem', color: '#64748B', marginTop: '4px' }}>
                                        Exceeding limits will return HTTP {policy.action === 'THROTTLE_429' ? '429 Too Many Requests' : '403 Forbidden'}.
                                    </div>
                                </div>
                                
                                <div style={{ display: 'flex', alignItems: 'center', gap: '16px', width: '250px' }}>
                                    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-end' }}>
                                        <label style={{ fontSize: '0.75rem', fontWeight: 700, color: '#64748B' }}>Permitted RPM</label>
                                        <input 
                                            type="number"
                                            value={policy.hardCapRpm}
                                            onChange={(e) => handleLimitChange(policy.id, parseInt(e.target.value) || 0)}
                                            style={{ width: '80px', padding: '6px 8px', borderRadius: '6px', border: '1px solid #CBD5E1', textAlign: 'right', fontWeight: 800, color: '#0F172A' }}
                                        />
                                    </div>
                                </div>
                            </div>

                            {/* Live Traffic Bar */}
                            <div>
                                <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.75rem', fontWeight: 700, color: isBreaching ? '#DC2626' : '#64748B', marginBottom: '4px' }}>
                                    <span style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
                                        {isBreaching ? <StopCircle size={12} color="#DC2626"/> : <Activity size={12}/>} 
                                        Live Traffic Load ({policy.currentRpm} reqs / minute)
                                    </span>
                                    <span>{fillPercentage.toFixed(0)}% Capacity</span>
                                </div>
                                <div style={{ width: '100%', height: '8px', backgroundColor: '#E2E8F0', borderRadius: '4px', overflow: 'hidden' }}>
                                    <div style={{ 
                                        height: '100%', 
                                        width: `${fillPercentage}%`,
                                        backgroundColor: isBreaching ? '#DC2626' : (fillPercentage > 75 ? '#F59E0B' : '#10B981'),
                                        transition: 'width 0.3s ease'
                                    }} />
                                </div>
                            </div>
                        </div>
                    );
                })}
            </div>

            <div style={{ marginTop: '24px', backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '8px', border: '1px dashed #CBD5E1', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#475569', fontSize: '0.85rem' }}>
                    <Zap size={16} color="#3B82F6" /> Spike Protection is currently <strong>Active</strong>.
                </div>
                <button style={{ background: 'transparent', border: 'none', color: '#3B82F6', fontWeight: 700, fontSize: '0.85rem', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '4px' }}>
                    View Blocked Client IP Logs <ArrowUpRight size={14} />
                </button>
            </div>
        </div>
    );
};

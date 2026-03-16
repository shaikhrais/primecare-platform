import React, { useState } from 'react';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { AlertTriangle, Clock, Activity, UserPlus } from 'lucide-react';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';

interface WaitlistPatient {
    id: string;
    fullName: string;
    riskScore: number;
    daysOnWaitlist: number;
    primaryCondition: string | null;
    location: string;
    status: string;
}

export const TriageHeatmap: React.FC = () => {
    // TanStack Query: auto-cached waitlist data
    const { data: waitlist = [], isLoading: loading } = useRegistryQuery<WaitlistPatient[]>('/v1/manager/intake/waitlist', {
        queryKey: ['manager', 'intake', 'waitlist'],
        staleTime: 30_000,
    });

    // Helper to map DB risk score (0-100) to simple Tiers
    const getAcuityTier = (score: number) => {
        if (score >= 80) return 'high';
        if (score >= 50) return 'medium';
        return 'low';
    };

    // Grouping by Matrix logic (Suggestion 24)
    // X-Axis: Wait Time (0-7 days, 8-14 days, 15+ days)
    // Y-Axis: Acuity (Low, Medium, High)

    const getCellColor = (acuity: string, waitTier: string) => {
        // High Acuity + 15+ Days = Critical Red
        if (acuity === 'high' && waitTier === '15+') return '#DC2626'; // Red
        if (acuity === 'high' && waitTier === '8-14') return '#EF4444';
        if (acuity === 'high' && waitTier === '0-7') return '#F87171';

        // Medium Acuity
        if (acuity === 'medium' && waitTier === '15+') return '#F59E0B'; // Amber
        if (acuity === 'medium' && waitTier === '8-14') return '#FBBF24';
        if (acuity === 'medium' && waitTier === '0-7') return '#FCD34D';

        // Low Acuity
        if (acuity === 'low' && waitTier === '15+') return '#3B82F6'; // Blue
        if (acuity === 'low' && waitTier === '8-14') return '#60A5FA';
        if (acuity === 'low' && waitTier === '0-7') return '#93C5FD';

        return '#E2E8F0';
    };

    const filterPatients = (acuity: string, waitTier: string) => {
        return waitlist.filter(p => {
            const matchesAcuity = getAcuityTier(p.riskScore) === acuity;
            let matchesWait = false;
            if (waitTier === '0-7') matchesWait = p.daysOnWaitlist <= 7;
            if (waitTier === '8-14') matchesWait = p.daysOnWaitlist >= 8 && p.daysOnWaitlist <= 14;
            if (waitTier === '15+') matchesWait = p.daysOnWaitlist >= 15;
            return matchesAcuity && matchesWait;
        });
    };

    const waitTiers = ['0-7', '8-14', '15+'];
    const acuities = ['high', 'medium', 'low'];

    if (loading) {
        return <div style={{ padding: '24px', textAlign: 'center', color: '#64748B' }}>Loading waitlist...</div>;
    }

    return (
        <div style={{ backgroundColor: '#F8FAFC', padding: '24px', borderRadius: '16px', border: '1px solid #E2E8F0', maxWidth: '900px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div>
                    <h2 data-cy="h2-manager.triage-heatmap-0" style={{ fontSize: '1.5rem', fontWeight: 800, margin: '0 0 4px 0', color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px' }}>
                        <Activity color="#EF4444" /> Waitlist Triage Heatmap
                    </h2>
                    <p style={{ color: '#64748B', margin: 0, fontSize: '0.95rem' }}>Visualizing density vs. clinical urgency.</p>
                </div>
                <button data-cy="btn-manager.triage-heatmap-0" style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '10px 20px', backgroundColor: '#0F172A', color: 'white', border: 'none', borderRadius: '8px', fontWeight: 700, cursor: 'pointer' }}>
                    <UserPlus size={18} /> New Intake
                </button>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '100px 1fr', gap: '16px' }}>
                {/* Y-Axis Labels */}
                <div style={{ display: 'flex', flexDirection: 'column', gap: '16px', justifyContent: 'center', paddingTop: '32px' }}>
                    <div style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'flex-end', fontWeight: 800, color: '#DC2626' }}>High Acuity</div>
                    <div style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'flex-end', fontWeight: 800, color: '#D97706' }}>Med Acuity</div>
                    <div style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'flex-end', fontWeight: 800, color: '#2563EB' }}>Low Acuity</div>
                </div>

                <div>
                    {/* X-Axis Labels */}
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: '16px', marginBottom: '8px', textAlign: 'center', fontWeight: 800, color: '#475569' }}>
                        <div>0-7 Days</div>
                        <div>8-14 Days</div>
                        <div>15+ Days Wait <AlertTriangle size={14} color="#EF4444" style={{ display: 'inline', marginLeft: '4px' }} /></div>
                    </div>

                    {/* Matrix Grid */}
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                        {acuities.map((acuity) => (
                            <div key={acuity} style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: '16px' }}>
                                {waitTiers.map((tier) => {
                                    const patients = filterPatients(acuity, tier);
                                    const bgColor = getCellColor(acuity, tier);

                                    return (
                                        <div
                                            key={`${acuity}-${tier}`}
                                            style={{
                                                backgroundColor: bgColor,
                                                minHeight: '100px',
                                                borderRadius: '12px',
                                                padding: '12px',
                                                display: 'flex',
                                                flexDirection: 'column',
                                                gap: '8px',
                                                boxShadow: 'inset 0 2px 4px 0 rgba(0, 0, 0, 0.06)'
                                            }}
                                        >
                                            {patients.length > 0 ? (
                                                patients.map(p => (
                                                    <div key={p.id} style={{ backgroundColor: 'rgba(255,255,255,0.9)', padding: '6px 10px', borderRadius: '6px', fontSize: '0.85rem', fontWeight: 700, color: '#0F172A', display: 'flex', justifyContent: 'space-between', cursor: 'grab' }}>
                                                        <span>{p.fullName}</span>
                                                        <span style={{ color: '#64748B' }}>{p.daysOnWaitlist}d</span>
                                                    </div>
                                                ))
                                            ) : (
                                                <div style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center', opacity: 0.5, fontWeight: 800, color: 'white' }}>Empty</div>
                                            )}
                                        </div>
                                    );
                                })}
                            </div>
                        ))}
                    </div>
                </div>
            </div>

            <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#FEF2F2', border: '1px solid #FECACA', borderRadius: '8px', display: 'flex', gap: '12px', alignItems: 'center' }}>
                <AlertTriangle color="#DC2626" />
                <span style={{ color: '#991B1B', fontWeight: 600 }}>Patients in the top-right quadrant (High Acuity + 15+ Days) are breaching SLA guidelines and require immediate assignment.</span>
            </div>
        </div>
    );
};

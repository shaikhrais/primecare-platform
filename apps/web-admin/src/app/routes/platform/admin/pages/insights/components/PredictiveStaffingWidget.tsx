import React, { useState, useEffect } from 'react';

interface RiskScore {
    userId: string;
    pswId: string;
    name: string;
    score: number;
    riskLevel: 'High' | 'Medium' | 'Low';
    riskFactors: string[];
    totalHours14d: number;
}

export function PredictiveStaffingWidget() {
    const [scores, setScores] = useState<RiskScore[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchScores = async () => {
            try {
                const token = localStorage.getItem('token');
                const res = await fetch(`${import.meta.env.VITE_API_URL}/v1/admin/insights/predictive-staffing`, {
                    headers: {
                        'Authorization': `Bearer ${token}`
                    }
                });
                const json = await res.json();
                if (json.data) {
                    setScores(json.data);
                }
            } catch (e) {
                console.error('Failed to load predictive staffing scores', e);
            } finally {
                setLoading(false);
            }
        };

        fetchScores();
    }, []);

    const getRiskBadge = (level: string) => {
        if (level === 'High') return <span style={{ backgroundColor: '#FEE2E2', color: '#B91C1C', padding: '4px 8px', borderRadius: '4px', fontSize: '12px', fontWeight: '600' }}>⚠️ High Risk</span>;
        if (level === 'Medium') return <span style={{ backgroundColor: '#FFEDD5', color: '#C2410C', padding: '4px 8px', borderRadius: '4px', fontSize: '12px', fontWeight: '600' }}>Medium Risk</span>;
        return <span style={{ backgroundColor: '#ECFDF5', color: '#047857', padding: '4px 8px', borderRadius: '4px', fontSize: '12px', fontWeight: '600' }}>Low Risk</span>;
    };

    return (
        <div className="pc-card" style={{ borderTop: '4px solid #7C3AED' }}>
            <div className="pc-card-h" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div>
                    <h2 data-cy="h2-admin.predictive-staffing-widget-0" style={{ fontSize: '18px', fontWeight: '700', margin: 0 }}>Predictive Staffing: Burnout Risk</h2>
                    <p style={{ fontSize: '14px', color: '#6B7280', margin: '4px 0 0 0', fontWeight: '400' }}>
                        AI-driven analysis of timesheets and incident reports to predict field staff fatigue.
                    </p>
                </div>
                <button data-cy="btn-admin.predictive-staffing-widget-0"
                    onClick={() => window.location.reload()}
                    style={{ padding: '6px 12px', border: '1px solid #D1D5DB', backgroundColor: 'white', borderRadius: '6px', cursor: 'pointer', fontSize: '12px', fontWeight: '500' }}
                >
                    Refresh Model
                </button>
            </div>

            <div className="pc-card-b" style={{ padding: 0 }}>
                {loading ? (
                    <div style={{ padding: '48px', textAlign: 'center', color: '#9CA3AF' }}>
                        Crunching 14-day history...
                    </div>
                ) : scores.length === 0 ? (
                    <div style={{ padding: '48px', textAlign: 'center', color: '#9CA3AF' }}>
                        No active staff data available for prediction.
                    </div>
                ) : (
                    <table data-cy="table-admin.predictive-staffing-widget" style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left', fontSize: '14px' }}>
                        <thead>
                            <tr style={{ backgroundColor: '#F9FAFB', borderBottom: '1px solid #E5E7EB' }}>
                                <th style={{ padding: '12px 16px', fontWeight: '600', color: '#4B5563' }}>Field Staff</th>
                                <th style={{ padding: '12px 16px', fontWeight: '600', color: '#4B5563' }}>Burnout Score</th>
                                <th style={{ padding: '12px 16px', fontWeight: '600', color: '#4B5563' }}>Risk Level</th>
                                <th style={{ padding: '12px 16px', fontWeight: '600', color: '#4B5563' }}>Primary Factors</th>
                                <th style={{ padding: '12px 16px', fontWeight: '600', color: '#4B5563', textAlign: 'right' }}>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            {scores.map((s) => (
                                <tr key={s.userId} style={{ borderBottom: '1px solid #F3F4F6', backgroundColor: s.riskLevel === 'High' ? '#FEF2F2' : 'white' }}>
                                    <td style={{ padding: '12px 16px', fontWeight: '500' }}>{s.name}</td>
                                    <td style={{ padding: '12px 16px' }}>
                                        <div style={{ width: '100px', backgroundColor: '#E5E7EB', height: '8px', borderRadius: '4px', overflow: 'hidden' }}>
                                            <div style={{
                                                height: '100%',
                                                width: `${s.score}%`,
                                                backgroundColor: s.score >= 70 ? '#EF4444' : s.score >= 40 ? '#F59E0B' : '#10B981'
                                            }}></div>
                                        </div>
                                        <span style={{ fontSize: '11px', color: '#6B7280', marginTop: '4px', display: 'block', fontWeight: '500' }}>
                                            {s.score} / 100
                                        </span>
                                    </td>
                                    <td style={{ padding: '12px 16px' }}>{getRiskBadge(s.riskLevel)}</td>
                                    <td style={{ padding: '12px 16px' }}>
                                        <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
                                            {s.riskFactors.map((f, i) => (
                                                <span key={i} style={{ fontSize: '11px', color: '#4B5563', backgroundColor: '#F3F4F6', padding: '2px 6px', borderRadius: '4px', width: 'fit-content' }}>
                                                    {f}
                                                </span>
                                            ))}
                                            {s.riskFactors.length === 0 && <span style={{ fontSize: '11px', color: '#9CA3AF', fontStyle: 'italic' }}>Operating within safe margins</span>}
                                        </div>
                                    </td>
                                    <td style={{ padding: '12px 16px', textAlign: 'right' }}>
                                        <button data-cy="btn-admin.predictive-staffing-widget-1" style={{
                                            padding: '6px 12px',
                                            backgroundColor: s.riskLevel === 'High' ? '#DC2626' : 'transparent',
                                            color: s.riskLevel === 'High' ? 'white' : '#4B5563',
                                            border: s.riskLevel === 'High' ? 'none' : '1px solid #D1D5DB',
                                            borderRadius: '4px',
                                            fontSize: '12px',
                                            fontWeight: '500',
                                            cursor: 'pointer'
                                        }}>
                                            Check In
                                        </button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                )}
            </div>
        </div>
    );
}

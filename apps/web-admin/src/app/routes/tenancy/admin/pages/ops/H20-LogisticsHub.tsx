// ================================================================
// PAGE IDENTITY: H20 � Logistics Hub
// Type: Hub | Owner: admin
// ================================================================
import { useNavigate } from 'react-router-dom';
import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useToast as useNotification } from '@/shared/hooks/useToast';

const { ButtonRegistry, InteractionARegistry } = AdminRegistry;

export default function LogisticsHub() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [isOptimizing, setIsOptimizing] = useState(false);
    const [stats] = useState([
        { id: '1', region: 'Downtown Central', activeVisits: 142, coverage: '98%', status: 'Optimal', demandForecast: '+5%' },
        { id: '2', region: 'North Suburbs', activeVisits: 64, coverage: '85%', status: 'Warning', demandForecast: '+12%' },
        { id: '3', region: 'West Side', activeVisits: 89, coverage: '92%', status: 'Optimal', demandForecast: '-2%' },
    ]);

    const handleOptimize = () => {
        setIsOptimizing(true);
        setTimeout(() => {
            showToast('Predictive routing and capacity rebalanced', 'success');
            setIsOptimizing(false);
        }, 1500);
    };

    const dispatchAction = InteractionARegistry.find((ia: any) => ia.id === 'ia-ops-dispatch-predictive');

    return (
        <div data-cy="page.container" role="main" aria-label="Logistics Hub" style={{ padding: '2rem' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '1.875rem', fontWeight: 'bold', color: '#111827' }}>Logistics Hub</h1>
                    <p style={{ color: '#6b7280' }}>Global monitoring and AI optimization for regional care delivery.</p>
                </div>
                <div style={{ display: 'flex', gap: '12px' }}>
                    <button data-cy="btn-admin.logistics-hub-0"
                        className="btn secondary"
                        onClick={() => navigate('/coordinator/fleet')}
                    >
                        Track Real-time Fleet
                    </button>
                    <button
                        className={`btn ${isOptimizing ? 'secondary' : 'primary'}`}
                        onClick={handleOptimize}
                        disabled={isOptimizing}
                        data-cy="btn-ia-ops-dispatch-predictive"
                    >
                        {isOptimizing ? 'Rebalancing...' : (dispatchAction?.label || 'Launch Predictive Router')}
                    </button>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '24px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ padding: '20px' }}>
                    <div style={{ fontSize: '12px', color: '#6B7280', textTransform: 'uppercase', fontWeight: 'bold' }}>Active Fleet</div>
                    <div style={{ fontSize: '24px', fontWeight: '800', marginTop: '4px' }}>412</div>
                    <div style={{ fontSize: '12px', color: '#10B981', marginTop: '4px' }}>↑ 12% vs last week</div>
                </div>
                <div className="pc-card" style={{ padding: '20px' }}>
                    <div style={{ fontSize: '12px', color: '#6B7280', textTransform: 'uppercase', fontWeight: 'bold' }}>Avg Route Time</div>
                    <div style={{ fontSize: '24px', fontWeight: '800', marginTop: '4px' }}>18.4m</div>
                    <div style={{ fontSize: '12px', color: '#10B981', marginTop: '4px' }}>↓ 2.1m (Optimized)</div>
                </div>
                <div className="pc-card" style={{ padding: '20px' }}>
                    <div style={{ fontSize: '12px', color: '#6B7280', textTransform: 'uppercase', fontWeight: 'bold' }}>Utilization</div>
                    <div style={{ fontSize: '24px', fontWeight: '800', marginTop: '4px' }}>94.2%</div>
                    <div style={{ fontSize: '12px', color: '#6B7280', marginTop: '4px' }}>Healthy Band</div>
                </div>
                <div className="pc-card" style={{ padding: '20px' }}>
                    <div style={{ fontSize: '12px', color: '#6B7280', textTransform: 'uppercase', fontWeight: 'bold' }}>AI Accuracy</div>
                    <div style={{ fontSize: '24px', fontWeight: '800', marginTop: '4px' }}>98.8%</div>
                    <div style={{ fontSize: '12px', color: '#10B981', marginTop: '4px' }}>Dispatch Confidence</div>
                </div>
            </div>

            <div className="pc-card">
                <div className="pc-card-h">Regional Capacity Oversight</div>
                <div className="pc-card-b" style={{ padding: '0' }}>
                    <table data-cy="table-admin.logistics-hub" style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead>
                            <tr style={{ background: '#F9FAFB', borderBottom: '1px solid #e5e7eb', textAlign: 'left', color: '#6B7280', fontSize: '12px' }}>
                                <th style={{ padding: '16px' }}>Region</th>
                                <th style={{ padding: '16px' }}>Active Visits</th>
                                <th style={{ padding: '16px' }}>Staff Coverage</th>
                                <th style={{ padding: '16px' }}>Demand Forecast</th>
                                <th style={{ padding: '16px' }}>Status</th>
                                <th style={{ padding: '16px', textAlign: 'right' }}>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            {stats.map(s => (
                                <tr key={s.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                    <td style={{ padding: '16px', fontWeight: '600' }}>{s.region}</td>
                                    <td style={{ padding: '16px' }}>{s.activeVisits}</td>
                                    <td style={{ padding: '16px' }}>
                                        <div style={{ width: '60px', height: '6px', background: '#E5E7EB', borderRadius: '3px', position: 'relative' }}>
                                            <div style={{ width: s.coverage, height: '100%', background: parseInt(s.coverage) > 90 ? '#10B981' : '#F59E0B', borderRadius: '3px' }}></div>
                                        </div>
                                        <span style={{ fontSize: '11px', color: '#6B7280' }}>{s.coverage}</span>
                                    </td>
                                    <td style={{ padding: '16px', color: s.demandForecast.startsWith('+') ? '#EF4444' : '#10B981' }}>
                                        <strong>{s.demandForecast}</strong>
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <span style={{ fontSize: '0.75rem', fontWeight: 'bold', padding: '0.25rem 0.5rem', borderRadius: '0.25rem', backgroundColor: s.status === 'Optimal' ? '#ecfdf5' : '#fff7ed', color: s.status === 'Optimal' ? '#059669' : '#c2410c' }}>
                                            {s.status}
                                        </span>
                                    </td>
                                    <td style={{ padding: '16px', textAlign: 'right' }}>
                                        <button data-cy="btn-admin.logistics-hub-1" className="btn secondary small">Drilldown</button>
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

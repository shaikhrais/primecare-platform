import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface KPIData {
    pendingCarePlans: number;
    dailyReviewsNeed: number;
    supervisedPswCount: number;
}

interface ClinicalTask {
    id: string;
    type: 'care_plan' | 'incident' | 'review';
    priority: 'high' | 'medium' | 'low';
    description: string;
    targetName: string;
}

export default function RnDashboard() {
    const navigate = useNavigate();
    const [stats, setStats] = useState<KPIData>({ pendingCarePlans: 0, dailyReviewsNeed: 0, supervisedPswCount: 0 });
    const [tasks, setTasks] = useState<ClinicalTask[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const token = localStorage.getItem('token');
                const headers = { 'Authorization': `Bearer ${token}` };

                // Mocking data for now as per dashboard pattern
                setStats({
                    pendingCarePlans: 5,
                    dailyReviewsNeed: 12,
                    supervisedPswCount: 8
                });

                setTasks([
                    { id: '1', type: 'care_plan', priority: 'high', description: 'Review Care Plan update', targetName: 'John Doe' },
                    { id: '2', type: 'review', priority: 'medium', description: 'Verify daily entry notes', targetName: 'Jane Smith' },
                    { id: '3', type: 'incident', priority: 'high', description: 'Address fall incident report', targetName: 'Robert Brown' }
                ]);
            } catch (error) {
                console.error('Failed to load RN dashboard data', error);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []);

    const KPICard = ({ label, value, color, dataCy }: any) => (
        <div className="pc-card" data-cy={dataCy} style={{ padding: '20px', borderLeft: `4px solid ${color}` }}>
            <div style={{ color: 'var(--text-300)', fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '1px', marginBottom: '4px' }}>{label}</div>
            <div style={{ fontSize: '2.2rem', fontWeight: 900, color: 'var(--text-100)', letterSpacing: '1px' }}>{value}</div>
        </div>
    );

    return (
        <div data-cy="page.container">
            <div style={{ marginBottom: '2.5rem' }}>
                <h1 style={{ margin: '0 0 6px 0', fontSize: '34px', letterSpacing: '.2px', color: 'var(--text-100)' }} data-cy="page.title">{ContentRegistry.RN_DASHBOARD.TITLE}</h1>
                <p className="sub" style={{ margin: 0 }} data-cy="page.subtitle">{ContentRegistry.RN_DASHBOARD.SUBTITLE}</p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '20px', marginBottom: '32px' }}>
                <KPICard label={ContentRegistry.RN_DASHBOARD.STATS.PENDING_CARE_PLANS} value={stats.pendingCarePlans} color="#ff9800" dataCy="kpi-pending-plans" />
                <KPICard label={ContentRegistry.RN_DASHBOARD.STATS.DAILY_REVIEWS} value={stats.dailyReviewsNeed} color="#2196f3" dataCy="kpi-daily-reviews" />
                <KPICard label={ContentRegistry.RN_DASHBOARD.STATS.SUPERVISED_PSWS} value={stats.supervisedPswCount} color="#4caf50" dataCy="kpi-psw-count" />
            </div>

            <h2 style={{ fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', marginBottom: '1.5rem', color: 'var(--text-300)' }} data-cy="section.tasks">Pending Clinical Tasks</h2>
            <div className="pc-card">
                <div className="pc-card-b" style={{ padding: '0 24px' }}>
                    {tasks.length === 0 ? (
                        <p data-cy="tasks-empty-message" style={{ color: 'var(--text-300)', textAlign: 'center', padding: '40px' }}>No pending clinical tasks.</p>
                    ) : (
                        tasks.map((task) => (
                            <div key={task.id} data-cy="task-item" style={{ display: 'flex', gap: '20px', padding: '20px 0', borderBottom: '1px solid var(--card-border)', alignItems: 'center' }}>
                                <div style={{
                                    width: '12px',
                                    height: '12px',
                                    borderRadius: '50%',
                                    backgroundColor: task.priority === 'high' ? '#f44336' : task.priority === 'medium' ? '#ff9800' : '#4caf50'
                                }}></div>
                                <div style={{ flex: 1 }}>
                                    <div data-cy="task-description" style={{ fontWeight: 900, color: 'var(--text-100)', fontSize: '1.05rem' }}>{task.description}</div>
                                    <div data-cy="task-target" style={{ fontSize: '0.85rem', color: 'var(--text-300)', marginTop: '2px' }}>Patient: {task.targetName}</div>
                                </div>
                                <button data-cy={`btn-action-${task.id}`} className="btn" style={{ padding: '8px 16px', fontSize: '13px' }}>Resolve Task</button>
                            </div>
                        ))
                    )}
                </div>
            </div>
        </div>
    );
}

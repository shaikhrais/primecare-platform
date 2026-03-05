import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useAuth } from '@/shared/context/AuthContext';
import { apiClient } from '@/shared/utils/apiClient';
import { PatientAcuityDistribution } from '@/shared/components/charts/PatientAcuityDistribution';
import { AssessmentComplianceChart } from '@/shared/components/charts/AssessmentComplianceChart';
import { ClinicalIncidentHeatmap } from '@/shared/components/charts/ClinicalIncidentHeatmap';
import { CarePlanAdherenceGauge } from '@/shared/components/charts/CarePlanAdherenceGauge';
import { MOCK_RN_DATA, MOCK_MANAGER_DATA } from '@/shared/data/mockChartData';
import { useTranslation } from 'react-i18next';

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

const KPICard = ({ label, value, color, dataCy }: any) => (
    <div className="pc-card" data-cy={dataCy} style={{ padding: '20px', borderLeft: `4px solid ${color}` }}>
        <div style={{ color: 'var(--text-300)', fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '1px', marginBottom: '4px' }}>{label}</div>
        <div style={{ fontSize: '2.2rem', fontWeight: 900, color: 'var(--text-100)', letterSpacing: '1px' }}>{value}</div>
    </div>
);

export const Dashboard: React.FC = () => {
    const { t } = useTranslation();
    const navigate = useNavigate();
    const [stats, setStats] = useState<KPIData>({ pendingCarePlans: 0, dailyReviewsNeed: 0, supervisedPswCount: 0 });
    const [chartData, setChartData] = useState<any>(null);
    const [tasks, setTasks] = useState<ClinicalTask[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchData = async () => {
            try {
                // Fetch Stats for Charts
                const statsResponse = await apiClient.get(AdminRegistry.ApiRegistry.RN.DASHBOARD_STATS);

                if (statsResponse.ok) {
                    const data = await statsResponse.json();
                    setChartData(data);

                    if (data.kpi) {
                        setStats(data.kpi);
                    }
                }

                // Inject dynamic clinical tasks
                const carePlansRes = await apiClient.get(AdminRegistry.ApiRegistry.RN.CARE_PLANS);

                if (carePlansRes.ok) {
                    const plans = await carePlansRes.json();
                    const pendingTasks: ClinicalTask[] = plans.filter((p: any) => p.status === 'requires_review').map((p: any) => ({
                        id: p.id,
                        type: 'care_plan',
                        priority: 'high',
                        description: `Review Care Plan update: ${p.diagnoses?.join(', ')}`,
                        targetName: p.client?.fullName || 'Unknown Patient'
                    }));
                    setTasks(pendingTasks);
                }

            } catch (error) {
                console.error('Failed to load RN dashboard data', error);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []);

    if (loading) {
        return (
            <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
                {t(ContentRegistry.RN_DASHBOARD.MESSAGES.LOADING)}
            </div>
        );
    }

    const { user } = useAuth();

    return (
        <div data-cy="page.container">
            <div style={{ marginBottom: '2.5rem' }}>
                <h1 style={{ margin: '0 0 6px 0', fontSize: '34px', letterSpacing: '.2px', color: 'var(--text-100)' }} data-cy="page.title">
                    {user?.tenantId ? 'Clinical Dashboard (Branch)' : t(ContentRegistry.RN_DASHBOARD.TITLE)}
                </h1>
                <p className="sub" style={{ margin: 0 }} data-cy="page.subtitle">
                    {user?.email ? `${user.email} • Registered Nurse` : t(ContentRegistry.RN_DASHBOARD.SUBTITLE)}
                </p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '20px', marginBottom: '32px' }}>
                <KPICard label={t(ContentRegistry.RN_DASHBOARD.STATS.PENDING_CARE_PLANS)} value={stats.pendingCarePlans} color="#ff9800" dataCy="kpi-pending-plans" />
                <KPICard label={t(ContentRegistry.RN_DASHBOARD.STATS.DAILY_REVIEWS)} value={stats.dailyReviewsNeed} color="#2196f3" dataCy="kpi-daily-reviews" />
                <KPICard label={t(ContentRegistry.RN_DASHBOARD.STATS.SUPERVISED_PSWS)} value={stats.supervisedPswCount} color="#4caf50" dataCy="kpi-psw-count" />
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '20px', marginBottom: '30px' }}>
                <PatientAcuityDistribution data={(chartData?.patientAcuity?.length > 0) ? chartData.patientAcuity : MOCK_RN_DATA.acuity} isDemo={!chartData?.patientAcuity?.length} />
                <AssessmentComplianceChart data={(chartData?.compliance?.length > 0) ? chartData.compliance : MOCK_RN_DATA.compliance} isDemo={!chartData?.compliance?.length} />
                <ClinicalIncidentHeatmap data={(chartData?.incidents?.length > 0) ? chartData.incidents : MOCK_RN_DATA.incidents} isDemo={!chartData?.incidents?.length} />
                <CarePlanAdherenceGauge data={(chartData?.carePlanAdherence?.length > 0) ? chartData.carePlanAdherence : MOCK_MANAGER_DATA.carePlanAdherence} isDemo={!chartData?.carePlanAdherence?.length} />
            </div>

            <h2 style={{ fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', marginBottom: '1.5rem', color: 'var(--text-300)' }} data-cy="section.tasks">
                {t(ContentRegistry.RN_DASHBOARD.TASKS.TITLE)}
            </h2>
            <div className="pc-card">
                <div className="pc-card-b" style={{ padding: '0 24px' }}>
                    {tasks.length === 0 ? (
                        <p data-cy="tasks-empty-message" style={{ color: 'var(--text-300)', textAlign: 'center', padding: '40px' }}>
                            {t(ContentRegistry.RN_DASHBOARD.TASKS.EMPTY)}
                        </p>
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
                                    <div data-cy="task-target" style={{ fontSize: '0.85rem', color: 'var(--text-300)', marginTop: '2px' }}>
                                        {t(ContentRegistry.RN_DASHBOARD.TASKS.PATIENT_LABEL)}{task.targetName}
                                    </div>
                                </div>
                                <button data-cy={`btn-action-${task.id}`} className="btn" style={{ padding: '8px 16px', fontSize: '13px' }}>
                                    {t(ContentRegistry.RN_DASHBOARD.TASKS.RESOLVE_BTN)}
                                </button>
                            </div>
                        ))
                    )}
                </div>
            </div>
        </div>
    );
};

export default Dashboard;

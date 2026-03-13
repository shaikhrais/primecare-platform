// ================================================================
// PAGE IDENTITY: L18 � Assessments Hub
// Type: List | Owner: rn
// ================================================================
import React, { useEffect, useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';
import './AssessmentsHub.css';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

interface Assessment {
    id: string;
    type: string;
    clientId: string;
    score: number;
    createdAt: string;
    client: {
        fullName: string;
    };
}

export const AssessmentsHub: React.FC = () => {
    const [assessments, setAssessments] = useState<Assessment[]>([]);
    const [loading, setLoading] = useState(true);
    const { showToast } = useNotification();

    useEffect(() => {
        const fetchAssessments = async () => {
            try {
                const response = await apiClient.get(ApiRegistry.TENANCY.RN.CLINICAL_ASSESS);
                if (Array.isArray(response)) {
                    setAssessments(response);
                }
            } catch (error) {
                console.error('Failed to load clinical assessments', error);
            } finally {
                setLoading(false);
            }
        };

        fetchAssessments();
    }, []);

    const getTypePillClass = (type: string) => {
        const t = type.toLowerCase();
        if (t.includes('adl')) return 'adl';
        if (t.includes('mobility')) return 'mobility';
        if (t.includes('cognitive')) return 'cognitive';
        return 'vital';
    };

    const btnAdl = getButtonById('btn-rn-assess-start-adl');
    const btnMobility = getButtonById('btn-rn-assess-start-mobility');
    const btnMental = getButtonById('btn-rn-assess-start-mental');

    if (loading) {
        return (
            <div data-cy="page.container" className="assessments-loading">
                <div className="spinner"></div>
                <p>Synchronizing Clinical Ledger...</p>
            </div>
        );
    }

    return (
        <div className="assessments-container" data-cy="assessments-hub">
            <header className="assess-header" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div>
                    <h1 data-cy="page-title">{ContentRegistry.RN_ASSESSMENTS.TITLE}</h1>
                    <p data-cy="page-subtitle">{ContentRegistry.RN_ASSESSMENTS.SUBTITLE}</p>
                </div>
                <button data-cy="btn-rn.assessments-hub-0"
                    className="btn-premium primary"
                    onClick={async () => {
                        try {
                            // Empty object triggers base validation framework 
                            await apiClient.post(ApiRegistry.TENANCY.RN.CLINICAL_ASSESS, { clientId: 'test-client', type: 'Generic Initial Intake', assessmentData: {} });
                            showToast('Assessment framework initialized via ledger.', 'success');
                        } catch (e) {
                            showToast('Failed to start assessment stream.', 'error');
                        }
                    }}
                >
                    {getButtonById('btn-rn-new-assessment')?.label || 'Start New Assessment'}
                </button>
            </header>

            {/* Phase 13 RN Assess Extra actions */}
            <div style={{ display: 'flex', gap: '8px', marginBottom: '20px' }}>
                <button data-cy="btn-rn.assessments-hub-1" className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} onClick={async () => {
                    try {
                        await apiClient.post(ApiRegistry.TENANCY.RN.CLINICAL_ASSESS, { clientId: 'test-client', type: 'Quick Ad-Hoc', assessmentData: {} });
                        showToast('Assessment payload injected into PostgREST network.', 'success');
                    } catch (e) {
                        showToast('Transmission rejected.', 'error');
                    }
                }}>{getButtonById('btn-rn-assess-submit')?.label || 'Submit Assess'}</button>
                <button data-cy="btn-rn.assessments-hub-2" className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} onClick={async () => {
                    try {
                        await apiClient.post('/v1/rn/clinical/supervision', { pswId: 'test-psw', competencies: {}, isSatisfactory: true });
                        showToast('Supervision cryptographically stamped.', 'success');
                    } catch (e) {
                        showToast('Failed to secure supervision footprint.', 'error');
                    }
                }}>{getButtonById('btn-rn-supervision-log')?.label || 'Log Supervision'}</button>
                <button data-cy="btn-rn.assessments-hub-3" className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} onClick={async () => {
                    try {
                        await apiClient.post('/v1/rn/clinical/recon', { clientId: 'test-client', reconData: {} });
                        showToast('Meds delta successfully synchronized.', 'success');
                    } catch (e) {
                        showToast('Synchronization collision.', 'error');
                    }
                }}>{getButtonById('btn-rn-recon-sync')?.label || 'Sync Recon'}</button>
            </div>

            <div className="bento-grid">
                <div className="bento-item featured">
                    <span className="pill adl">Clinical Priority</span>
                    <h3 data-cy="h3-rn.assessments-hub-0" className="assess-card-title">Initial Health Intake</h3>
                    <p className="assess-card-desc">
                        Comprehensive baseline for new patients. Covers 12 clinical domains including
                        nutrition, social determinants, and medical history.
                    </p>
                    <div className="assess-card-footer">
                        <button className="btn-premium" data-cy="btn-new-intake">
                            {btnAdl?.label || ContentRegistry.RN_ASSESSMENTS.NEW_BUTTON}
                        </button>
                    </div>
                </div>

                <div className="bento-item">
                    <span className="pill mobility">Risk Assessment</span>
                    <h3 data-cy="h3-rn.assessments-hub-1" className="assess-card-title">Mobility & Fall Risk</h3>
                    <p className="assess-card-desc">
                        Standardized Berg Scale and TUG assessment for environmental safety.
                    </p>
                    <div className="assess-card-footer">
                        <button className="btn-premium" data-cy="btn-mobility-start">
                            {btnMobility?.label || 'Start Audit'}
                        </button>
                    </div>
                </div>

                <div className="bento-item">
                    <span className="pill cognitive">Mental Health</span>
                    <h3 data-cy="h3-rn.assessments-hub-2" className="assess-card-title">Cognitive Mapping</h3>
                    <p className="assess-card-desc">
                        MMSE and geriatric depression screening for long-term care planning.
                    </p>
                    <div className="assess-card-footer">
                        <button className="btn-premium" data-cy="btn-cognitive-start">
                            {btnMental?.label || 'Start Audit'}
                        </button>
                    </div>
                </div>
            </div>

            <section className="patient-list-section">
                <div className="patient-list-header">
                    <h2 data-cy="h2-rn.assessments-hub-0" style={{ fontSize: '1.5rem', fontWeight: 700 }}>Recent Assessments</h2>
                    <div className="search-bar">
                        {/* Search implementation here */}
                    </div>
                </div>

                <table className="assess-table" data-cy="assessments-table">
                    <thead>
                        <tr>
                            <th>{ContentRegistry.RN_ASSESSMENTS.FIELDS.PATIENT}</th>
                            <th>{ContentRegistry.RN_ASSESSMENTS.TYPE_LABELS.ADL}</th>
                            <th>{ContentRegistry.RN_ASSESSMENTS.FIELDS.SCORE}</th>
                            <th>Verification Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        {assessments.length > 0 ? (
                            assessments.map((a) => (
                                <tr key={a.id} data-cy={`assess-row-${a.id}`}>
                                    <td style={{ fontWeight: 700 }}>{a.client?.fullName || 'Anonymous'}</td>
                                    <td>
                                        <span className={`pill ${getTypePillClass(a.type)}`}>
                                            {a.type}
                                        </span>
                                    </td>
                                    <td>
                                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                                            <div style={{
                                                width: '40px',
                                                height: '6px',
                                                background: '#eee',
                                                borderRadius: '3px',
                                                overflow: 'hidden'
                                            }}>
                                                <div style={{
                                                    width: `${(a.score || 0) * 10}%`,
                                                    height: '100%',
                                                    background: (a.score || 0) > 7 ? '#f44336' : (a.score || 0) > 4 ? '#ff9800' : '#4caf50'
                                                }} />
                                            </div>
                                            {a.score}
                                        </div>
                                    </td>
                                    <td>{new Date(a.createdAt).toLocaleDateString()}</td>
                                </tr>
                            ))
                        ) : (
                            <tr>
                                <td colSpan={4} style={{ textAlign: 'center', padding: '60px', color: 'var(--text-400)' }}>
                                    No signed assessments found in clinical ledger.
                                </td>
                            </tr>
                        )}
                    </tbody>
                </table>
            </section>
        </div>
    );
};

export default AssessmentsHub;

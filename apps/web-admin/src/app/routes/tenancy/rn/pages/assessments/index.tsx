import React, { useEffect, useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
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

    if (loading) {
        return (
            <div className="assessments-loading">
                <div className="spinner"></div>
                <p>Synchronizing Clinical Ledger...</p>
            </div>
        );
    }

    return (
        <div className="assessments-container" data-cy="assessments-hub">
            <header className="assess-header">
                <h1 data-cy="page-title">{ContentRegistry.RN_ASSESSMENTS.TITLE}</h1>
                <p data-cy="page-subtitle">{ContentRegistry.RN_ASSESSMENTS.SUBTITLE}</p>
            </header>

            <div className="bento-grid">
                <div className="bento-item featured">
                    <span className="pill adl">Clinical Priority</span>
                    <h3 className="assess-card-title">Initial Health Intake</h3>
                    <p className="assess-card-desc">
                        Comprehensive baseline for new patients. Covers 12 clinical domains including
                        nutrition, social determinants, and medical history.
                    </p>
                    <div className="assess-card-footer">
                        <button className="btn-premium" data-cy="btn-new-intake">
                            {ContentRegistry.RN_ASSESSMENTS.NEW_BUTTON}
                        </button>
                    </div>
                </div>

                <div className="bento-item">
                    <span className="pill mobility">Risk Assessment</span>
                    <h3 className="assess-card-title">Mobility & Fall Risk</h3>
                    <p className="assess-card-desc">
                        Standardized Berg Scale and TUG assessment for environmental safety.
                    </p>
                    <div className="assess-card-footer">
                        <button className="btn-premium" data-cy="btn-mobility-start">Start Audit</button>
                    </div>
                </div>

                <div className="bento-item">
                    <span className="pill cognitive">Mental Health</span>
                    <h3 className="assess-card-title">Cognitive Mapping</h3>
                    <p className="assess-card-desc">
                        MMSE and geriatric depression screening for long-term care planning.
                    </p>
                    <div className="assess-card-footer">
                        <button className="btn-premium" data-cy="btn-cognitive-start">Start Audit</button>
                    </div>
                </div>
            </div>

            <section className="patient-list-section">
                <div className="patient-list-header">
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 700 }}>Recent Assessments</h2>
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

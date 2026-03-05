import React, { useEffect, useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import './EntryVerify.css';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

interface AuditEntry {
    id: string;
    visitId: string;
    psw: {
        fullName: string;
    };
    client: {
        fullName: string;
    };
    visitTime: string;
    highlights: string;
    verificationStatus: string;
}

export const EntryVerify: React.FC = () => {
    const [entries, setEntries] = useState<AuditEntry[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchEntries();
    }, []);

    const fetchEntries = async () => {
        try {
            setLoading(true);
            const response = await apiClient.get(ApiRegistry.TENANCY.RN.DAILY_AUDIT_LIST);
            if (Array.isArray(response)) {
                setEntries(response);
            }
        } catch (error) {
            console.error('Failed to load audit entries', error);
        } finally {
            setLoading(false);
        }
    };

    const handleVerify = async (entry: AuditEntry) => {
        try {
            await apiClient.post(ApiRegistry.TENANCY.RN.DAILY_AUDIT_SIGN_OFF, {
                visitId: entry.visitId,
                status: 'verified',
                clinicalComment: 'Verified via Phase 1 Foundation Sync.'
            });
            // Refresh list
            fetchEntries();
        } catch (error) {
            console.error('Failed to verify entry', error);
            alert('Verification failed. Technical audit logs updated.');
        }
    };

    if (loading) {
        return (
            <div className="audit-loading">
                <p>Retrieving Clinical Ledger...</p>
            </div>
        );
    }

    return (
        <div className="audit-container" data-cy="audit-ledger">
            <header className="assess-header">
                <h1 data-cy="page-title">{ContentRegistry.RN_DAILY_AUDIT.TITLE}</h1>
                <p data-cy="page-subtitle">{ContentRegistry.RN_DAILY_AUDIT.SUBTITLE}</p>
            </header>

            <div className="audit-stack">
                {entries.length > 0 ? (
                    entries.map((entry) => (
                        <div key={entry.id} className="audit-card" data-cy={`audit-card-${entry.id}`}>
                            <div className="audit-card-main">
                                <div className="audit-card-meta">
                                    <span className="visit-tag">{entry.visitId}</span>
                                    <span style={{ color: 'var(--text-400)', fontSize: '0.8rem' }}>{new Date(entry.visitTime).toLocaleString()}</span>
                                </div>
                                <h3 style={{ fontSize: '1.25rem', fontWeight: 800, margin: '8px 0' }}>{entry.client?.fullName}</h3>
                                <p style={{ fontSize: '0.9rem', color: 'var(--text-400)' }}>
                                    Documented by <b style={{ color: 'var(--text-200)' }}>{entry.psw?.fullName}</b>
                                </p>
                                <div className="audit-card-content">
                                    {entry.highlights}
                                </div>
                            </div>

                            <div className="audit-card-actions">
                                <button
                                    className="btn-premium"
                                    data-cy={`btn-verify-${entry.id}`}
                                    onClick={() => handleVerify(entry)}
                                >
                                    {ContentRegistry.RN_DAILY_AUDIT.VERIFY_BUTTON}
                                </button>
                                <button className="btn btn-ghost" style={{ fontSize: '12px' }}>Flag for Review</button>
                                <button className="btn btn-ghost" style={{ fontSize: '12px', color: 'var(--brand-primary)' }}>Full Visit Profile →</button>
                            </div>
                        </div>
                    ))
                ) : (
                    <div className="audit-empty-state">
                        <div className="audit-empty-icon">✅</div>
                        <h3 className="assess-card-title">Daily Audit in Good Standing</h3>
                        <p className="assess-card-desc">No high-risk entries requiring clinical intervention detected.</p>
                    </div>
                )}
            </div>
        </div>
    );
};

export default EntryVerify;

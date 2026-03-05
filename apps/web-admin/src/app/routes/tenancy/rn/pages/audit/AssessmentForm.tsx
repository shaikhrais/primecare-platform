import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

export const AssessmentForm: React.FC = () => {
    const { t } = useTranslation();
    const [clientId, setClientId] = useState('');
    const [type, setType] = useState('ADL');
    const [score, setScore] = useState(0);
    const [recommendations, setRecommendations] = useState('');
    const [saving, setSaving] = useState(false);

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setSaving(true);
        try {
            const token = localStorage.getItem('token');
            const res = await fetch(`${import.meta.env.VITE_API_URL}${ApiRegistry.RN.CLINICAL_ASSESS}`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    clientId,
                    type,
                    assessmentData: { score, timestamp: new Date().toISOString() },
                    score,
                    recommendations
                })
            });
            if (res.ok) {
                alert(t(ContentRegistry.RN_CLINICAL.SUCCESS.ASSESS_SAVED));
            }
        } catch (err) {
            console.error('Assessment submission failed', err);
        } finally {
            setSaving(false);
        }
    };

    return (
        <div data-cy="page.container">
            <h1 style={{ fontSize: '34px', fontWeight: 900, marginBottom: '8px' }}>
                {t(ContentRegistry.RN_CLINICAL.ASSESSMENT_TITLE)}
            </h1>
            <p style={{ color: 'var(--text-300)', marginBottom: '40px' }}>
                {t(ContentRegistry.RN_CLINICAL.ASSESSMENT_SUBTITLE)}
            </p>

            <form onSubmit={handleSubmit} className="pc-card bento-item" style={{ maxWidth: '600px', padding: '40px' }}>
                <div style={{ display: 'grid', gap: '32px' }}>
                    <div className="group">
                        <label className="pc-label">{t(ContentRegistry.RN_CLINICAL.LABELS.PATIENT)}</label>
                        <input
                            className="pc-input"
                            style={{ width: '100%' }}
                            value={clientId}
                            onChange={(e) => setClientId(e.target.value)}
                            placeholder="Client ID..."
                            required
                        />
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '20px' }}>
                        <div className="group">
                            <label className="pc-label">{t(ContentRegistry.RN_CLINICAL.LABELS.TYPE)}</label>
                            <select
                                className="pc-input"
                                style={{ width: '100%' }}
                                value={type}
                                onChange={(e) => setType(e.target.value)}
                            >
                                <option value="ADL">ADL (Daily Living)</option>
                                <option value="MOBILITY">Mobility / Gait</option>
                                <option value="COGNITIVE">Cognitive Function</option>
                            </select>
                        </div>
                        <div className="group">
                            <label className="pc-label">{t(ContentRegistry.RN_CLINICAL.LABELS.SCORE)} (1-10)</label>
                            <input
                                type="number"
                                className="pc-input"
                                style={{ width: '100%' }}
                                value={score}
                                min="1"
                                max="10"
                                onChange={(e) => setScore(Number(e.target.value))}
                            />
                        </div>
                    </div>

                    <div className="group">
                        <label className="pc-label">{t(ContentRegistry.RN_CLINICAL.LABELS.NOTES)}</label>
                        <textarea
                            className="pc-input"
                            style={{ width: '100%', minHeight: '120px' }}
                            value={recommendations}
                            onChange={(e) => setRecommendations(e.target.value)}
                            placeholder="Clinical observations and next steps..."
                        />
                    </div>

                    <button
                        type="submit"
                        className="btn btn-primary"
                        disabled={saving}
                        style={{ padding: '16px' }}
                    >
                        {saving ? 'Transmitting...' : t(ContentRegistry.RN_CLINICAL.ASSESSMENT_TITLE)}
                    </button>
                </div>
            </form>
        </div>
    );
};

export default AssessmentForm;

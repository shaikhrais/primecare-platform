import React, { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';
import { AdminRegistry } from 'prime-care-shared';

const { ApiRegistry, ContentRegistry, RouteRegistry } = AdminRegistry;
import { apiClient } from '@/shared/utils/apiClient';

export default function IncidentEntryForm() {
    const { id } = useParams();
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    const [formData, setFormData] = useState({
        type: 'Medical',
        severity: 'Low',
        description: '',
        location: '',
        clientName: '',
        pswName: '',
        reportedAt: new Date().toISOString().slice(0, 16)
    });

    useEffect(() => {
        if (id) {
            // Fetch logic if editing
        }
    }, [id]);

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setSubmitting(true);
        try {
            const response = await apiClient.post(ApiRegistry.ADMIN.INCIDENTS, formData);

            if (response.ok) {
                showToast(ContentRegistry.INCIDENTS.FORM.SUCCESS_MSG, 'success');
                setIsDirty(false);
                navigate(RouteRegistry.INCIDENTS);
            } else {
                showToast(ContentRegistry.INCIDENTS.FORM.ERROR_MSG, 'error');
            }
        } catch (error) {
            showToast(ContentRegistry.COMMON.NETWORK_ERROR, 'error');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '2rem' }} data-cy="form.incident.page">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', maxWidth: '400px', textAlign: 'center' }}>
                        <h2>{ContentRegistry.INCIDENTS.RESOLVE.DISCARD_TITLE}</h2>
                        <p style={{ opacity: 0.8, marginBottom: '24px' }}>{ContentRegistry.INCIDENTS.RESOLVE.DISCARD_DESC}</p>
                        <div style={{ display: 'flex', gap: '16px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>{ContentRegistry.USERS.MODAL.DISCARD_BTN}</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>{ContentRegistry.USERS.MODAL.STAY_BTN}</button>
                        </div>
                    </div>
                </div>
            )}

            <div style={{ marginBottom: '2rem' }} data-cy="page.header">
                <h2 style={{ fontSize: '1.75rem', fontWeight: 'bold' }} data-cy="page.title">{ContentRegistry.INCIDENTS.FORM.TITLE}</h2>
                <p style={{ color: '#6b7280' }}>{ContentRegistry.INCIDENTS.SUBTITLE}</p>
            </div>

            <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>{ContentRegistry.INCIDENTS.FORM.TYPE_LABEL}</label>
                        <select
                            data-cy="form.incident.type"
                            value={formData.type}
                            onChange={(e) => { setFormData({ ...formData, type: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        >
                            <option>Medical</option>
                            <option>Behavioral</option>
                            <option>Operational</option>
                            <option>Safety</option>
                        </select>
                    </div>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>{ContentRegistry.INCIDENTS.FORM.SEVERITY_LABEL}</label>
                        <select
                            data-cy="form.incident.severity"
                            value={formData.severity}
                            onChange={(e) => { setFormData({ ...formData, severity: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        >
                            <option>Low</option>
                            <option>Medium</option>
                            <option>High</option>
                            <option>Critical</option>
                        </select>
                    </div>
                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>{ContentRegistry.INCIDENTS.FORM.DESC_LABEL}</label>
                        <textarea
                            data-cy="form.incident.description"
                            required
                            value={formData.description}
                            onChange={(e) => { setFormData({ ...formData, description: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '120px' }}
                        />
                    </div>
                </div>

                <div style={{ marginTop: '2.5rem', display: 'flex', justifyContent: 'flex-end', gap: '1rem' }}>
                    <button
                        type="button"
                        onClick={() => isDirty ? setShowGuard(true) : navigate(-1)}
                        data-cy="btn-cancel"
                        style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}
                    >
                        {ContentRegistry.USERS.FORM.BTN_CANCEL}
                    </button>
                    <button
                        type="submit"
                        disabled={submitting}
                        data-cy="form.incident.save"
                        style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: 'none', background: '#e11d48', color: 'white', fontWeight: 'bold', cursor: 'pointer' }}
                    >
                        {submitting ? ContentRegistry.INCIDENTS.FORM.REPORTING : ContentRegistry.INCIDENTS.FORM.SUBMIT_BTN}
                    </button>
                </div>
            </form>
        </div>
    );
}

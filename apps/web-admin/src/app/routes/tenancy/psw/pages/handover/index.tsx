import React, { useState, useEffect } from 'react';
import { AdminRegistry, ContentRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { useNavigate } from 'react-router-dom';
import { apiClient } from '@/shared/utils/apiClient';
import './HandoverPage.css';

const CONTENT = ContentRegistry.PSW_HANDOVER;
const API = AdminRegistry.ApiRegistry.PSW;

export default function HandoverPage() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [visits, setVisits] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const [submitting, setSubmitting] = useState(false);

    const [formData, setFormData] = useState({
        visitId: '',
        handoverNotes: '',
        safetyConcerns: '',
        suppliesNeeded: ''
    });

    useEffect(() => {
        const fetchVisits = async () => {
            try {
                const response = await apiClient.get(API.VISITS);
                if (response.ok) {
                    const data = await response.json();
                    setVisits(data.filter((v: any) => v.status === 'completed' || v.status === 'in_progress'));
                }
            } catch (error) {
                showToast('Failed to load visits', 'error');
            } finally {
                setLoading(false);
            }
        };
        fetchVisits();
    }, []);

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!formData.visitId) {
            showToast('Please select a visit', 'error');
            return;
        }

        setSubmitting(true);
        try {
            const response = await apiClient.post(API.HANDOVER_SUBMIT, formData);

            if (response.ok) {
                showToast(CONTENT.SUCCESS_MSG, 'success');
                navigate(AdminRegistry.RouteRegistry.PSW.DASHBOARD);
            } else {
                showToast(CONTENT.ERROR_MSG, 'error');
            }
        } catch (error) {
            showToast('Submission error', 'error');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div className="handover-page-container">
            <div className="handover-card">
                <header className="handover-header">
                    <h1>{CONTENT.TITLE}</h1>
                    <p>{CONTENT.SUBTITLE}</p>
                </header>

                <form className="handover-form" onSubmit={handleSubmit}>
                    <div className="form-group">
                        <label>{CONTENT.LABEL_VISIT}</label>
                        <select
                            className="form-control"
                            value={formData.visitId}
                            onChange={(e) => setFormData({ ...formData, visitId: e.target.value })}
                            required
                        >
                            <option value="">-- Choose Visit --</option>
                            {visits.map(v => (
                                <option key={v.id} value={v.id}>
                                    {new Date(v.requestedStartAt).toLocaleDateString()} - {v.client?.fullName || 'Registry Node'}
                                </option>
                            ))}
                        </select>
                    </div>

                    <div className="form-group">
                        <label>{CONTENT.LABEL_NOTES}</label>
                        <textarea
                            className="form-control"
                            value={formData.handoverNotes}
                            onChange={(e) => setFormData({ ...formData, handoverNotes: e.target.value })}
                            placeholder={CONTENT.PLACEHOLDER_NOTES}
                            required
                        />
                    </div>

                    <div className="form-group">
                        <label style={{ color: '#ef4444' }}>{CONTENT.LABEL_SAFETY}</label>
                        <textarea
                            className="form-control safety-group"
                            value={formData.safetyConcerns}
                            onChange={(e) => setFormData({ ...formData, safetyConcerns: e.target.value })}
                            placeholder="Any risks noted (falls, behavior, environment)..."
                        />
                    </div>

                    <div className="form-group">
                        <label style={{ color: '#10b981' }}>{CONTENT.LABEL_SUPPLIES}</label>
                        <textarea
                            className="form-control supplies-group"
                            value={formData.suppliesNeeded}
                            onChange={(e) => setFormData({ ...formData, suppliesNeeded: e.target.value })}
                            placeholder="Gloves, medication resupply, etc..."
                        />
                    </div>

                    <div className="handover-actions">
                        <button
                            type="button"
                            className="btn btn-secondary"
                            onClick={() => navigate(-1)}
                        >
                            Cancel
                        </button>
                        <button
                            type="submit"
                            className="btn btn-primary"
                            disabled={submitting || loading}
                        >
                            {submitting ? 'Submitting...' : (AdminRegistry.ButtonRegistry.find(b => b.id === 'btn-psw-handover-submit')?.label || 'Complete Handover')}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
}


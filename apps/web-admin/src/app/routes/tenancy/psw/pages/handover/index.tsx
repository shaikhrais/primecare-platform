import React, { useState, useEffect } from 'react';
import { AdminRegistry, ContentRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { useNavigate } from 'react-router-dom';

const API_URL = import.meta.env.VITE_API_URL;
const CONTENT = ContentRegistry.PSW_HANDOVER;

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
                const token = localStorage.getItem('token');
                const response = await fetch(`${API_URL}/v1/psw/schedule`, {
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                const data = await response.json();
                setVisits(data.filter((v: any) => v.status === 'completed' || v.status === 'in_progress'));
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
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}/v1/psw/handover`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });

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
        <div style={{ maxWidth: '800px', margin: '2rem auto', padding: '0 1rem' }}>
            <div style={{
                background: 'rgba(255, 255, 255, 0.7)',
                backdropFilter: 'blur(10px)',
                borderRadius: '24px',
                padding: '3rem',
                boxShadow: '0 8px 32px rgba(0, 0, 0, 0.1)',
                border: '1px solid rgba(255, 255, 255, 0.3)'
            }}>
                <div style={{ marginBottom: '2.5rem' }}>
                    <h1 style={{
                        fontSize: '2.5rem',
                        fontWeight: 800,
                        background: 'linear-gradient(135deg, #004d40 0%, #00acc1 100%)',
                        WebkitBackgroundClip: 'text',
                        WebkitTextFillColor: 'transparent',
                        marginBottom: '0.5rem'
                    }}>
                        {CONTENT.TITLE}
                    </h1>
                    <p style={{ color: '#546e7a', fontSize: '1.1rem' }}>
                        {CONTENT.SUBTITLE}
                    </p>
                </div>

                <form onSubmit={handleSubmit}>
                    <div style={{ display: 'grid', gap: '2rem' }}>
                        <div>
                            <label style={{ display: 'block', marginBottom: '0.75rem', fontWeight: 600, color: '#263238' }}>{CONTENT.LABEL_VISIT}</label>
                            <select
                                value={formData.visitId}
                                onChange={(e) => setFormData({ ...formData, visitId: e.target.value })}
                                style={{
                                    width: '100%',
                                    padding: '1rem',
                                    borderRadius: '12px',
                                    border: '1px solid #cfd8dc',
                                    background: 'white',
                                    fontSize: '1rem'
                                }}
                                required
                            >
                                <option value="">-- Choose Visit --</option>
                                {visits.map(v => (
                                    <option key={v.id} value={v.id}>
                                        {new Date(v.requestedStartAt).toLocaleDateString()} - {v.client.fullName}
                                    </option>
                                ))}
                            </select>
                        </div>

                        <div>
                            <label style={{ display: 'block', marginBottom: '0.75rem', fontWeight: 600, color: '#263238' }}>{CONTENT.LABEL_NOTES}</label>
                            <textarea
                                value={formData.handoverNotes}
                                onChange={(e) => setFormData({ ...formData, handoverNotes: e.target.value })}
                                placeholder={CONTENT.PLACEHOLDER_NOTES}
                                style={{
                                    width: '100%',
                                    padding: '1.25rem',
                                    borderRadius: '12px',
                                    border: '1px solid #cfd8dc',
                                    minHeight: '150px',
                                    fontSize: '1rem',
                                    lineHeight: '1.6'
                                }}
                                required
                            />
                        </div>

                        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '2rem' }}>
                            <div>
                                <label style={{ display: 'block', marginBottom: '0.75rem', fontWeight: 600, color: '#c62828' }}>{CONTENT.LABEL_SAFETY}</label>
                                <textarea
                                    value={formData.safetyConcerns}
                                    onChange={(e) => setFormData({ ...formData, safetyConcerns: e.target.value })}
                                    placeholder="Any risks noted (falls, behavior, environment)..."
                                    style={{
                                        width: '100%',
                                        padding: '1rem',
                                        borderRadius: '12px',
                                        border: '1px solid #ffcdd2',
                                        minHeight: '100px',
                                        background: '#fff9f9'
                                    }}
                                />
                            </div>
                            <div>
                                <label style={{ display: 'block', marginBottom: '0.75rem', fontWeight: 600, color: '#00695c' }}>{CONTENT.LABEL_SUPPLIES}</label>
                                <textarea
                                    value={formData.suppliesNeeded}
                                    onChange={(e) => setFormData({ ...formData, suppliesNeeded: e.target.value })}
                                    placeholder="Gloves, medication resupply, etc..."
                                    style={{
                                        width: '100%',
                                        padding: '1rem',
                                        borderRadius: '12px',
                                        border: '1px solid #b2dfdb',
                                        minHeight: '100px',
                                        background: '#f4fbfb'
                                    }}
                                />
                            </div>
                        </div>
                    </div>

                    <div style={{ marginTop: '3.5rem', display: 'flex', gap: '1.5rem' }}>
                        <button
                            type="button"
                            onClick={() => navigate(-1)}
                            style={{
                                flex: 1,
                                padding: '1.25rem',
                                borderRadius: '14px',
                                border: '1px solid #cfd8dc',
                                background: 'transparent',
                                fontWeight: 600,
                                cursor: 'pointer',
                                transition: 'all 0.2s'
                            }}
                        >
                            Cancel
                        </button>
                        <button
                            type="submit"
                            disabled={submitting || loading}
                            style={{
                                flex: 2,
                                padding: '1.25rem',
                                borderRadius: '14px',
                                border: 'none',
                                background: 'linear-gradient(135deg, #004d40 0%, #00695c 100%)',
                                color: 'white',
                                fontWeight: 700,
                                fontSize: '1.1rem',
                                cursor: 'pointer',
                                boxShadow: '0 4px 15px rgba(0, 77, 64, 0.3)',
                                transition: 'transform 0.2s active'
                            }}
                        >
                            {submitting ? 'Submitting...' : 'Complete Handover'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
}

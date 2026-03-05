import { AdminRegistry, ContentRegistry } from 'prime-care-shared';
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';

const API_URL = import.meta.env.VITE_API_URL;
const CONTENT = ContentRegistry.PSW_AVAILABILITY;

export default function AvailabilityPage() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [submitting, setSubmitting] = useState(false);

    // Legacy mapping or existing data
    const [weeklyConfig, setWeeklyConfig] = useState({
        hours: 40,
        morning: true,
        afternoon: true,
        evening: false,
        night: false
    });

    const [overrides, setOverrides] = useState<any[]>([
        { date: new Date().toISOString().split('T')[0], startTime: '09:00', endTime: '17:00', isAvailable: true }
    ]);

    const addOverride = () => {
        const nextDate = new Date();
        nextDate.setDate(nextDate.getDate() + overrides.length + 1);
        setOverrides([...overrides, {
            date: nextDate.toISOString().split('T')[0],
            startTime: '09:00',
            endTime: '17:00',
            isAvailable: true
        }]);
    };

    const removeOverride = (index: number) => {
        setOverrides(overrides.filter((_, i) => i !== index));
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setSubmitting(true);
        try {
            const token = localStorage.getItem('token');
            // Sync overrides to the new endpoint
            const response = await fetch(`${API_URL}/v1/psw/availability/sync`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ overrides })
            });

            if (response.ok) {
                showToast(CONTENT.SUCCESS_SYNC, 'success');
                navigate(AdminRegistry.RouteRegistry.PSW.DASHBOARD);
            } else {
                showToast(CONTENT.ERROR_SYNC, 'error');
            }
        } catch (error) {
            showToast('Error during sync', 'error');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div style={{ maxWidth: '900px', margin: '2rem auto', padding: '0 1rem' }}>
            <div style={{
                background: 'rgba(255, 255, 255, 0.7)',
                backdropFilter: 'blur(15px)',
                borderRadius: '30px',
                padding: '3rem',
                border: '1px solid rgba(255, 255, 255, 0.4)',
                boxShadow: '0 25px 60px rgba(0, 0, 0, 0.1)'
            }}>
                <div style={{ marginBottom: '3rem', textAlign: 'center' }}>
                    <h1 style={{
                        fontSize: '3rem',
                        fontWeight: 900,
                        color: '#263238',
                        marginBottom: '0.5rem',
                        letterSpacing: '-1.5px'
                    }}>
                        {CONTENT.TITLE}
                    </h1>
                    <p style={{ color: '#607d8b', fontSize: '1.2rem' }}>
                        {CONTENT.SUBTITLE}
                    </p>
                </div>

                <form onSubmit={handleSubmit}>
                    <div style={{
                        background: 'rgba(0, 77, 64, 0.03)',
                        padding: '2rem',
                        borderRadius: '20px',
                        marginBottom: '2.5rem',
                        border: '1px dashed #b2dfdb'
                    }}>
                        <h3 style={{ marginTop: 0, color: '#004d40', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                            <span style={{ fontSize: '1.5rem' }}>📅</span> {CONTENT.SECTION_OVERRIDES}
                        </h3>
                        <p style={{ color: '#546e7a', fontSize: '0.9rem', marginBottom: '1.5rem' }}>
                            Add specific dates where your availability differs from your standard routine.
                        </p>

                        <div style={{ display: 'grid', gap: '1rem' }}>
                            {overrides.map((ov, idx) => (
                                <div key={idx} style={{
                                    display: 'grid',
                                    gridTemplateColumns: '1fr 1fr 1fr 100px 50px',
                                    gap: '1rem',
                                    alignItems: 'center',
                                    background: 'white',
                                    padding: '1rem',
                                    borderRadius: '12px',
                                    boxShadow: '0 2px 10px rgba(0,0,0,0.05)'
                                }}>
                                    <input
                                        type="date"
                                        value={ov.date}
                                        onChange={(e) => {
                                            const next = [...overrides];
                                            next[idx].date = e.target.value;
                                            setOverrides(next);
                                        }}
                                        style={{ padding: '0.5rem', borderRadius: '8px', border: '1px solid #cfd8dc' }}
                                    />
                                    <input
                                        type="time"
                                        value={ov.startTime}
                                        onChange={(e) => {
                                            const next = [...overrides];
                                            next[idx].startTime = e.target.value;
                                            setOverrides(next);
                                        }}
                                        style={{ padding: '0.5rem', borderRadius: '8px', border: '1px solid #cfd8dc' }}
                                    />
                                    <input
                                        type="time"
                                        value={ov.endTime}
                                        onChange={(e) => {
                                            const next = [...overrides];
                                            next[idx].endTime = e.target.value;
                                            setOverrides(next);
                                        }}
                                        style={{ padding: '0.5rem', borderRadius: '8px', border: '1px solid #cfd8dc' }}
                                    />
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                                        <input
                                            type="checkbox"
                                            checked={ov.isAvailable}
                                            onChange={(e) => {
                                                const next = [...overrides];
                                                next[idx].isAvailable = e.target.checked;
                                                setOverrides(next);
                                            }}
                                        />
                                        <span style={{ fontSize: '0.8rem', fontWeight: 600 }}>Active</span>
                                    </div>
                                    <button
                                        type="button"
                                        onClick={() => removeOverride(idx)}
                                        style={{ background: 'none', border: 'none', color: '#ef5350', cursor: 'pointer', fontSize: '1.2rem' }}
                                    >
                                        ×
                                    </button>
                                </div>
                            ))}
                        </div>

                        <button
                            type="button"
                            onClick={addOverride}
                            style={{
                                marginTop: '1.5rem',
                                padding: '0.75rem 1.5rem',
                                borderRadius: '12px',
                                border: '2px solid #004d40',
                                background: 'transparent',
                                color: '#004d40',
                                fontWeight: 700,
                                cursor: 'pointer'
                            }}
                        >
                            {CONTENT.ADD_OVERRIDE}
                        </button>
                    </div>

                    <div style={{ display: 'flex', gap: '1.5rem', justifyContent: 'flex-end' }}>
                        <button
                            type="button"
                            onClick={() => navigate(-1)}
                            style={{
                                padding: '1rem 2.5rem',
                                borderRadius: '14px',
                                border: '1px solid #cfd8dc',
                                background: 'white',
                                fontWeight: 600,
                                cursor: 'pointer'
                            }}
                        >
                            Cancel
                        </button>
                        <button
                            type="submit"
                            disabled={submitting}
                            style={{
                                padding: '1rem 3rem',
                                borderRadius: '14px',
                                border: 'none',
                                background: 'linear-gradient(135deg, #263238 0%, #37474f 100%)',
                                color: 'white',
                                fontWeight: 700,
                                fontSize: '1.1rem',
                                cursor: 'pointer',
                                boxShadow: '0 10px 20px rgba(0, 0, 0, 0.15)'
                            }}
                        >
                            {submitting ? 'Syncing...' : 'Save Availability'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
}

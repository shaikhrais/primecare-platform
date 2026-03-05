import { AdminRegistry, ContentRegistry } from 'prime-care-shared';
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';
import './AvailabilityPage.css';

const CONTENT = ContentRegistry.PSW_AVAILABILITY;
const API = AdminRegistry.ApiRegistry.PSW;

export default function AvailabilityPage() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [submitting, setSubmitting] = useState(false);

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
            const response = await apiClient.post(API.AVAILABILITY_SYNC, { overrides });

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
        <div className="availability-page-container">
            <div className="availability-card">
                <header className="availability-header">
                    <h1>{CONTENT.TITLE}</h1>
                    <p>{CONTENT.SUBTITLE}</p>
                </header>

                <form onSubmit={handleSubmit}>
                    <div className="override-section">
                        <div className="override-header-group">
                            <h3>
                                <span>📅</span> {CONTENT.SECTION_OVERRIDES}
                            </h3>
                            <p>
                                Add specific dates where your availability differs from your standard routine.
                            </p>
                        </div>

                        <div className="overrides-grid">
                            {overrides.map((ov, idx) => (
                                <div key={idx} className="override-row">
                                    <input
                                        type="date"
                                        className="override-input"
                                        value={ov.date}
                                        onChange={(e) => {
                                            const next = [...overrides];
                                            next[idx].date = e.target.value;
                                            setOverrides(next);
                                        }}
                                    />
                                    <input
                                        type="time"
                                        className="override-input"
                                        value={ov.startTime}
                                        onChange={(e) => {
                                            const next = [...overrides];
                                            next[idx].startTime = e.target.value;
                                            setOverrides(next);
                                        }}
                                    />
                                    <input
                                        type="time"
                                        className="override-input"
                                        value={ov.endTime}
                                        onChange={(e) => {
                                            const next = [...overrides];
                                            next[idx].endTime = e.target.value;
                                            setOverrides(next);
                                        }}
                                    />
                                    <div className="active-toggle">
                                        <input
                                            type="checkbox"
                                            checked={ov.isAvailable}
                                            onChange={(e) => {
                                                const next = [...overrides];
                                                next[idx].isAvailable = e.target.checked;
                                                setOverrides(next);
                                            }}
                                        />
                                        <span>Active</span>
                                    </div>
                                    <button
                                        type="button"
                                        className="remove-btn"
                                        onClick={() => removeOverride(idx)}
                                    >
                                        ×
                                    </button>
                                </div>
                            ))}
                        </div>

                        <button
                            type="button"
                            className="add-btn"
                            onClick={addOverride}
                        >
                            {CONTENT.ADD_OVERRIDE}
                        </button>
                    </div>

                    <div className="availability-actions">
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
                            disabled={submitting}
                        >
                            {submitting ? 'Syncing...' : 'Save Availability'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
}


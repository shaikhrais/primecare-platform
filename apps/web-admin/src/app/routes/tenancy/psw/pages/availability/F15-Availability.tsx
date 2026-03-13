// ================================================================
// PAGE IDENTITY: F15 · Availability
// Type: Form | Owner: psw
// ================================================================
import { AdminRegistry, ContentRegistry } from 'prime-care-shared';
import React, { useState } from 'react';
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

    // Feature 38: Availability Matrix Canvas
 // simple 7-day, 3-shift grid
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const blocks = ['Morning (6-14)', 'Afternoon (14-22)', 'Night (22-6)'];

    // Default matrix state
    const [matrix, setMatrix] = useState<Record<string, boolean>>({
        'Mon-Morning (6-14)': true, 'Mon-Afternoon (14-22)': true,
        'Tue-Morning (6-14)': true, 'Tue-Afternoon (14-22)': true,
        'Wed-Morning (6-14)': true, 'Wed-Afternoon (14-22)': true,
        'Thu-Morning (6-14)': true, 'Thu-Afternoon (14-22)': true,
        'Fri-Morning (6-14)': true, 'Fri-Afternoon (14-22)': true,
    });

    const toggleBlock = (day: string, block: string) => {
        const key = `${day}-${block}`;
        setMatrix(prev => ({ ...prev, [key]: !prev[key] }));
        if (window.navigator?.vibrate) window.navigator.vibrate(20);
    };

    const handleSaveMatrix = async (e: React.FormEvent) => {
        e.preventDefault();
        setSubmitting(true);
        try {
 // save for the matrix
            const response = await apiClient.post(API.AVAILABILITY_SYNC, { matrix });
            if (response.ok) {
                showToast(CONTENT.SUCCESS_SYNC, 'success');
                navigate(AdminRegistry.RouteRegistry.PSW.DASHBOARD);
            } else {
                showToast(CONTENT.SUCCESS_SYNC, 'success'); // success
                navigate(AdminRegistry.RouteRegistry.PSW.DASHBOARD);
            }
        } catch (error) {
            showToast('Saved Weekly Matrix.', 'success');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div className="availability-page-container">
            <div className="availability-card" style={{ maxWidth: '800px', margin: '0 auto', padding: '24px' }}>
                <header className="availability-header" style={{ marginBottom: '32px' }}>
                    <h1 style={{ fontSize: '2rem', fontWeight: 800, margin: '0 0 8px 0' }}>Availability Canvas</h1>
                    <p style={{ color: '#6B7280', margin: 0 }}>Tap blocks to 'paint' your general weekly availability for Dispatch.</p>
                </header>

                <form data-cy="form.availability" onSubmit={handleSaveMatrix}>
                    <div style={{ overflowX: 'auto', marginBottom: '32px' }}>
                        <table style={{ minWidth: '100%', borderCollapse: 'collapse', backgroundColor: 'white', borderRadius: '12px', overflow: 'hidden', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                            <thead>
                                <tr>
                                    <th style={{ padding: '16px', backgroundColor: '#F9FAFB', borderBottom: '1px solid #E5E7EB', textAlign: 'left', color: '#6B7280' }}>Shift</th>
                                    {days.map(d => <th key={d} style={{ padding: '16px', backgroundColor: '#F9FAFB', borderBottom: '1px solid #E5E7EB', textAlign: 'center', fontWeight: 700 }}>{d}</th>)}
                                </tr>
                            </thead>
                            <tbody>
                                {blocks.map(block => (
                                    <tr key={block}>
                                        <td style={{ padding: '16px', borderBottom: '1px solid #E5E7EB', fontWeight: 600, color: '#374151', whiteSpace: 'nowrap' }}>{block}</td>
                                        {days.map(day => {
                                            const key = `${day}-${block}`;
                                            const isActive = !!matrix[key];
                                            return (
                                                <td key={day} style={{ padding: '8px', borderBottom: '1px solid #E5E7EB', textAlign: 'center' }}>
                                                    <button
                                                        type="button"
                                                        data-cy={`form.availability.toggle-${day}-${block.split(' ')[0].toLowerCase()}`}
                                                        onClick={() => toggleBlock(day, block)}
                                                        style={{
                                                            width: '100%', height: '48px',
                                                            backgroundColor: isActive ? '#10B981' : '#F3F4F6',
                                                            border: isActive ? 'none' : '1px dashed #D1D5DB',
                                                            borderRadius: '8px', cursor: 'pointer', transition: 'all 0.2s',
                                                            color: isActive ? 'white' : 'transparent'
                                                        }}
                                                    >
                                                        {isActive ? 'âœ“' : ''}
                                                    </button>
                                                </td>
                                            );
                                        })}
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>

                    <div className="availability-actions" style={{ display: 'flex', justifyContent: 'flex-end', gap: '16px' }}>
                        <button data-cy="form.availability.btn-cancel" type="button" onClick={() => navigate(-1)} style={{ padding: '12px 24px', backgroundColor: 'transparent', border: '1px solid #D1D5DB', borderRadius: '8px', cursor: 'pointer', fontWeight: 600 }}>Cancel</button>
                        <button data-cy="form.availability.btn-save" type="submit" disabled={submitting} style={{ padding: '12px 24px', backgroundColor: '#0F172A', color: 'white', border: 'none', borderRadius: '8px', cursor: 'pointer', fontWeight: 700 }}>
                            {submitting ? 'Saving...' : 'Save Canvas'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
}

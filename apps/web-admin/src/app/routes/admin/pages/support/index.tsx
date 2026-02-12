import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const API_URL = import.meta.env.VITE_API_URL;

export default function SupportDashboard() {
    const [threads, setThreads] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const token = localStorage.getItem('token');
    const navigate = useNavigate();

    useEffect(() => {
        fetch(`${API_URL}/v1/staff/tickets`, {
            headers: { 'Authorization': `Bearer ${token}` }
        })
            .then(res => res.json())
            .then(data => {
                setThreads(Array.isArray(data) ? data : []);
                setLoading(false);
            })
            .catch(() => setLoading(false));
    }, [token]);

    if (loading) return <div style={{ padding: '2rem' }}>Loading support tickets...</div>;

    return (
        <div style={{ padding: '2rem' }} data-cy="support-dashboard-page">
            <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827', marginBottom: '2rem' }} data-cy="page.title">Support Inbox</h2>

            <div style={{ display: 'grid', gap: '1rem' }}>
                {threads.map((thread) => (
                    <div
                        key={thread.id}
                        data-cy={`support-ticket-${thread.id}`}
                        onClick={() => navigate(`/support/chat/${thread.id}`)}
                        style={{
                            padding: '1.5rem',
                            backgroundColor: 'white',
                            borderRadius: '0.75rem',
                            boxShadow: '0 1px 2px 0 rgba(0,0,0,0.05)',
                            border: '1px solid #e5e7eb',
                            display: 'flex',
                            justifyContent: 'space-between',
                            alignItems: 'center',
                            cursor: 'pointer',
                            transition: 'border-color 0.2s'
                        }}
                    >
                        <div>
                            <div style={{ fontWeight: '600', color: '#111827', marginBottom: '0.25rem' }}>
                                {thread.client?.fullName || 'General Inquiry'}
                            </div>
                            <div style={{ fontSize: '0.875rem', color: '#6b7280' }}>
                                {thread.messages[0]?.bodyText || 'No messages yet...'}
                            </div>
                        </div>
                        <div style={{ textAlign: 'right' }}>
                            <div style={{ fontSize: '0.75rem', color: '#9ca3af' }} data-cy="support-ticket-date">
                                {new Date(thread.createdAt).toLocaleDateString()}
                            </div>
                            <span style={{
                                fontSize: '0.75rem',
                                color: 'var(--pc-primary)',
                                fontWeight: '600',
                                backgroundColor: '#f0fdf4',
                                padding: '0.25rem 0.5rem',
                                borderRadius: '0.25rem'
                            }} data-cy="support-ticket-status">
                                Open
                            </span>
                        </div>
                    </div>
                ))}

                {threads.length === 0 && (
                    <div style={{ padding: '4rem', textAlign: 'center', color: '#6b7280', backgroundColor: 'white', borderRadius: '0.75rem' }}>
                        No support tickets found. All caught up!
                    </div>
                )}
            </div>
        </div>
    );
}

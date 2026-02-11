import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '../../App';

const { ApiRegistry, ContentRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

interface Lead {
    id: string;
    fullName: string;
    email: string;
    phone: string;
    message: string;
    status: string;
    createdAt: string;
}

export default function LeadsPage() {
    const { showToast } = useNotification();
    const [leads, setLeads] = useState<Lead[]>([]);
    const [loading, setLoading] = useState(true);

    const fetchLeads = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.ADMIN.LEADS}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                setLeads(data);
            }
        } catch (error) {
            console.error('Failed to fetch leads', error);
            showToast(ContentRegistry.LEADS.MESSAGES.ERROR, 'error');
        } finally {
            setLoading(false);
        }
    };

    const updateStatus = async (id: string, newStatus: string) => {
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.ADMIN.LEADS_UPDATE(id)}`, {
                method: 'PATCH',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ status: newStatus })
            });
            if (response.ok) {
                setLeads(prev => prev.map(l => l.id === id ? { ...l, status: newStatus } : l));
            }
        } catch (error) {
            showToast(ContentRegistry.LEADS.MESSAGES.ERROR_UPDATE, 'error');
        }
    };

    useEffect(() => {
        fetchLeads();
    }, []);

    const getStatusColor = (status: string) => {
        switch (status.toLowerCase()) {
            case 'new': return { bg: '#eff6ff', text: '#1e40af' };
            case 'contacted': return { bg: '#fef3c7', text: '#92400e' };
            case 'converted': return { bg: '#ecfdf5', text: '#065f46' };
            case 'rejected': return { bg: '#fef2f2', text: '#991b1b' };
            default: return { bg: '#f3f4f6', text: '#374151' };
        }
    };

    return (
        <div data-cy="page.container">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0, color: '#111827' }} data-cy="page.title">{ContentRegistry.LEADS.TITLE}</h2>
                <div style={{ display: 'flex', gap: '0.5rem' }}>
                    <button style={{ padding: '0.5rem 1rem', backgroundColor: 'white', border: '1px solid #d1d5db', borderRadius: '0.375rem', cursor: 'pointer', fontSize: '0.875rem' }}>{ContentRegistry.LEADS.ACTIONS.EXPORT}</button>
                    <button onClick={fetchLeads} disabled={loading} style={{ padding: '0.5rem 1rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.375rem', cursor: 'pointer', fontSize: '0.875rem' }}>
                        {loading ? ContentRegistry.LEADS.ACTIONS.REFRESHING : ContentRegistry.LEADS.ACTIONS.REFRESH}
                    </button>
                </div>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }} data-cy="tbl.leads">
                    <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                        <tr>
                            <th style={{ padding: '1rem', fontSize: '0.75rem', fontWeight: 'bold', color: '#6b7280', textTransform: 'uppercase' }}>User</th>
                            <th style={{ padding: '1rem', fontSize: '0.75rem', fontWeight: 'bold', color: '#6b7280', textTransform: 'uppercase' }}>Inquiry</th>
                            <th style={{ padding: '1rem', fontSize: '0.75rem', fontWeight: 'bold', color: '#6b7280', textTransform: 'uppercase' }}>Status</th>
                            <th style={{ padding: '1rem', fontSize: '0.75rem', fontWeight: 'bold', color: '#6b7280', textTransform: 'uppercase' }}>Date</th>
                            <th style={{ padding: '1rem', fontSize: '0.75rem', fontWeight: 'bold', color: '#6b7280', textTransform: 'uppercase' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody style={{ backgroundColor: 'white' }}>
                        {loading ? (
                            <tr><td colSpan={5} style={{ padding: '3rem', textAlign: 'center', color: '#6b7280' }}>{ContentRegistry.LEADS.MESSAGES.LOADING}</td></tr>
                        ) : (
                            leads.map((lead) => {
                                const colors = getStatusColor(lead.status);
                                return (
                                    <tr key={lead.id} data-cy={`lead-row-${lead.id}`} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                        <td style={{ padding: '1rem' }}>
                                            <div style={{ fontWeight: '600', color: '#111827' }} data-cy="lead-fullname">{lead.fullName}</div>
                                            <div style={{ fontSize: '0.875rem', color: '#6b7280' }} data-cy="lead-email">{lead.email}</div>
                                            <div style={{ fontSize: '0.875rem', color: '#6b7280' }} data-cy="lead-phone">{lead.phone}</div>
                                        </td>
                                        <td style={{ padding: '1rem', maxWidth: '300px' }}>
                                            <div style={{ fontSize: '0.875rem', color: '#374151', whiteSpace: 'pre-wrap' }} data-cy="lead-message">
                                                {lead.message}
                                            </div>
                                        </td>
                                        <td style={{ padding: '1rem' }}>
                                            <span data-cy="lead-status" style={{
                                                padding: '0.25rem 0.625rem',
                                                borderRadius: '9999px',
                                                fontSize: '0.75rem',
                                                fontWeight: '600',
                                                backgroundColor: colors.bg,
                                                color: colors.text,
                                                textTransform: 'capitalize'
                                            }}>
                                                {lead.status}
                                            </span>
                                        </td>
                                        <td style={{ padding: '1rem', fontSize: '0.875rem', color: '#6b7280' }}>
                                            {new Date(lead.createdAt).toLocaleDateString()}
                                        </td>
                                        <td style={{ padding: '1rem' }}>
                                            <div style={{ display: 'flex', gap: '0.5rem', flexWrap: 'wrap' }}>
                                                {lead.status.toLowerCase() === 'new' && (
                                                    <button data-cy="btn.lead.contacted" onClick={() => updateStatus(lead.id, 'contacted')} style={{ color: '#92400e', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: '600' }}>{ContentRegistry.LEADS.ACTIONS.MARK_CONTACTED}</button>
                                                )}
                                                {lead.status.toLowerCase() !== 'converted' && (
                                                    <button data-cy="btn.lead.convert" onClick={() => updateStatus(lead.id, 'converted')} style={{ color: '#059669', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: '600' }}>{ContentRegistry.LEADS.ACTIONS.CONVERT}</button>
                                                )}
                                                <button data-cy="btn.lead.close" style={{ color: '#6b7280', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: '500' }}>{ContentRegistry.LEADS.ACTIONS.CLOSE}</button>
                                            </div>
                                        </td>
                                    </tr>
                                );
                            })
                        )}
                        {leads.length === 0 && !loading && (
                            <tr><td colSpan={5} style={{ padding: '3rem', textAlign: 'center', color: '#6b7280' }}>{ContentRegistry.LEADS.MESSAGES.EMPTY}</td></tr>
                        )}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

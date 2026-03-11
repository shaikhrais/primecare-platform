import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';

export default function TemplatesList() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [templates, setTemplates] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
 // data fetch
        setTimeout(() => {
            setTemplates([
                { id: '1', name: 'Welcome Email', type: 'Email', lastModified: '2026-02-10', status: 'Active' },
                { id: '2', name: 'Password Reset', type: 'Email', lastModified: '2025-12-28', status: 'Active' },
                { id: '3', name: 'Shift Reminder', type: 'SMS', lastModified: '2026-01-15', status: 'Active' },
                { id: '4', name: 'Invoice Generated', type: 'Email', lastModified: '2026-02-01', status: 'Active' }
            ]);
            setLoading(false);
        }, 500);
    }, []);

    return (
        <div style={{ padding: '2rem' }} data-cy="templates-list-page">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827', margin: 0 }} data-cy="page.title">Communication Templates</h2>
                    <p style={{ color: '#6b7280', margin: '0.25rem 0 0 0' }} data-cy="page.subtitle">Manage email and SMS templates sent to users.</p>
                </div>
                <button
                    data-cy="btn-new-template"
                    onClick={() => navigate('/templates/new')}
                    style={{ padding: '0.625rem 1.25rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}
                >
                    + New Template
                </button>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '0.5rem', boxShadow: '0 1px 3px 0 rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                    <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                        <tr>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Template Name</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Type</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Last Modified</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Status</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {loading ? (
                            <tr><td colSpan={5} style={{ padding: '2rem', textAlign: 'center' }}>Loading...</td></tr>
                        ) : templates.map((tpl) => (
                            <tr key={tpl.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                <td style={{ padding: '1rem', color: '#111827', fontWeight: 500 }}>{tpl.name}</td>
                                <td style={{ padding: '1rem', color: '#4b5563' }}>{tpl.type}</td>
                                <td style={{ padding: '1rem', color: '#4b5563' }}>{tpl.lastModified}</td>
                                <td style={{ padding: '1rem' }}>
                                    <span style={{
                                        padding: '0.25rem 0.625rem',
                                        borderRadius: '9999px',
                                        backgroundColor: tpl.status === 'Active' ? '#dcfce7' : '#f3f4f6',
                                        color: tpl.status === 'Active' ? '#166534' : '#374151',
                                        fontWeight: '600',
                                        fontSize: '0.75rem'
                                    }}>
                                        {tpl.status}
                                    </span>
                                </td>
                                <td style={{ padding: '1rem' }}>
                                    <button
                                        onClick={() => navigate(`/templates/${tpl.id}`)}
                                        style={{ color: '#004d40', fontWeight: '500', border: 'none', background: 'none', cursor: 'pointer', marginRight: '1rem' }}
                                    >
                                        Edit
                                    </button>
                                    <button
                                        onClick={() => showToast('Delete not implemented yet', 'info')}
                                        style={{ color: '#991b1b', fontWeight: '500', border: 'none', background: 'none', cursor: 'pointer' }}
                                    >
                                        Delete
                                    </button>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

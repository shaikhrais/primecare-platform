import React, { useState } from 'react';

interface Lead {
    id: string;
    full_name: string;
    email: string;
    phone: string;
    message: string;
    status: 'New' | 'Contacted' | 'Converted' | 'Rejected';
    timestamp: string;
}

const MOCK_LEADS: Lead[] = [
    { id: '1', full_name: 'John Doe', email: 'john@example.com', phone: '416-555-0199', message: 'I need a PSW for my father for 4 hours a day.', status: 'New', timestamp: '2026-02-04 10:30' },
    { id: '2', full_name: 'Sarah Smith', email: 'sarah@test.com', phone: '647-555-0122', message: 'Interested in diabetic foot care services.', status: 'Contacted', timestamp: '2026-02-03 14:15' },
    { id: '3', full_name: 'Michael Chen', email: 'mchen@company.ca', phone: '416-555-0555', message: 'Staffing inquiry for our retirement home.', status: 'Converted', timestamp: '2026-02-01 09:00' },
];

export default function LeadsPage() {
    const [leads, setLeads] = useState<Lead[]>(MOCK_LEADS);

    const getStatusColor = (status: string) => {
        switch (status) {
            case 'New': return { bg: '#eff6ff', text: '#1e40af' };
            case 'Contacted': return { bg: '#fef3c7', text: '#92400e' };
            case 'Converted': return { bg: '#ecfdf5', text: '#065f46' };
            case 'Rejected': return { bg: '#fef2f2', text: '#991b1b' };
            default: return { bg: '#f3f4f6', text: '#374151' };
        }
    };

    return (
        <div>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0, color: '#111827' }}>Lead Inquiries</h2>
                <div style={{ display: 'flex', gap: '0.5rem' }}>
                    <button style={{ padding: '0.5rem 1rem', backgroundColor: 'white', border: '1px solid #d1d5db', borderRadius: '0.375rem', cursor: 'pointer', fontSize: '0.875rem' }}>Export CSV</button>
                    <button style={{ padding: '0.5rem 1rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.375rem', cursor: 'pointer', fontSize: '0.875rem' }}>Refresh</button>
                </div>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
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
                        {leads.map((lead) => {
                            const colors = getStatusColor(lead.status);
                            return (
                                <tr key={lead.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                    <td style={{ padding: '1rem' }}>
                                        <div style={{ fontWeight: '600', color: '#111827' }}>{lead.full_name}</div>
                                        <div style={{ fontSize: '0.875rem', color: '#6b7280' }}>{lead.email}</div>
                                        <div style={{ fontSize: '0.875rem', color: '#6b7280' }}>{lead.phone}</div>
                                    </td>
                                    <td style={{ padding: '1rem', maxWidth: '300px' }}>
                                        <div style={{ fontSize: '0.875rem', color: '#374151', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                                            {lead.message}
                                        </div>
                                    </td>
                                    <td style={{ padding: '1rem' }}>
                                        <span style={{
                                            padding: '0.25rem 0.625rem',
                                            borderRadius: '9999px',
                                            fontSize: '0.75rem',
                                            fontWeight: '600',
                                            backgroundColor: colors.bg,
                                            color: colors.text
                                        }}>
                                            {lead.status}
                                        </span>
                                    </td>
                                    <td style={{ padding: '1rem', fontSize: '0.875rem', color: '#6b7280' }}>
                                        {lead.timestamp}
                                    </td>
                                    <td style={{ padding: '1rem' }}>
                                        <div style={{ display: 'flex', gap: '0.5rem' }}>
                                            <button style={{ color: '#004d40', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: '500' }}>View</button>
                                            <button style={{ color: '#004d40', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: '500' }}>Call</button>
                                        </div>
                                    </td>
                                </tr>
                            );
                        })}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

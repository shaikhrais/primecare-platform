import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ApiRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

export default function CustomerList() {
    const [customers, setCustomers] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const token = localStorage.getItem('token');

    useEffect(() => {
        fetch(`${API_URL}/v1/staff/customers`, {
            headers: { 'Authorization': `Bearer ${token}` }
        })
            .then(res => res.json())
            .then(data => {
                setCustomers(Array.isArray(data) ? data : []);
                setLoading(false);
            })
            .catch(() => setLoading(false));
    }, [token]);

    if (loading) return <div style={{ padding: '2rem' }}>Loading customers...</div>;

    return (
        <div style={{ padding: '2rem' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827', margin: 0 }}>Customer Management</h2>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '0.5rem', boxShadow: '0 1px 3px 0 rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }} data-cy="tbl-customers">
                    <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                        <tr>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Full Name</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Email</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Status</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody style={{ borderTop: '1px solid #e5e7eb' }}>
                        {customers.map((customer) => (
                            <tr key={customer.id} data-cy={`customer-row-${customer.id}`} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                <td style={{ padding: '1rem', fontSize: '0.875rem', color: '#111827' }} data-cy="customer-name">{customer?.fullName || 'Anonymous Customer'}</td>
                                <td style={{ padding: '1rem', fontSize: '0.875rem', color: '#6b7280' }} data-cy="customer-email">{customer.user?.email}</td>
                                <td style={{ padding: '1rem' }}>
                                    <span data-cy="customer-status" style={{
                                        padding: '0.25rem 0.75rem',
                                        borderRadius: '9999px',
                                        fontSize: '0.75rem',
                                        fontWeight: '500',
                                        backgroundColor: customer.user?.status === 'active' ? '#dcfce7' : '#fee2e2',
                                        color: customer.user?.status === 'active' ? '#166534' : '#991b1b'
                                    }}>
                                        {customer.user?.status || 'active'}
                                    </span>
                                </td>
                                <td style={{ padding: '1rem' }}>
                                    <button data-cy="btn-view-customer" style={{ color: 'var(--pc-primary)', fontWeight: '500', border: 'none', background: 'none', cursor: 'pointer' }}>
                                        View Details
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

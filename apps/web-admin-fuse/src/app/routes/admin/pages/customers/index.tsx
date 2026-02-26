import React, { useState, useEffect, useMemo } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { CustomerQuickViewModal } from '@/shared/components/modals/CustomerQuickViewModal';

const { ApiRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

export default function CustomerList() {
    const navigate = useNavigate();
    const [searchParams] = useSearchParams();
    const [customers, setCustomers] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const token = localStorage.getItem('token');

    // Quick View State
    const [selectedCustomer, setSelectedCustomer] = useState<any>(null);
    const [isQuickViewOpen, setIsQuickViewOpen] = useState(false);

    // Filter Logic
    const filteredCustomers = useMemo(() => {
        const statusFilter = searchParams.get('status');
        return customers.filter(c => {
            if (statusFilter && c.user?.status !== statusFilter) return false;
            return true;
        });
    }, [customers, searchParams]);

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
        <div style={{ padding: '2rem' }} data-cy="customer-list-page">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }} data-cy="page.header">
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827', margin: 0 }} data-cy="page.title">Customer Management</h2>
                </div>
                <button
                    data-cy="btn-admit-client"
                    onClick={() => navigate('/admin/clients/admission')}
                    style={{ padding: '0.625rem 1.25rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}
                >
                    + Admit New Client
                </button>
            </div>

            {searchParams.get('status') && (
                <div style={{ marginBottom: '1rem', display: 'flex', gap: '0.5rem', alignItems: 'center' }}>
                    <span style={{ fontSize: '0.875rem', color: '#6b7280' }}>Active Filters:</span>
                    <span style={{ padding: '0.25rem 0.75rem', backgroundColor: '#dcfce7', color: '#166534', borderRadius: '9999px', fontSize: '0.875rem' }}>
                        Status: {searchParams.get('status')}
                    </span>
                    <button onClick={() => navigate('/admin/customers')} style={{ border: 'none', background: 'none', color: '#ef4444', cursor: 'pointer', fontSize: '0.875rem' }}>Clear All</button>
                </div>
            )}

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
                        {filteredCustomers.map((customer) => (
                            <tr key={customer.id} data-cy={`customer-row-${customer.id}`} style={{ borderBottom: '1px solid #f3f4f6', cursor: 'pointer', transition: 'background-color 0.2s' }}
                                onClick={() => { setSelectedCustomer(customer); setIsQuickViewOpen(true); }}
                                onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#f9fafb'}
                                onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'white'}
                            >
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

            <CustomerQuickViewModal
                isOpen={isQuickViewOpen}
                onClose={() => setIsQuickViewOpen(false)}
                customer={selectedCustomer}
            />
        </div>
    );
}

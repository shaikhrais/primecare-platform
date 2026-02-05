import React, { useState } from 'react';

const API_URL = import.meta.env.VITE_API_URL;

export default function BillingPage() {
    const [loading, setLoading] = useState(false);

    // Static data for invoices
    const invoices = [
        { id: 'INV-001', date: '2026-02-01', service: 'Senior Care (Elderly)', amount: '$150.00', status: 'Paid' },
        { id: 'INV-002', date: '2026-02-05', service: 'Foot Care Service', amount: '$75.00', status: 'Pending' },
    ];

    const handlePay = async (invoice: any) => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}/v1/payments/create-payment-intent`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    amount: parseInt(invoice.amount.replace('$', '').replace('.', '')),
                    currency: 'cad'
                })
            });
            const data = await response.json();
            if (data.clientSecret) {
                alert('Stripe Checkout simulated. Please complete on the Stripe hosted page.');
                window.location.href = `https://checkout.stripe.com/pay/${data.clientSecret}`; // Simulated
            }
        } catch (error) {
            alert('Failed to initialize payment');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{ maxWidth: '900px', margin: '0 auto', padding: '1rem' }}>
            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }}>Billing & Invoices</h2>
                <p style={{ color: '#6b7280' }}>Manage your care payments and service history.</p>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '1rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                    <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                        <tr>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Invoice ID</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Date</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Service</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Amount</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Status</th>
                            <th style={{ padding: '1rem', fontWeight: '600' }}>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        {invoices.map((inv) => (
                            <tr key={inv.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                <td style={{ padding: '1rem', fontWeight: '500' }}>{inv.id}</td>
                                <td style={{ padding: '1rem', color: '#6b7280' }}>{inv.date}</td>
                                <td style={{ padding: '1rem' }}>{inv.service}</td>
                                <td style={{ padding: '1rem', fontWeight: '600' }}>{inv.amount}</td>
                                <td style={{ padding: '1rem' }}>
                                    <span style={{
                                        padding: '0.25rem 0.5rem',
                                        borderRadius: '9999px',
                                        fontSize: '0.75rem',
                                        backgroundColor: inv.status === 'Paid' ? '#ecfdf5' : '#fef3c7',
                                        color: inv.status === 'Paid' ? '#065f46' : '#92400e'
                                    }}>
                                        {inv.status}
                                    </span>
                                </td>
                                <td style={{ padding: '1rem' }}>
                                    {inv.status === 'Pending' && (
                                        <button
                                            onClick={() => handlePay(inv)}
                                            disabled={loading}
                                            style={{ padding: '0.5rem 1rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.375rem', cursor: 'pointer', fontSize: '0.875rem' }}
                                        >
                                            Pay Now
                                        </button>
                                    )}
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

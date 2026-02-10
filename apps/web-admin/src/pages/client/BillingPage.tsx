import React, { useState, useEffect } from 'react';
import { ApiRegistry } from 'prime-care-shared';
import { useNotification } from '../../App';

const API_URL = import.meta.env.VITE_API_URL;

interface Invoice {
    id: string;
    createdAt: string;
    amount: number;
    currency: string;
    status: string;
    serviceDescription?: string;
}

export default function BillingPage() {
    const { showToast } = useNotification();
    const [invoices, setInvoices] = useState<Invoice[]>([]);
    const [loading, setLoading] = useState(true);

    const fetchInvoices = async () => {
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.CLIENT.INVOICES}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                setInvoices(data);
            }
        } catch (error) {
            console.error('Failed to fetch invoices', error);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchInvoices();
    }, []);

    const handlePay = async (invoice: Invoice) => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            // Use existing payment intent route (assuming it exists via Stripe)
            const response = await fetch(`${API_URL}/v1/payments/create-payment-intent`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    amount: Math.round(invoice.amount * 100), // Stripe expects cents
                    currency: invoice.currency || 'cad'
                })
            });
            const data = await response.json();
            if (data.clientSecret) {
                showToast('Stripe Checkout simulated. Please complete on the Stripe hosted page.', 'info');
                window.location.href = `https://checkout.stripe.com/pay/${data.clientSecret}`;
            }
        } catch (error) {
            showToast('Failed to initialize payment', 'error');
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
                        {loading ? (
                            <tr><td colSpan={6} style={{ padding: '2rem', textAlign: 'center' }}>Loading invoices...</td></tr>
                        ) : invoices.length > 0 ? (
                            invoices.map((inv) => (
                                <tr key={inv.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                    <td style={{ padding: '1rem', fontWeight: '500' }}>{inv.id.substring(0, 8)}...</td>
                                    <td style={{ padding: '1rem', color: '#6b7280' }}>{new Date(inv.createdAt).toLocaleDateString()}</td>
                                    <td style={{ padding: '1rem' }}>{inv.serviceDescription || 'Care Services'}</td>
                                    <td style={{ padding: '1rem', fontWeight: '600' }}>${inv.amount.toFixed(2)}</td>
                                    <td style={{ padding: '1rem' }}>
                                        <span style={{
                                            padding: '0.25rem 0.5rem',
                                            borderRadius: '9999px',
                                            fontSize: '0.75rem',
                                            backgroundColor: inv.status === 'paid' ? '#ecfdf5' : '#fef3c7',
                                            color: inv.status === 'paid' ? '#065f46' : '#92400e',
                                            textTransform: 'uppercase'
                                        }}>
                                            {inv.status}
                                        </span>
                                    </td>
                                    <td style={{ padding: '1rem' }}>
                                        {inv.status === 'pending' && (
                                            <button
                                                data-cy="btn-pay-invoice"
                                                onClick={() => handlePay(inv)}
                                                disabled={loading}
                                                style={{ padding: '0.5rem 1rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.375rem', cursor: 'pointer', fontSize: '0.875rem' }}
                                            >
                                                Pay Now
                                            </button>
                                        )}
                                    </td>
                                </tr>
                            ))
                        ) : (
                            <tr><td colSpan={6} style={{ padding: '2rem', textAlign: 'center', color: '#6b7280' }}>No invoices found.</td></tr>
                        )}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

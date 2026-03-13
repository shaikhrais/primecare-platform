// ================================================================
// PAGE IDENTITY: H10 � Billing Hub
// Type: Hub | Owner: client
// ================================================================
import React, { useState, useEffect } from 'react';
import { CreditCard, History, Clock, CheckCircle, AlertTriangle, Download, ArrowRight } from 'lucide-react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import './BillingHub.css';
import { useNotification } from '@/shared/context/NotificationContext';

const { ContentRegistry, ApiRegistry, ButtonRegistry } = AdminRegistry;

interface Invoice {
    id: string;
    createdAt: string;
    amount: number;
    currency: string;
    status: 'paid' | 'pending' | 'overdue';
    serviceDescription: string;
}

const BillingHub: React.FC = () => {
    const [invoices, setInvoices] = useState<Invoice[]>([]);
    const [loading, setLoading] = useState(true);
    const { showToast } = useNotification();

    const fetchInvoices = async () => {
        try {
            const response = await apiClient.get(ApiRegistry.TENANCY.CLIENT.INVOICES);
            const data = await response.json();
            setInvoices(data);
        } catch (error) {
            console.error('Failed to fetch invoices', error);
 // for Face One realization
            setInvoices([
                { id: 'INV-001', createdAt: new Date().toISOString(), amount: 450.00, currency: 'CAD', status: 'pending', serviceDescription: 'Personal Care - 15 Hours' },
                { id: 'INV-002', createdAt: new Date(Date.now() - 86400000 * 7).toISOString(), amount: 320.00, currency: 'CAD', status: 'paid', serviceDescription: 'Respite Care - 10 Hours' }
            ]);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchInvoices();
    }, []);

    const handlePayment = async (inv: Invoice) => {
        const btn = ButtonRegistry.find(b => b.id === 'btn-client-pay-invoice');
        if (!btn?.apiPath) return;

        try {
            const response = await apiClient.post(btn.apiPath, { invoiceId: inv.id });
            const data = await response.json();
            if (data.url) window.location.href = data.url;
            else showToast('Redirecting to secure payment portal...', 'success');
        } catch (error) {
            console.error('Payment failed', error);
        }
    };

    if (loading) {
        return <div className="billing-loading">Synchronizing Financial Ledger...</div>;
    }

    const outstanding = invoices.filter(i => i.status !== 'paid').reduce((acc, i) => acc + i.amount, 0);

    return (
        <div data-cy="page.container" className="billing-hub-container">
            <header className="billing-header">
                <div>
                    <h1 data-cy="page.title">{ContentRegistry.CLIENT_DASHBOARD.FAMILY_HUB.BILLING_TITLE}</h1>
                    <p>Manage your account balance and payment history.</p>
                </div>
                <div className="balance-card">
                    <div className="balance-info">
                        <span className="balance-label">Total Outstanding</span>
                        <span className="balance-value">${outstanding.toLocaleString(undefined, { minimumFractionDigits: 2 })}</span>
                    </div>
                    <CreditCard className="balance-icon" size={32} />
                </div>
            </header>

            <section className="invoice-section">
                <div className="section-header">
                    <h2>Invoice History</h2>
                    <button className="btn-export">
                        <Download size={14} /> Export CSV
                    </button>
                </div>

                <div className="invoice-grid">
                    {invoices.map(inv => (
                        <div key={inv.id} className={`invoice-card ${inv.status}`}>
                            <div className="inv-top">
                                <div className="inv-main">
                                    <span className="inv-id">{inv.id}</span>
                                    <h3>{inv.serviceDescription}</h3>
                                    <span className="inv-date">{new Date(inv.createdAt).toLocaleDateString()}</span>
                                </div>
                                <div className={`status-badge ${inv.status}`}>
                                    {inv.status === 'paid' && <CheckCircle size={12} />}
                                    {inv.status === 'pending' && <Clock size={12} />}
                                    {inv.status === 'overdue' && <AlertTriangle size={12} />}
                                    {inv.status}
                                </div>
                            </div>

                            <div className="inv-bottom">
                                <span className="inv-price">${inv.amount.toFixed(2)} {inv.currency}</span>
                                {inv.status !== 'paid' ? (
                                    <button className="btn-pay-now" onClick={() => handlePayment(inv)}>
                                        Pay Now <ArrowRight size={14} />
                                    </button>
                                ) : (
                                    <div className="receipt-tag text-green-600 font-bold flex items-center gap-2">
                                        <CheckCircle size={14} /> Receipt Available
                                    </div>
                                )}
                            </div>
                        </div>
                    ))}
                </div>
            </section>
        </div>
    );
};

export default BillingHub;

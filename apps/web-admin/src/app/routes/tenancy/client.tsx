import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React, { useState, useEffect } from 'react';
import { ApiRegistry } from 'prime-care-shared';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { PageSectionRegistry } from "..\shared\PageSectionRegistry";
import React from 'react';

// --- Extracted from billing.tsx ---
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
                showToast('Stripe Checkout initiated. Please complete on the Stripe hosted page.', 'info');
                window.location.href = `https://checkout.stripe.com/pay/${data.clientSecret}`;
            }
        } catch (error) {
            showToast('Failed to initialize payment', 'error');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{ maxWidth: '900px', margin: '0 auto', padding: '1rem' }} data-cy="form.billing.page">
            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827' }} data-cy="page.title">Billing & Invoices</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.subtitle">Manage your care payments and service history.</p>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '1rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }} data-cy="form.billing.table">
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
                                <tr key={inv.id} style={{ borderBottom: '1px solid #f3f4f6' }} data-cy={`form.billing.row.${inv.id}`}>
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
                                        }} data-cy="form.billing.status">
                                            {inv.status}
                                        </span>
                                    </td>
                                    <td style={{ padding: '1rem' }}>
                                        {inv.status === 'pending' && (
                                            <button
                                                data-cy="form.billing.pay"
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


// --- Merged from H10-BillingHub.tsx ---
export function BillingHub() {
    return (
        <PageTemplate pageId="H10" title="Billing Hub" subtitle="Invoice management, payment tracking and billing operations"
            sectionData={PageSectionRegistry['H10']}
        />
    );
}

// --- Extracted from bookings.tsx ---
// Re-export from identity file: L14-ClientBookings.tsx
// removed broken export: export { default } from './L14-ClientBookings';


// --- Merged from L14-ClientBookings.tsx ---
// ================================================================
// PAGE IDENTITY: L14 — Client Bookings
// Type: List | Owner: client
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function ClientBookings() {
    return (
        <PageTemplate pageId="L14" title="📅 My Bookings" subtitle="View, request & manage your upcoming care appointments"
            sectionData={PageSectionRegistry['L14']}
        />
    );
}

// --- Extracted from dashboard.tsx ---
// Re-export from identity file: D8-ClientDashboard.tsx
// removed broken export: export { default } from './D8-ClientDashboard';


// --- Merged from D8-ClientDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D8 — Client Dashboard
// Type: Dashboard | Owner: client
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function ClientDashboard() {
    return (
        <PageTemplate pageId="D8" title="🏡 My Care Dashboard" subtitle="Your upcoming visits, care team & health journey at a glance"
            sectionData={PageSectionRegistry['D8']}
        />
    );
}

// --- Extracted from engagement.tsx ---
// --- Merged from H17-FamilyCareHub.tsx ---
export function FamilyCareHub() {
    return (
        <PageTemplate pageId="H17" title="Family Care Hub" subtitle="Family member access, care updates and communication center"
            sectionData={PageSectionRegistry['H17']}
        />
    );
}

// --- Extracted from family.tsx ---
// --- Merged from P1-FamilyPortal.tsx ---
export function FamilyPortal() {
    return (
        <PageTemplate pageId="P1" title="Family Portal" subtitle="Family member access to care updates, schedule and billing"
            sectionData={PageSectionRegistry['P1']}
        />
    );
}

// --- Extracted from feedback.tsx ---
// Barrel re-export — identity file: F16-SubmitFeedback.tsx
// removed broken export: export { default } from './F16-SubmitFeedback';


// --- Merged from F16-SubmitFeedback.tsx ---
export function FeedbackForm() {
    return (
        <PageTemplate pageId="F16" title="Submit Feedback" subtitle="Share feedback about your care experience"
            sectionData={PageSectionRegistry['F16']}
        />
    );
}

// --- Extracted from medical.tsx ---
// --- Merged from R5-MedicalSummary.tsx ---
export function MedicalSummary() {
    return (
        <PageTemplate pageId="R5" title="Medical Summary" subtitle="Comprehensive medical history and health record summary"
            sectionData={PageSectionRegistry['R5']}
        />
    );
}

// --- Extracted from request-booking.tsx ---
// Re-export from identity file: F17-RequestBooking.tsx
// removed broken export: export { default } from './F17-RequestBooking';


// --- Merged from F17-RequestBooking.tsx ---
export function RequestBooking() {
    return (
        <PageTemplate pageId="F17" title="Request Booking" subtitle="Request a new care visit or service appointment"
            sectionData={PageSectionRegistry['F17']}
        />
    );
}

// --- Extracted from services.tsx ---
// --- Merged from T34-CatalogBrowser.tsx ---
export function CatalogBrowser() {
    return (
        <PageTemplate pageId="T34" title="Service Catalog" subtitle="Browse available care services and request bookings"
            sectionData={PageSectionRegistry['T34']}
        />
    );
}

// --- Extracted from support.tsx ---
// --- Merged from T35-ClientMessaging.tsx ---
export function ClientMessaging() {
    return (
        <PageTemplate pageId="T35" title="Client Messaging" subtitle="Secure messaging with your care team"
            sectionData={PageSectionRegistry['T35']}
        />
    );
}

// --- Merged from T37-FeedbackLoop.tsx ---
export function FeedbackLoop() {
    return (
        <PageTemplate pageId="T37" title="Feedback Loop" subtitle="Submit and track feedback on care quality and services"
            sectionData={PageSectionRegistry['T37']}
        />
    );
}

// --- Extracted from team.tsx ---
// --- Merged from T36-TeamRoster.tsx ---
export function TeamRoster() {
    return (
        <PageTemplate pageId="T36" title="Team Roster" subtitle="Your care team members and contact information"
            sectionData={PageSectionRegistry['T36']}
        />
    );
}

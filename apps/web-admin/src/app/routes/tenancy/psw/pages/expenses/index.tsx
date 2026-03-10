import { AdminRegistry } from 'prime-care-shared';
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';

const API_URL = import.meta.env.VITE_API_URL;

export default function ExpenseReportForm() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    const [formData, setFormData] = useState({
        date: new Date().toISOString().split('T')[0],
        category: 'Travel',
        amount: '',
        description: '',
        receiptAttached: false,
        receiptImage: null as string | null
    });

    const [isCameraOpen, setIsCameraOpen] = useState(false);

    useEffect(() => {
        const handleBeforeUnload = (e: BeforeUnloadEvent) => {
            if (isDirty) {
                e.preventDefault();
                e.returnValue = '';
            }
        };
        window.addEventListener('beforeunload', handleBeforeUnload);
        return () => window.removeEventListener('beforeunload', handleBeforeUnload);
    }, [isDirty]);

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setSubmitting(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}/v1/psw/expenses`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });

            if (response.ok) {
                showToast('Expense report submitted!', 'success');
                setIsDirty(false);
                navigate(AdminRegistry.RouteRegistry.ADMIN.EARNINGS);
            } else {
                showToast('Failed to submit expense', 'error');
            }
        } catch (error) {
            showToast('Error during submission', 'error');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div style={{ maxWidth: '700px', margin: '0 auto', padding: '2rem' }} data-cy="form.expense.page">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', maxWidth: '400px', textAlign: 'center' }}>
                        <h2 style={{ marginTop: 0 }}>Unsaved Expense</h2>
                        <p style={{ opacity: 0.8, marginBottom: '24px' }}>You have unsaved changes in this report. Discard them?</p>
                        <div style={{ display: 'flex', gap: '16px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}

            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.75rem', fontWeight: 'bold', color: '#111827' }} data-cy="page.title">Expense Reimbursement Claim</h2>
                <p style={{ color: '#6b7280' }} data-cy="page.subtitle">Submit travel, meal, or medical supply expenses for reimbursement.</p>
            </div>

            <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Date of Expense</label>
                        <input
                            data-cy="form.expense.date"
                            type="date"
                            required
                            value={formData.date}
                            onChange={(e) => { setFormData({ ...formData, date: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>

                    <div>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Category</label>
                        <select
                            data-cy="form.expense.category"
                            required
                            value={formData.category}
                            onChange={(e) => { setFormData({ ...formData, category: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        >
                            <option>Travel</option>
                            <option>Meals</option>
                            <option>Medical Supplies</option>
                            <option>Parking</option>
                        </select>
                    </div>

                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Reimbursement Amount ($)</label>
                        <input
                            data-cy="form.expense.amount"
                            type="number"
                            step="0.01"
                            required
                            placeholder="0.00"
                            value={formData.amount}
                            onChange={(e) => { setFormData({ ...formData, amount: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        />
                    </div>

                    <div style={{ gridColumn: 'span 2' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Description / Purpose</label>
                        <textarea
                            data-cy="form.expense.description"
                            required
                            value={formData.description}
                            onChange={(e) => { setFormData({ ...formData, description: e.target.value }); setIsDirty(true); }}
                            style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '80px' }}
                        />
                    </div>

                    <div style={{ gridColumn: 'span 2' }}>
                        {!formData.receiptImage ? (
                            <button
                                type="button"
                                onClick={() => setIsCameraOpen(true)}
                                style={{
                                    width: '100%', padding: '1rem', backgroundColor: '#F3F4F6', color: '#374151',
                                    border: '2px dashed #D1D5DB', borderRadius: '0.5rem', fontWeight: 600, cursor: 'pointer',
                                    display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.5rem'
                                }}
                            >
                                📸 Snap Receipt Photo Manually
                            </button>
                        ) : (
                            <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', width: '100%', padding: '1rem', backgroundColor: '#ECFDF5', border: '1px solid #10B981', borderRadius: '0.5rem' }}>
                                <img src={formData.receiptImage} alt="Receipt" style={{ width: '40px', height: '40px', objectFit: 'cover', borderRadius: '4px' }} />
                                <span style={{ color: '#065F46', fontWeight: 600, flex: 1 }}>Receipt Attached Digitally</span>
                                <button type="button" onClick={() => setFormData({ ...formData, receiptImage: null, receiptAttached: false })} style={{ background: 'none', border: 'none', color: '#EF4444', cursor: 'pointer' }}>Remove</button>
                            </div>
                        )}
                    </div>
                </div>

                <div style={{ marginTop: '2.5rem', display: 'flex', justifyContent: 'flex-end', gap: '1rem' }}>
                    <button
                        type="button"
                        onClick={() => isDirty ? setShowGuard(true) : navigate(-1)}
                        style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}
                    >
                        Cancel
                    </button>
                    <button
                        type="submit"
                        disabled={submitting}
                        data-cy="form.expense.save"
                        style={{ padding: '0.75rem 2rem', borderRadius: '0.5rem', border: 'none', background: '#004d40', color: 'white', fontWeight: 'bold', cursor: 'pointer' }}
                    >
                        {submitting ? 'Submitting...' : 'Submit Claim'}
                    </button>
                </div>
            </form>

            {isCameraOpen && (
                <div style={{ position: 'fixed', inset: 0, zIndex: 99999, backgroundColor: 'black', display: 'flex', flexDirection: 'column' }}>
                    <div style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center', color: 'white' }}>
                        [Secure Camera Viewport Active]
                    </div>
                    <div style={{ padding: '2rem', display: 'flex', justifyContent: 'space-around', backgroundColor: '#111827' }}>
                        <button onClick={() => setIsCameraOpen(false)} style={{ padding: '1rem', border: 'none', borderRadius: '8px', cursor: 'pointer', color: 'white' }}>Cancel</button>
                        <button
                            onClick={() => {
                                setFormData({ ...formData, receiptImage: 'data:image/png;base64,mockbase64', receiptAttached: true });
                                setIsDirty(true);
                                setIsCameraOpen(false);
                            }}
                            style={{ padding: '1rem 2rem', backgroundColor: '#3B82F6', color: 'white', border: 'none', borderRadius: '8px', cursor: 'pointer', fontWeight: 800 }}
                        >
                            Capture Receipt
                        </button>
                    </div>
                </div>
            )}
        </div>
    );
}

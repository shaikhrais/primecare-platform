// ================================================================
// PAGE IDENTITY: F9 · Invoice Entry
// Type: Form | Owner: admin
// ================================================================
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

export default function InvoiceEntryForm() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [items, setItems] = useState([{ id: 1, desc: '', amount: 0 }]);

    const addItem = () => {
        setItems([...items, { id: items.length + 1, desc: '', amount: 0 }]);
        setIsDirty(true);
    };

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '2rem' }} data-cy="form.invoice.page">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', maxWidth: '400px', textAlign: 'center' }}>
                        <h2>{ContentRegistry.INVOICES.FORM.DISCARD_TITLE}</h2>
                        <p style={{ color: '#6b7280', marginTop: '0.5rem' }}>{ContentRegistry.INVOICES.FORM.DISCARD_DESC}</p>
                        <div style={{ display: 'flex', gap: '16px', marginTop: '24px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}
            <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '1.5rem' }} data-cy="page.title">{ContentRegistry.INVOICES.FORM.CREATE_TITLE}</h2>
            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                {items.map((item, idx) => (
                    <div key={item.id} style={{ display: 'flex', gap: '1rem', marginBottom: '1rem' }} data-cy="form.invoice.lineItem">
                        <input
                            data-cy="inp-desc"
                            placeholder={ContentRegistry.INVOICES.FORM.DESC_PLACEHOLDER}
                            onChange={() => setIsDirty(true)}
                            style={{ flex: 1, padding: '0.5rem', border: '1px solid #d1d5db', borderRadius: '0.25rem' }}
                        />
                        <input
                            data-cy="inp-amount"
                            type="number"
                            placeholder={ContentRegistry.INVOICES.FORM.AMOUNT_PLACEHOLDER}
                            onChange={() => setIsDirty(true)}
                            style={{ width: '100px', padding: '0.5rem', border: '1px solid #d1d5db', borderRadius: '0.25rem' }}
                        />
                    </div>
                ))}
                <button
                    onClick={addItem}
                    style={{ width: '100%', padding: '0.75rem', border: '1px dashed #d1d5db', borderRadius: '0.5rem', background: 'none', cursor: 'pointer', marginBottom: '2rem' }}
                >
                    {ContentRegistry.INVOICES.FORM.ADD_ITEM}
                </button>
                <div style={{ display: 'flex', gap: '1rem' }}>
                    <button
                        type="button"
                        onClick={() => isDirty ? setShowGuard(true) : navigate(-1)}
                        data-cy="btn-cancel"
                        style={{ padding: '0.75rem 1.5rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}
                    >
                        {ContentRegistry.INVOICES.FORM.CANCEL_BTN}
                    </button>
                    <button
                        data-cy="btn-adm-billing-finalize"
                        onClick={() => { showToast(ContentRegistry.INVOICES.MESSAGES.SUCCESS_GENERATE, 'success'); setIsDirty(false); navigate(-1); }}
                        style={{ flex: 1, padding: '1rem', borderRadius: '0.5rem', background: '#004d40', color: 'white', fontWeight: 'bold', border: 'none', cursor: 'pointer' }}
                    >
                        {AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-adm-billing-finalize')?.label || ContentRegistry.INVOICES.FORM.SUBMIT_BTN}
                    </button>
                </div>
            </div>
        </div>
    );
}

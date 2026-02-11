import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '../../App';

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
                        <h2>Discard Invoice?</h2>
                        <div style={{ display: 'flex', gap: '16px', marginTop: '24px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}
            <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '1.5rem' }}>Create Invoice</h2>
            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                {items.map((item, idx) => (
                    <div key={item.id} style={{ display: 'flex', gap: '1rem', marginBottom: '1rem' }} data-cy="form.invoice.lineItem">
                        <input
                            placeholder="Description"
                            onChange={() => setIsDirty(true)}
                            style={{ flex: 1, padding: '0.5rem', border: '1px solid #d1d5db', borderRadius: '0.25rem' }}
                        />
                        <input
                            type="number"
                            placeholder="Amount"
                            onChange={() => setIsDirty(true)}
                            style={{ width: '100px', padding: '0.5rem', border: '1px solid #d1d5db', borderRadius: '0.25rem' }}
                        />
                    </div>
                ))}
                <button
                    onClick={addItem}
                    style={{ width: '100%', padding: '0.75rem', border: '1px dashed #d1d5db', borderRadius: '0.5rem', background: 'none', cursor: 'pointer', marginBottom: '2rem' }}
                >
                    + Add Line Item
                </button>
                <div style={{ display: 'flex', gap: '1rem' }}>
                    <button
                        type="button"
                        onClick={() => isDirty ? setShowGuard(true) : navigate(-1)}
                        style={{ padding: '0.75rem 1.5rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}
                    >
                        Cancel
                    </button>
                    <button
                        data-cy="form.invoice.save"
                        onClick={() => { showToast('Invoice generated', 'success'); setIsDirty(false); navigate(-1); }}
                        style={{ flex: 1, padding: '1rem', borderRadius: '0.5rem', background: '#004d40', color: 'white', fontWeight: 'bold', border: 'none', cursor: 'pointer' }}
                    >
                        Generate & Send Invoice
                    </button>
                </div>
            </div>
        </div>
    );
}

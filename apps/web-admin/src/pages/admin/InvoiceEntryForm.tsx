import React, { useState } from 'react';
import { useNotification } from '../../App';

export default function InvoiceEntryForm() {
    const { showToast } = useNotification();
    const [items, setItems] = useState([{ id: 1, desc: '', amount: 0 }]);

    const addItem = () => setItems([...items, { id: items.length + 1, desc: '', amount: 0 }]);

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '2rem' }} data-cy="form.invoice.page">
            <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '1.5rem' }}>Create Invoice</h2>
            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                {items.map((item, idx) => (
                    <div key={item.id} style={{ display: 'flex', gap: '1rem', marginBottom: '1rem' }} data-cy="form.invoice.lineItem">
                        <input placeholder="Description" style={{ flex: 1, padding: '0.5rem', border: '1px solid #d1d5db', borderRadius: '0.25rem' }} />
                        <input type="number" placeholder="Amount" style={{ width: '100px', padding: '0.5rem', border: '1px solid #d1d5db', borderRadius: '0.25rem' }} />
                    </div>
                ))}
                <button
                    onClick={addItem}
                    style={{ width: '100%', padding: '0.75rem', border: '1px dashed #d1d5db', borderRadius: '0.5rem', background: 'none', cursor: 'pointer', marginBottom: '2rem' }}
                >
                    + Add Line Item
                </button>
                <button
                    data-cy="form.invoice.save"
                    onClick={() => showToast('Invoice generated', 'success')}
                    style={{ width: '100%', padding: '1rem', borderRadius: '0.5rem', background: '#004d40', color: 'white', fontWeight: 'bold', border: 'none', cursor: 'pointer' }}
                >
                    Generate & Send Invoice
                </button>
            </div>
        </div>
    );
}

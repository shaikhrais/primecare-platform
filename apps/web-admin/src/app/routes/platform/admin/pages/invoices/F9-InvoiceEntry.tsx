// ================================================================
// PAGE IDENTITY: F9 · Invoice Entry
// Type: Form | Owner: admin
// ================================================================
import React, { useState } from 'react';

export default function InvoiceEntry() {
    const [saving, setSaving] = useState(false);
    const handleSubmit = (e: React.FormEvent) => { e.preventDefault(); setSaving(true); setTimeout(() => setSaving(false), 1500); };
    return (
        <div data-cy="page.container" role="main" aria-label="Invoice Entry" style={{ padding: '24px', maxWidth: '800px', margin: '0 auto' }}>
            <div style={{ marginBottom: '24px' }}>
                <h1 style={{ fontSize: '1.75rem', fontWeight: 800, color: '#0F172A', margin: 0 }}>🧾 Invoice Entry</h1>
                <p style={{ color: '#94A3B8', fontSize: '0.85rem', margin: '4px 0 0' }}>Fill in the details below</p>
            </div>
            <form data-cy="form-admin.invoice-entry" onSubmit={handleSubmit} style={{ background: 'white', borderRadius: '12px', padding: '28px', border: '1px solid #E2E8F0' }}>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>Client</label>
                        <input data-cy="input-admin.invoice-entry-0" type="text" placeholder="Enter client..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>Service Date</label>
                        <input data-cy="input-admin.invoice-entry-1" type="text" placeholder="Enter service date..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>Line Items</label>
                        <input data-cy="input-admin.invoice-entry-2" type="text" placeholder="Enter line items..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>Amount</label>
                        <input data-cy="input-admin.invoice-entry-3" type="text" placeholder="Enter amount..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>Tax</label>
                        <input data-cy="input-admin.invoice-entry-4" type="text" placeholder="Enter tax..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>Notes</label>
                        <input data-cy="input-admin.invoice-entry-5" type="text" placeholder="Enter notes..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                <div style={{ display: 'flex', gap: '12px', justifyContent: 'flex-end', paddingTop: '12px', borderTop: '1px solid #F1F5F9' }}>
                    <button data-cy="btn-admin.invoice-entry-0" type="button" style={{ padding: '10px 24px', borderRadius: '8px', border: '1px solid #CBD5E1', background: 'white', color: '#64748B', fontWeight: 600, cursor: 'pointer' }}>Cancel</button>
                    <button data-cy="btn-admin.invoice-entry-1" type="submit" disabled={saving} style={{ padding: '10px 24px', borderRadius: '8px', border: 'none', background: saving?'#94A3B8':'#059669', color: 'white', fontWeight: 700, cursor: 'pointer' }}>{saving ? 'Saving...' : 'Save'}</button>
                </div>
            </form>
        </div>
    );
}

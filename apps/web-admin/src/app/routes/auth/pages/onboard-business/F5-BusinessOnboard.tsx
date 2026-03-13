// ================================================================
// PAGE IDENTITY: F5 · Business Onboard
// Type: Form | Owner: auth
// ================================================================
import React, { useState } from 'react';

export default function BusinessOnboard() {
    const [saving, setSaving] = useState(false);
    const handleSubmit = (e: React.FormEvent) => { e.preventDefault(); setSaving(true); setTimeout(() => setSaving(false), 1500); };
    return (
        <div data-cy="F5-page" style={{ padding: '24px', maxWidth: '800px', margin: '0 auto' }}>
            <div style={{ marginBottom: '24px' }}>
                <h1 style={{ fontSize: '1.75rem', fontWeight: 800, color: '#0F172A', margin: 0 }}>🏢 Business Onboard</h1>
                <p style={{ color: '#94A3B8', fontSize: '0.85rem', margin: '4px 0 0' }}>Fill in the details below</p>
            </div>
            <form data-cy="form-business-onboard" onSubmit={handleSubmit} style={{ background: 'white', borderRadius: '12px', padding: '28px', border: '1px solid #E2E8F0' }}>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>Business Name</label>
                        <input data-cy="input-business-onboard-0" type="text" placeholder="Enter business name..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>Address</label>
                        <input data-cy="input-business-onboard-1" type="text" placeholder="Enter address..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>Phone</label>
                        <input data-cy="input-business-onboard-2" type="text" placeholder="Enter phone..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>Industry</label>
                        <input data-cy="input-business-onboard-3" type="text" placeholder="Enter industry..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>License #</label>
                        <input data-cy="input-business-onboard-4" type="text" placeholder="Enter license #..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>Contact Person</label>
                        <input data-cy="input-business-onboard-5" type="text" placeholder="Enter contact person..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                <div style={{ display: 'flex', gap: '12px', justifyContent: 'flex-end', paddingTop: '12px', borderTop: '1px solid #F1F5F9' }}>
                    <button data-cy="btn-business-onboard-0" type="button" style={{ padding: '10px 24px', borderRadius: '8px', border: '1px solid #CBD5E1', background: 'white', color: '#64748B', fontWeight: 600, cursor: 'pointer' }}>Cancel</button>
                    <button data-cy="btn-business-onboard-1" type="submit" disabled={saving} style={{ padding: '10px 24px', borderRadius: '8px', border: 'none', background: saving?'#94A3B8':'#4338CA', color: 'white', fontWeight: 700, cursor: 'pointer' }}>{saving ? 'Saving...' : 'Save'}</button>
                </div>
            </form>
        </div>
    );
}

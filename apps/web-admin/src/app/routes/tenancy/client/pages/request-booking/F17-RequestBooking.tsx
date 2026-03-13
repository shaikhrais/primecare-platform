// ================================================================
// PAGE IDENTITY: F17 · Request Booking
// Type: Form | Owner: client
// ================================================================
import React, { useState } from 'react';

export default function RequestBooking() {
    const [saving, setSaving] = useState(false);
    const handleSubmit = (e: React.FormEvent) => { e.preventDefault(); setSaving(true); setTimeout(() => setSaving(false), 1500); };
    return (
        <div data-cy="F17-page" style={{ padding: '24px', maxWidth: '800px', margin: '0 auto' }}>
            <div style={{ marginBottom: '24px' }}>
                <h1 style={{ fontSize: '1.75rem', fontWeight: 800, color: '#0F172A', margin: 0 }}>📅 Request Booking</h1>
                <p style={{ color: '#94A3B8', fontSize: '0.85rem', margin: '4px 0 0' }}>Fill in the details below</p>
            </div>
            <form onSubmit={handleSubmit} style={{ background: 'white', borderRadius: '12px', padding: '28px', border: '1px solid #E2E8F0' }}>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>Service Type</label>
                        <input type="text" placeholder="Enter service type..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>Preferred Date</label>
                        <input type="text" placeholder="Enter preferred date..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>Preferred Time</label>
                        <input type="text" placeholder="Enter preferred time..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>Duration</label>
                        <input type="text" placeholder="Enter duration..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                    <div style={{ marginBottom: '20px' }}>
                        <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, color: '#334155', marginBottom: '6px' }}>Notes</label>
                        <input type="text" placeholder="Enter notes..." style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                    </div>
                <div style={{ display: 'flex', gap: '12px', justifyContent: 'flex-end', paddingTop: '12px', borderTop: '1px solid #F1F5F9' }}>
                    <button type="button" style={{ padding: '10px 24px', borderRadius: '8px', border: '1px solid #CBD5E1', background: 'white', color: '#64748B', fontWeight: 600, cursor: 'pointer' }}>Cancel</button>
                    <button type="submit" disabled={saving} style={{ padding: '10px 24px', borderRadius: '8px', border: 'none', background: saving?'#94A3B8':'#B45309', color: 'white', fontWeight: 700, cursor: 'pointer' }}>{saving ? 'Saving...' : 'Save'}</button>
                </div>
            </form>
        </div>
    );
}

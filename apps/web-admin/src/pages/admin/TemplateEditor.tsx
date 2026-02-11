import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '../../App';

export default function TemplateEditor() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [template, setTemplate] = useState('Hello {{userName}},\n\nYour visit for {{date}} has been scheduled.');

    const handleSave = () => {
        showToast('Template saved', 'success');
        setIsDirty(false);
    };

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '2rem' }} data-cy="form.template.page">
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ background: 'white', padding: '32px', borderRadius: '16px', maxWidth: '400px', textAlign: 'center' }}>
                        <h2>Discard Template?</h2>
                        <div style={{ display: 'flex', gap: '16px', marginTop: '24px' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => navigate(-1)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                        </div>
                    </div>
                </div>
            )}
            <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '1.5rem' }} data-cy="page.title">Email Template Editor</h2>
            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                <label style={{ display: 'block', marginBottom: '1rem', color: '#6b7280' }}>Variables: {"{{userName}}, {{date}}, {{service}}"}</label>
                <textarea
                    data-cy="form.template.body"
                    value={template}
                    onChange={(e) => { setTemplate(e.target.value); setIsDirty(true); }}
                    style={{ width: '100%', padding: '1rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '300px', fontFamily: 'monospace' }}
                />
                <div style={{ marginTop: '2rem', display: 'flex', gap: '1rem' }}>
                    <button
                        type="button"
                        onClick={() => isDirty ? setShowGuard(true) : navigate(-1)}
                        style={{ padding: '0.75rem 1.5rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}
                    >
                        Cancel
                    </button>
                    <button
                        data-cy="form.template.save"
                        onClick={handleSave}
                        style={{ flex: 1, padding: '0.75rem', borderRadius: '0.5rem', background: '#004d40', color: 'white', border: 'none', cursor: 'pointer' }}
                    >
                        Save Template
                    </button>
                </div>
            </div>
        </div>
    );
}

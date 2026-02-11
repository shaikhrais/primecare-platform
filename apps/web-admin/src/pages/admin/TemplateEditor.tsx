import React, { useState } from 'react';
import { useNotification } from '../../App';

export default function TemplateEditor() {
    const { showToast } = useNotification();
    const [isDirty, setIsDirty] = useState(false);
    const [template, setTemplate] = useState('Hello {{userName}},\n\nYour visit for {{date}} has been scheduled.');

    const handleSave = () => {
        showToast('Template saved', 'success');
        setIsDirty(false);
    };

    return (
        <div style={{ maxWidth: '800px', margin: '0 auto', padding: '2rem' }} data-cy="form.template.page">
            <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '1.5rem' }}>Email Template Editor</h2>
            <div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', border: '1px solid #e5e7eb' }}>
                <label style={{ display: 'block', marginBottom: '1rem', color: '#6b7280' }}>Variables: {"{{userName}}, {{date}}, {{service}}"}</label>
                <textarea
                    data-cy="form.template.body"
                    value={template}
                    onChange={(e) => { setTemplate(e.target.value); setIsDirty(true); }}
                    style={{ width: '100%', padding: '1rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '300px', fontFamily: 'monospace' }}
                />
                <button
                    data-cy="form.template.save"
                    onClick={handleSave}
                    style={{ marginTop: '2rem', padding: '0.75rem 2rem', borderRadius: '0.5rem', background: '#004d40', color: 'white', border: 'none', cursor: 'pointer' }}
                >
                    Save Template
                </button>
            </div>
        </div>
    );
}

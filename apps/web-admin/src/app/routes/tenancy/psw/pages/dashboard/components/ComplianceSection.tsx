import React from 'react';

export const ComplianceSection: React.FC = () => {
    return (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
            <div data-cy="section.notes" style={{ backgroundColor: '#000000', color: '#FFFFFF', padding: '24px', borderRadius: '16px' }}>
                <h3 style={{ margin: '0 0 12px 0', fontSize: '1.1rem', fontWeight: 800 }}>Visit Protocol</h3>
                <p style={{ fontSize: '0.9rem', lineHeight: 1.6, opacity: 0.9, margin: 0 }}>
                    Please ensure you have all necessary supplies for diabetic foot care visits and record your notes immediately after visit completion.
                </p>
            </div>

            <div data-cy="section.compliance" style={{ backgroundColor: '#E6F4EF', border: '1px solid #00875A', padding: '24px', borderRadius: '16px' }}>
                <h3 style={{ margin: '0 0 12px 0', color: '#00875A', fontSize: '1.1rem', fontWeight: 800 }}>Compliance</h3>
                <p style={{ fontSize: '0.875rem', color: '#000000', fontWeight: 600, margin: 0 }}>
                    ✅ Your certifications are active.<br />
                    <span style={{ fontSize: '0.8rem', fontWeight: 400, opacity: 0.7 }}>Next renewal: June 2026.</span>
                </p>
            </div>
        </div>
    );
};

import React from 'react';

const LocalizationPage: React.FC = () => {
    return (
        <div data-cy="page.container" style={{ padding: '2rem' }}>
            <h1 data-cy="page.title">Localization Health</h1>
            <p>Audit of i18n coverage and translation registry integrity.</p>
            <div style={{ marginTop: '2rem' }}>
                <div style={{ margin: '1rem 0' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
                        <span>English (Master)</span>
                        <span>100%</span>
                    </div>
                    <div style={{ height: '8px', background: '#e5e7eb', borderRadius: '4px' }}>
                        <div style={{ height: '100%', width: '100%', background: '#3b82f6', borderRadius: '4px' }}></div>
                    </div>
                </div>
                <div style={{ margin: '1rem 0' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
                        <span>French (Canadian)</span>
                        <span>94%</span>
                    </div>
                    <div style={{ height: '8px', background: '#e5e7eb', borderRadius: '4px' }}>
                        <div style={{ height: '100%', width: '94%', background: '#3b82f6', borderRadius: '4px' }}></div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default LocalizationPage;

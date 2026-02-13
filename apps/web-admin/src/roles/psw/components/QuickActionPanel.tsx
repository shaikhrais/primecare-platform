import React from 'react';

export const QuickActionPanel: React.FC = () => {
    const actions = [
        { label: 'Incident Report', icon: '🚨', color: '#EF4444' },
        { label: 'Record Vitals', icon: '🩺', color: '#00875A' },
        { label: 'Progress Note', icon: '📝', color: '#3B82F6' },
        { label: 'Help Desk', icon: '❓', color: '#6B7280' },
    ];

    return (
        <div data-cy="quick-action-panel">
            <h4 style={{ margin: '0 0 16px 0', fontSize: '0.9rem', fontWeight: 800, textTransform: 'uppercase', color: '#6B7280' }}>
                Quick Actions
            </h4>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '12px' }}>
                {actions.map(action => (
                    <button
                        key={action.label}
                        style={{
                            display: 'flex',
                            flexDirection: 'column',
                            alignItems: 'center',
                            justifyContent: 'center',
                            gap: '8px',
                            padding: '16px',
                            backgroundColor: '#FFFFFF',
                            border: '1px solid #E5E7EB',
                            borderRadius: '12px',
                            cursor: 'pointer',
                            transition: 'all 0.2s'
                        }}
                    >
                        <span style={{ fontSize: '1.5rem' }}>{action.icon}</span>
                        <span style={{ fontSize: '0.75rem', fontWeight: 700, color: '#374151' }}>{action.label}</span>
                    </button>
                ))}
            </div>
        </div>
    );
};

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
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(130px, 1fr))', gap: '1rem' }}>
                {actions.map(action => (
                    <button
                        key={action.label}
                        style={{
                            display: 'flex',
                            flexDirection: 'column',
                            alignItems: 'center',
                            justifyContent: 'center',
                            gap: '12px',
                            padding: '24px 16px',
                            backgroundColor: '#FFFFFF',
                            border: '1px solid #E5E7EB',
                            borderRadius: '20px',
                            cursor: 'pointer',
                            transition: 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                            boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)',
                        }}
                        onMouseOver={(e) => {
                            e.currentTarget.style.transform = 'translateY(-4px)';
                            e.currentTarget.style.boxShadow = '0 10px 15px -3px rgba(0, 0, 0, 0.1)';
                            e.currentTarget.style.borderColor = action.color;
                        }}
                        onMouseOut={(e) => {
                            e.currentTarget.style.transform = 'translateY(0)';
                            e.currentTarget.style.boxShadow = '0 4px 6px -1px rgba(0, 0, 0, 0.05)';
                            e.currentTarget.style.borderColor = '#E5E7EB';
                        }}
                    >
                        <span style={{ fontSize: '1.75rem' }}>{action.icon}</span>
                        <span style={{ fontSize: '0.8rem', fontWeight: 800, color: '#111827' }}>{action.label}</span>
                    </button>
                ))}
            </div>
        </div>
    );
};

import React from 'react';

interface QuickReportMacrosProps {
    onSelectMacro: (text: string) => void;
}

export const QuickReportMacros: React.FC<QuickReportMacrosProps> = ({ onSelectMacro }) => {
    const macros = [
        "Patient slept well through the night.",
        "Ate 100% of provided meal.",
        "Ate 50% of provided meal.",
        "Refused medication this morning.",
        "Experiencing increased pain today.",
        "No issues reported, routine care provided.",
        "Family member present during visit."
    ];

    return (
        <div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px', marginBottom: '16px' }}>
            <span style={{ width: '100%', fontSize: '0.8rem', fontWeight: 600, color: '#64748B', textTransform: 'uppercase' }}>Quick Macros:</span>
            {macros.map((macro, i) => (
                <button
                    key={i}
                    onClick={() => onSelectMacro(macro)}
                    style={{
                        padding: '8px 12px',
                        backgroundColor: '#F1F5F9',
                        border: '1px solid #E2E8F0',
                        borderRadius: '20px',
                        fontSize: '0.85rem',
                        color: '#334155',
                        cursor: 'pointer',
                        transition: 'background-color 0.2s'
                    }}
                    onMouseOver={(e) => e.currentTarget.style.backgroundColor = '#E2E8F0'}
                    onMouseOut={(e) => e.currentTarget.style.backgroundColor = '#F1F5F9'}
                >
                    {macro}
                </button>
            ))}
        </div>
    );
};

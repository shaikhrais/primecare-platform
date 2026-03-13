import React from 'react';

interface ViewToggleProps {
    viewMode: 'calendar' | 'list';
    setViewMode: (mode: 'calendar' | 'list') => void;
}

export const ViewToggle: React.FC<ViewToggleProps> = ({ viewMode, setViewMode }) => {
    return (
        <div style={{ marginBottom: '1rem', display: 'flex', justifyContent: 'flex-end', gap: '0.5rem' }}>
            <button data-cy="btn-admin.view-toggle-0"
                onClick={() => setViewMode('calendar')}
                style={{
                    padding: '0.5rem 1rem',
                    backgroundColor: viewMode === 'calendar' ? '#e5e7eb' : 'white',
                    border: '1px solid #d1d5db',
                    borderRadius: '0.375rem',
                    cursor: 'pointer',
                    fontWeight: viewMode === 'calendar' ? 600 : 400
                }}
            >
                Calendar
            </button>
            <button data-cy="btn-admin.view-toggle-1"
                onClick={() => setViewMode('list')}
                style={{
                    padding: '0.5rem 1rem',
                    backgroundColor: viewMode === 'list' ? '#e5e7eb' : 'white',
                    border: '1px solid #d1d5db',
                    borderRadius: '0.375rem',
                    cursor: 'pointer',
                    fontWeight: viewMode === 'list' ? 600 : 400
                }}
            >
                List View
            </button>
        </div>
    );
};

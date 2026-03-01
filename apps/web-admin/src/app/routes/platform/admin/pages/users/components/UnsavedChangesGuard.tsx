import React from 'react';

interface UnsavedChangesGuardProps {
    isOpen: boolean;
    onStay: () => void;
    onLeave: () => void;
}

export const UnsavedChangesGuard: React.FC<UnsavedChangesGuardProps> = ({ isOpen, onStay, onLeave }) => {
    if (!isOpen) return null;

    return (
        <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <div style={{ background: 'white', padding: '32px', borderRadius: '16px', maxWidth: '400px', textAlign: 'center' }}>
                <h2>Discard Changes?</h2>
                <p style={{ opacity: 0.8, marginBottom: '24px' }}>Any unsaved changes will be lost.</p>
                <div style={{ display: 'flex', gap: '16px' }}>
                    <button data-cy="guard.unsaved.leave" onClick={onLeave} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Leave</button>
                    <button data-cy="guard.unsaved.stay" onClick={onStay} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                </div>
            </div>
        </div>
    );
};

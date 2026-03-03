import React from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

interface DailyEntryGuardProps {
    showGuard: boolean;
    setShowGuard: (show: boolean) => void;
}

export const DailyEntryGuard: React.FC<DailyEntryGuardProps> = ({ showGuard, setShowGuard }) => {
    const navigate = useNavigate();

    if (!showGuard) return null;

    return (
        <div data-cy="guard.unsaved.dialog" style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.7)', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <div style={{ background: 'var(--bg-elev)', padding: '32px', borderRadius: '16px', border: '1px solid var(--line)', maxWidth: '400px', textAlign: 'center', color: 'var(--text)' }}>
                <h2 style={{ marginTop: 0 }}>{ContentRegistry.DAILY_ENTRY.GUARD.TITLE}</h2>
                <p style={{ opacity: 0.8, marginBottom: '24px' }}>{ContentRegistry.DAILY_ENTRY.GUARD.DESC}</p>
                <div style={{ display: 'flex', gap: '16px' }}>
                    <button data-cy="guard.unsaved.leave" onClick={() => navigate(RouteRegistry.MANAGER.DASHBOARD)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid var(--line)', background: 'transparent', cursor: 'pointer', color: 'var(--text)' }}>
                        {ContentRegistry.DAILY_ENTRY.GUARD.LEAVE}
                    </button>
                    <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '12px', borderRadius: '8px', border: 'none', background: 'var(--primary)', color: 'white', cursor: 'pointer', fontWeight: 600 }}>
                        {ContentRegistry.DAILY_ENTRY.GUARD.STAY}
                    </button>
                </div>
            </div>
        </div>
    );
};

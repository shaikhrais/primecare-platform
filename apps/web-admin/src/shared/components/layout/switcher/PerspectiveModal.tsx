import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

// Components
import { UmbrellaRoleSwitcher } from './components/UmbrellaRoleSwitcher';
import { ImpersonationSearch } from './components/ImpersonationSearch';

const { ContentRegistry } = AdminRegistry;

interface PerspectiveModalProps {
    isOpen: boolean;
    onClose: () => void;
    isImpersonating: boolean;
    activeRole: string;
    roles: string[];
    handleSwitchRole: (role: string) => void;
    loading: boolean;
    isAdmin: boolean;
    exitImpersonation: () => void;
    searchQuery: string;
    setSearchQuery: (query: string) => void;
    setShowImpersonate: (show: boolean) => void;
    showImpersonate: boolean;
    filteredUsers: any[];
    handleImpersonate: (user: any) => void;
}

export function PerspectiveModal({
    isOpen,
    onClose,
    isImpersonating,
    activeRole,
    roles,
    handleSwitchRole,
    loading,
    isAdmin,
    exitImpersonation,
    searchQuery,
    setSearchQuery,
    setShowImpersonate,
    showImpersonate,
    filteredUsers,
    handleImpersonate
}: PerspectiveModalProps) {
    if (!isOpen) return null;

    return (
        <div style={{
            position: 'fixed',
            top: 0, left: 0, right: 0, bottom: 0,
            zIndex: 9999,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            padding: '20px'
        }}>
            {/* Backdrop */}
            <div
                onClick={onClose}
                style={{
                    position: 'absolute',
                    top: 0, left: 0, right: 0, bottom: 0,
                    background: 'rgba(0,0,0,0.5)',
                    backdropFilter: 'blur(4px)',
                    zIndex: -1
                }}
            />

            {/* Modal Content */}
            <div style={{
                width: '100%',
                maxWidth: '450px',
                background: 'white',
                borderRadius: '20px',
                overflow: 'hidden',
                boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.25)',
                animation: 'pc-modal-slide-up 0.3s ease-out'
            }}>
                {/* Header */}
                <div style={{
                    padding: '24px',
                    background: isImpersonating ? 'linear-gradient(135deg, #FFF7ED 0%, #FFEDD5 100%)' : 'linear-gradient(135deg, #F9FAFB 0%, #F3F4F6 100%)',
                    borderBottom: '1px solid var(--line)',
                    display: 'flex',
                    justifyContent: 'space-between',
                    alignItems: 'center'
                }}>
                    <div>
                        <h3 data-cy="h3-shared.perspective-modal-0" style={{ margin: 0, fontSize: '18px', fontWeight: 800, color: 'var(--text-400)' }}>
                            {isImpersonating
                                ? ContentRegistry.LAYOUT.PERSPECTIVE_MODAL.TITLE_IMPERSONATE
                                : ContentRegistry.LAYOUT.PERSPECTIVE_MODAL.TITLE_MAIN}
                        </h3>
                        <p style={{ margin: '4px 0 0 0', fontSize: '12px', color: 'var(--text-300)' }}>
                            {isImpersonating
                                ? ContentRegistry.LAYOUT.PERSPECTIVE_MODAL.SUBTITLE_IMPERSONATE
                                : ContentRegistry.LAYOUT.PERSPECTIVE_MODAL.SUBTITLE_MAIN}
                        </p>
                    </div>
                    <button data-cy="btn-shared.perspective-modal-0"
                        onClick={onClose}
                        style={{ background: 'none', border: 'none', fontSize: '24px', cursor: 'pointer', color: 'var(--text-300)' }}
                    >
                        ×
                    </button>
                </div>

                <div style={{ padding: '24px' }}>
                    <UmbrellaRoleSwitcher
                        roles={roles}
                        activeRole={activeRole}
                        loading={loading}
                        handleSwitchRole={handleSwitchRole}
                    />

                    <ImpersonationSearch
                        isAdmin={isAdmin}
                        isImpersonating={isImpersonating}
                        exitImpersonation={exitImpersonation}
                        searchQuery={searchQuery}
                        setSearchQuery={setSearchQuery}
                        setShowImpersonate={setShowImpersonate}
                        showImpersonate={showImpersonate}
                        filteredUsers={filteredUsers}
                        handleImpersonate={handleImpersonate}
                    />
                </div>

                {/* Footer */}
                <div style={{ padding: '16px 24px', background: '#F9FAFB', borderTop: '1px solid var(--line)', display: 'flex', justifyContent: 'flex-end' }}>
                    <button data-cy="btn-shared.perspective-modal-1"
                        onClick={onClose}
                        style={{ padding: '10px 20px', fontSize: '13px', fontWeight: 700, color: 'var(--text-300)', background: 'none', border: 'none', cursor: 'pointer' }}
                    >
                        {ContentRegistry.SCHEDULE.ACTIONS.CLOSE}
                    </button>
                </div>
            </div>

            <style>{`
                @keyframes pc-modal-slide-up {
                    from { transform: translateY(10px); opacity: 0; }
                    to { transform: translateY(0); opacity: 1; }
                }
            `}</style>
        </div>
    );
}

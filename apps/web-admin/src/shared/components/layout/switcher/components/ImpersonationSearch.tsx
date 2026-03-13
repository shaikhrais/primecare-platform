import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface ImpersonationSearchProps {
    isAdmin: boolean;
    isImpersonating: boolean;
    exitImpersonation: () => void;
    searchQuery: string;
    setSearchQuery: (query: string) => void;
    setShowImpersonate: (show: boolean) => void;
    showImpersonate: boolean;
    filteredUsers: any[];
    handleImpersonate: (user: any) => void;
}

export const ImpersonationSearch: React.FC<ImpersonationSearchProps> = ({
    isAdmin,
    isImpersonating,
    exitImpersonation,
    searchQuery,
    setSearchQuery,
    setShowImpersonate,
    showImpersonate,
    filteredUsers,
    handleImpersonate
}) => {
    if (!isAdmin) return null;

    return (
        <div style={{ borderTop: '1px solid var(--line)', paddingTop: '24px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '12px' }}>
                <div style={{ fontSize: '11px', fontWeight: 800, color: 'var(--text-200)', textTransform: 'uppercase', letterSpacing: '0.05em' }}>
                    {ContentRegistry.LAYOUT.PERSPECTIVE_MODAL.SECTION_IMPERSONATE}
                </div>
                {isImpersonating && (
                    <button data-cy="btn-shared.impersonation-search-0" onClick={exitImpersonation} style={{
                        padding: '6px 12px', fontSize: '11px', background: '#EF4444', color: 'white', border: 'none', borderRadius: '6px', cursor: 'pointer', fontWeight: 800
                    }}>
                        {ContentRegistry.LAYOUT.PERSPECTIVE_MODAL.EXIT_IMPERSONATE}
                    </button>
                )}
            </div>

            <div style={{ position: 'relative' }}>
                <input data-cy="input-shared.impersonation-search-0"
                    type="text"
                    placeholder={ContentRegistry.LAYOUT.PERSPECTIVE_MODAL.SEARCH_PLACEHOLDER}
                    value={searchQuery}
                    onChange={(e) => {
                        setSearchQuery(e.target.value);
                        setShowImpersonate(true);
                    }}
                    style={{
                        width: '100%', padding: '14px 14px 14px 40px', fontSize: '14px', border: '1px solid var(--line)', borderRadius: '12px', boxSizing: 'border-box', background: '#F9FAFB'
                    }}
                />
                <span style={{ position: 'absolute', left: '14px', top: '50%', transform: 'translateY(-50%)', opacity: 0.5 }}>🔍</span>
            </div>

            {showImpersonate && searchQuery && (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '8px', marginTop: '12px' }}>
                    {filteredUsers.map(user => (
                        <button data-cy="btn-shared.impersonation-search-1"
                            key={user.id}
                            onClick={() => handleImpersonate(user)}
                            style={{
                                padding: '12px', fontSize: '13px', textAlign: 'left', background: 'white', border: '1px solid #F3F4F6', borderRadius: '10px', cursor: 'pointer', display: 'flex', justifyContent: 'space-between', alignItems: 'center'
                            }}
                        >
                            <div style={{ display: 'flex', flexDirection: 'column' }}>
                                <span style={{ fontWeight: 600, color: 'var(--text-400)' }}>{user.email}</span>
                                <span style={{ fontSize: '10px', color: 'var(--text-300)' }}>UID: {user.id}</span>
                            </div>
                            <span style={{ color: 'var(--brand-600)', fontWeight: 800, fontSize: '11px' }}>
                                {ContentRegistry.LAYOUT.PERSPECTIVE_MODAL.IMPERSONATE_ACTION}
                            </span>
                        </button>
                    ))}
                </div>
            )}
        </div>
    );
};

import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface UserInviteModalProps {
    isOpen: boolean;
    onClose: () => void;
    onSubmit: (email: string) => Promise<void>;
    submitting: boolean;
}

export function UserInviteModal({ isOpen, onClose, onSubmit, submitting }: UserInviteModalProps) {
    const { t } = useTranslation();
    const [inviteEmail, setInviteEmail] = useState('');
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);

    if (!isOpen) return null;

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!inviteEmail) return;
        await onSubmit(inviteEmail);
        setInviteEmail('');
        setIsDirty(false);
    };

    const handleClose = () => {
        if (isDirty) {
            setShowGuard(true);
        } else {
            onClose();
        }
    };

    return (
        <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }}>
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'absolute', inset: 0, backgroundColor: 'rgba(0,0,0,0.8)', zIndex: 1001, display: 'flex', alignItems: 'center', justifyContent: 'center', borderRadius: '0.5rem' }}>
                    <div style={{ background: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '350px', textAlign: 'center' }}>
                        <h4 style={{ margin: '0 0 1rem 0' }}>{t(ContentRegistry.USERS.MODAL.DISCARD_TITLE)}</h4>
                        <p style={{ fontSize: '0.9rem', color: '#6b7280', marginBottom: '1.5rem' }}>{t(ContentRegistry.USERS.MODAL.DISCARD_DESC)}</p>
                        <div style={{ display: 'flex', gap: '1rem' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => { setIsDirty(false); setShowGuard(false); onClose(); }} style={{ flex: 1, padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>{t(ContentRegistry.USERS.MODAL.DISCARD_BTN)}</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '0.625rem', borderRadius: '0.375rem', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>{t(ContentRegistry.USERS.MODAL.STAY_BTN)}</button>
                        </div>
                    </div>
                </div>
            )}
            <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '400px', width: '90%', position: 'relative' }} data-cy="modal.user.invite.container">
                <h3 style={{ marginTop: 0 }}>{t(ContentRegistry.USERS.MODAL.INVITE_TITLE)}</h3>
                <div style={{ marginTop: '1.5rem' }}>
                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>{t(ContentRegistry.AUTH.EMAIL_LABEL)}</label>
                    <input
                        data-cy="modal.user.invite.email"
                        type="email"
                        value={inviteEmail}
                        onChange={(e) => { setInviteEmail(e.target.value); setIsDirty(true); }}
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        required
                        placeholder={t(ContentRegistry.USERS.INVITE_PROMPT)}
                    />
                </div>
                <div style={{ display: 'flex', gap: '1rem', marginTop: '2rem' }}>
                    <button
                        type="button"
                        data-cy="modal.user.invite.close"
                        onClick={handleClose}
                        style={{ flex: 1, padding: '0.75rem', backgroundColor: '#f3f4f6', border: 'none', borderRadius: '0.5rem', cursor: 'pointer' }}
                    >
                        {t(ContentRegistry.COMMON.CLOSE)}
                    </button>
                    <button
                        type="submit"
                        data-cy="modal.user.invite.save"
                        disabled={submitting}
                        style={{ flex: 1, padding: '0.75rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                    >
                        {submitting ? t(ContentRegistry.USERS.MODAL.SENDING) : t(ContentRegistry.USERS.MODAL.SEND_BTN)}
                    </button>
                </div>
            </form>
        </div>
    );
}

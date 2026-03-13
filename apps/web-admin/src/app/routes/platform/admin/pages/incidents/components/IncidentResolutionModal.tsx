import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

const { ContentRegistry } = AdminRegistry;

interface IncidentResolutionModalProps {
    isOpen: boolean;
    onClose: () => void;
    onResolve: (notes: string) => Promise<void>;
    submitting: boolean;
}

export function IncidentResolutionModal({
    isOpen,
    onClose,
    onResolve,
    submitting
}: IncidentResolutionModalProps) {
    const { t } = useTranslation();
    const [resolutionNotes, setResolutionNotes] = useState('');
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);

    useEffect(() => {
        if (isOpen) {
            setResolutionNotes('');
            setIsDirty(false);
            setShowGuard(false);
        }
    }, [isOpen]);

    const handleClose = () => {
        if (isDirty) {
            setShowGuard(true);
        } else {
            onClose();
        }
    };

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        onResolve(resolutionNotes);
    };

    if (!isOpen) return null;

    return (
        <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }}>
            {showGuard && (
                <div data-cy="guard.unsaved.dialog" style={{ position: 'absolute', inset: 0, backgroundColor: 'rgba(0,0,0,0.8)', zIndex: 1001, display: 'flex', alignItems: 'center', justifyContent: 'center', borderRadius: '0.5rem' }}>
                    <div style={{ background: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '350px', textAlign: 'center' }}>
                        <h4 style={{ margin: '0 0 1rem 0' }}>{t(ContentRegistry.INCIDENTS.RESOLVE.DISCARD_TITLE)}</h4>
                        <p style={{ fontSize: '0.9rem', color: '#6b7280', marginBottom: '1.5rem' }}>{t(ContentRegistry.INCIDENTS.RESOLVE.DISCARD_DESC)}</p>
                        <div style={{ display: 'flex', gap: '1rem' }}>
                            <button data-cy="guard.unsaved.leave" onClick={() => { setIsDirty(false); setShowGuard(false); onClose(); }} style={{ flex: 1, padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>{t(ContentRegistry.USERS.MODAL.DISCARD_BTN)}</button>
                            <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '0.625rem', borderRadius: '0.375rem', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>{t(ContentRegistry.USERS.MODAL.STAY_BTN)}</button>
                        </div>
                    </div>
                </div>
            )}
            <form onSubmit={handleSubmit} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '500px', width: '90%', position: 'relative' }} data-cy="modal.incident.resolve.container">
                <h3 data-cy="h3-admin.incident-resolution-modal-0" style={{ marginTop: 0 }}>{t(ContentRegistry.INCIDENTS.RESOLVE.TITLE)}</h3>
                <div style={{ marginTop: '1.5rem' }}>
                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>{t(ContentRegistry.INCIDENTS.RESOLVE.NOTES_LABEL)}</label>
                    <textarea
                        data-cy="modal.incident.resolve.notes"
                        value={resolutionNotes}
                        onChange={(e) => { setResolutionNotes(e.target.value); setIsDirty(true); }}
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '120px' }}
                        required
                        placeholder={t(ContentRegistry.INCIDENTS.RESOLVE.NOTES_PLACEHOLDER)}
                    />
                </div>
                <div style={{ display: 'flex', gap: '1rem', marginTop: '2rem' }}>
                    <button
                        type="button"
                        data-cy="modal.incident.resolve.close"
                        onClick={handleClose}
                        style={{ flex: 1, padding: '0.75rem', backgroundColor: '#f3f4f6', border: 'none', borderRadius: '0.5rem', cursor: 'pointer' }}
                    >
                        {t(ContentRegistry.COMMON.BACK)}
                    </button>
                    <button
                        type="submit"
                        data-cy="modal.incident.resolve.save"
                        disabled={submitting}
                        style={{ flex: 1, padding: '0.75rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                    >
                        {submitting ? t(ContentRegistry.INCIDENTS.RESOLVE.RESOLVING_LOADING) : t(ContentRegistry.INCIDENTS.RESOLVE.TITLE)}
                    </button>
                </div>
            </form>
        </div>
    );
}

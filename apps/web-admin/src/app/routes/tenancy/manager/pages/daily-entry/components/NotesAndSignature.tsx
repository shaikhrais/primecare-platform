import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface NotesAndSignatureProps {
    notes: string;
    setNotes: (notes: string) => void;
    signature: string;
    setSignature: (signature: string) => void;
    setIsDirty: (dirty: boolean) => void;
    handleSubmit: (isDraft: boolean) => void;
    submitting: boolean;
}

export const NotesAndSignature: React.FC<NotesAndSignatureProps> = ({
    notes,
    setNotes,
    signature,
    setSignature,
    setIsDirty,
    handleSubmit,
    submitting
}) => {
    return (
        <div style={{ marginTop: '32px' }}>
            <h3 style={{ borderBottom: '2px solid var(--line)', paddingBottom: '8px', marginBottom: '16px' }}>{ContentRegistry.DAILY_ENTRY.NOTES_TITLE}</h3>
            <textarea
                data-cy="form.daily.notes"
                placeholder={ContentRegistry.DAILY_ENTRY.NOTES_PLACEHOLDER}
                value={notes}
                onChange={(e) => {
                    setNotes(e.target.value);
                    setIsDirty(true);
                }}
                style={{ width: '100%', minHeight: '120px', padding: '16px', borderRadius: '12px', border: '1px solid var(--line)', background: 'var(--bg)', marginBottom: '24px', resize: 'vertical' }}
            />

            <div style={{ display: 'flex', gap: '24px', alignItems: 'flex-end', flexWrap: 'wrap' }}>
                <div style={{ flex: 1, minWidth: '250px' }}>
                    <label style={{ display: 'block', marginBottom: '8px', fontWeight: 600 }}>{ContentRegistry.DAILY_ENTRY.SIGNATURE_LABEL}</label>
                    <input
                        data-cy="form.daily.signature"
                        placeholder={ContentRegistry.DAILY_ENTRY.SIGNATURE_PLACEHOLDER}
                        value={signature}
                        onChange={(e) => {
                            setSignature(e.target.value);
                            setIsDirty(true);
                        }}
                        style={{ width: '100%', padding: '14px', borderRadius: '8px', border: '1px solid var(--line)', background: 'var(--bg)', fontFamily: 'monospace' }}
                    />
                </div>
                <div style={{ display: 'flex', gap: '16px' }}>
                    <button
                        onClick={() => {
                            setIsDirty(false);
                            handleSubmit(true);
                        }}
                        disabled={submitting}
                        data-cy="form.daily.save"
                        style={{ padding: '14px 24px', borderRadius: '50px', border: '1px solid var(--line)', background: 'transparent', cursor: 'pointer', fontWeight: 600 }}
                    >
                        {ContentRegistry.DAILY_ENTRY.SAVE_DRAFT}
                    </button>
                    <button
                        onClick={() => {
                            setIsDirty(false);
                            handleSubmit(false);
                        }}
                        disabled={submitting}
                        className="btn btn-primary"
                        data-cy="form.daily.submit"
                        style={{ padding: '14px 32px', borderRadius: '50px', fontWeight: 800 }}
                    >
                        {submitting ? ContentRegistry.DAILY_ENTRY.SUBMITTING : ContentRegistry.DAILY_ENTRY.SUBMIT}
                    </button>
                </div>
            </div>
        </div>
    );
};

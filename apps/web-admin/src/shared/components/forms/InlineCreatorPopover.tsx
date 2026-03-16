import React, { useState } from 'react';
import { Plus, X, Loader2, CheckCircle2 } from 'lucide-react';
import { apiClient } from '@/shared/utils/apiClient';
import { useMutation } from '@tanstack/react-query';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import type { FormDependency } from 'prime-care-shared';

interface InlineCreatorPopoverProps {
    dependency: FormDependency;
    /** Called after a new record is created – parent re-fetches dropdown options */
    onCreated: () => void;
}

/**
 * Inline popover that lets users create a dependent record (e.g. Service Type,
 * Client, PSW) without leaving the current form. Submits to the dependency's
 * `inlineCreateEndpoint`, then calls `onCreated` so the parent can refresh its
 * dropdown list.
 */
export const InlineCreatorPopover: React.FC<InlineCreatorPopoverProps> = ({ dependency, onCreated }) => {
    const [isOpen, setIsOpen] = useState(false);
    const [isSuccess, setIsSuccess] = useState(false);
    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const { showToast } = useNotification();

    // Determine which fields to show based on entity type
    const needsEmail = ['client', 'psw', 'user'].includes(dependency.entityType);

    const createMutation = useMutation({
        mutationFn: async (payload: Record<string, string>) => {
            const res = await apiClient.post(dependency.inlineCreateEndpoint, payload);
            if (!res.ok) {
                const err = await res.json().catch(() => ({ error: 'Request failed' }));
                throw new Error(err.error || 'Request failed');
            }
            return res.json();
        },
        onSuccess: () => {
            setIsSuccess(true);
            showToast(`${dependency.entityType} "${name}" created successfully`, 'success');
            // Brief success animation, then close & notify parent
            setTimeout(() => {
                setName('');
                setEmail('');
                setIsOpen(false);
                setIsSuccess(false);
                onCreated();
            }, 600);
        },
        onError: (error: any) => {
            showToast(error.message || `Failed to create ${dependency.entityType}`, 'error');
        },
    });

    const isSubmitting = createMutation.isPending;

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!name.trim()) return;

        const payload: Record<string, string> = { name: name.trim() };
        if (needsEmail && email.trim()) {
            payload.email = email.trim();
            const parts = name.trim().split(' ');
            payload.firstName = parts[0] || '';
            payload.lastName = parts.slice(1).join(' ') || '';
            if (dependency.entityType === 'psw') payload.role = 'psw';
        }

        createMutation.mutate(payload);
    };

    if (!isOpen) {
        return (
            <button
                type="button"
                data-cy={`btn-inline-create-${dependency.entityType}`}
                onClick={() => setIsOpen(true)}
                style={{
                    display: 'flex', alignItems: 'center', gap: '4px',
                    background: 'transparent', border: '1px dashed var(--brand-300, #93C5FD)',
                    color: 'var(--brand-600, #2563EB)', borderRadius: '6px',
                    padding: '4px 10px', fontSize: '0.75rem', fontWeight: 700,
                    cursor: 'pointer', marginTop: '4px', transition: 'all 0.15s',
                }}
            >
                <Plus size={12} /> {dependency.inlineCreateLabel}
            </button>
        );
    }

    return (
        <div
            data-cy={`inline-creator-${dependency.entityType}`}
            style={{
                marginTop: '8px', padding: '16px',
                background: 'var(--bg-100, #F8FAFC)',
                border: '1px solid var(--brand-200, #BFDBFE)',
                borderRadius: '10px',
                boxShadow: '0 4px 12px rgba(37, 99, 235, 0.08)',
                position: 'relative',
            }}
        >
            {/* Close button */}
            <button
                type="button"
                data-cy={`btn-close-inline-${dependency.entityType}`}
                onClick={() => { setIsOpen(false); setName(''); setEmail(''); }}
                style={{
                    position: 'absolute', top: '8px', right: '8px',
                    background: 'transparent', border: 'none', cursor: 'pointer',
                    color: 'var(--text-300, #94A3B8)', padding: '2px',
                }}
            >
                <X size={14} />
            </button>

            <div style={{ fontSize: '0.8rem', fontWeight: 700, color: 'var(--text-100, #0F172A)', marginBottom: '10px', display: 'flex', alignItems: 'center', gap: '6px' }}>
                <Plus size={14} color="var(--brand-500, #3B82F6)" />
                Quick Create: {dependency.entityType.charAt(0).toUpperCase() + dependency.entityType.slice(1)}
            </div>

            <form data-cy="form-shared.inline-creator-popover" onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
                <input
                    data-cy={`inline-input-name-${dependency.entityType}`}
                    type="text"
                    placeholder={needsEmail ? 'Full Name' : 'Name'}
                    value={name}
                    onChange={e => setName(e.target.value)}
                    required
                    autoFocus
                    style={{
                        padding: '8px 12px', borderRadius: '6px',
                        border: '1px solid var(--border, #CBD5E1)',
                        fontSize: '0.85rem', outline: 'none',
                        width: '100%', boxSizing: 'border-box',
                    }}
                />

                {needsEmail && (
                    <input
                        data-cy={`inline-input-email-${dependency.entityType}`}
                        type="email"
                        placeholder="Email address"
                        value={email}
                        onChange={e => setEmail(e.target.value)}
                        style={{
                            padding: '8px 12px', borderRadius: '6px',
                            border: '1px solid var(--border, #CBD5E1)',
                            fontSize: '0.85rem', outline: 'none',
                            width: '100%', boxSizing: 'border-box',
                        }}
                    />
                )}

                <button
                    type="submit"
                    data-cy={`btn-submit-inline-${dependency.entityType}`}
                    disabled={isSubmitting || !name.trim()}
                    style={{
                        display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '6px',
                        padding: '8px 16px', borderRadius: '6px', border: 'none',
                        background: isSuccess ? '#10B981' : 'var(--brand-500, #2563EB)',
                        color: 'white', fontWeight: 700, fontSize: '0.8rem',
                        cursor: isSubmitting ? 'wait' : 'pointer',
                        opacity: !name.trim() ? 0.5 : 1,
                        transition: 'all 0.2s',
                    }}
                >
                    {isSubmitting ? (
                        <><Loader2 size={14} className="animate-spin" /> Creating...</>
                    ) : isSuccess ? (
                        <><CheckCircle2 size={14} /> Created!</>
                    ) : (
                        <><Plus size={14} /> Create & Add to List</>
                    )}
                </button>
            </form>
        </div>
    );
};

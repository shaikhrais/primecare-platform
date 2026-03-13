import React, { useState, useCallback, useRef } from 'react';
import { ConfirmModal } from '../components/modals/ConfirmModal';
import { PromptModal } from '../components/modals/PromptModal';

/* ─────────────────────────────────────────────────────────────────────────────
 * useDialog — Hook providing Promise-based confirm / alert / prompt dialogs.
 *
 * Usage:
 *   const { confirm, alert, prompt, DialogRenderer } = useDialog();
 *
 *   // In an event handler:
 *   const ok = await confirm('Delete item?', 'This cannot be undone.');
 *   if (ok) deleteItem();
 *
 *   // In JSX (render once, near the return):
 *   return <><YourComponent /><DialogRenderer /></>;
 * ────────────────────────────────────────────────────────────────────────── */

type ConfirmVariant = 'danger' | 'warning' | 'info';

interface ConfirmState {
    title: string;
    message: string;
    variant: ConfirmVariant;
    confirmLabel?: string;
}

interface PromptState {
    title: string;
    message: string;
    placeholder?: string;
    defaultValue?: string;
    submitLabel?: string;
}

export function useDialog() {
    const [confirmState, setConfirmState] = useState<ConfirmState | null>(null);
    const [promptState, setPromptState] = useState<PromptState | null>(null);

    const confirmResolveRef = useRef<((value: boolean) => void) | null>(null);
    const promptResolveRef = useRef<((value: string | null) => void) | null>(null);

    /** Show a confirm modal. Returns true if user clicks Confirm, false if Cancel. */
    const confirm = useCallback((
        title: string,
        message: string,
        options?: { variant?: ConfirmVariant; confirmLabel?: string }
    ): Promise<boolean> => {
        return new Promise<boolean>((resolve) => {
            confirmResolveRef.current = resolve;
            setConfirmState({
                title, message,
                variant: options?.variant || 'danger',
                confirmLabel: options?.confirmLabel,
            });
        });
    }, []);

    /** Show an alert modal (single OK button). */
    const alert = useCallback((title: string, message: string): Promise<void> => {
        return new Promise<void>((resolve) => {
            confirmResolveRef.current = () => resolve();
            setConfirmState({
                title, message,
                variant: 'info',
                confirmLabel: 'OK',
            });
        });
    }, []);

    /** Show a prompt modal with text input. Returns the entered string or null if cancelled. */
    const prompt = useCallback((
        title: string,
        message: string,
        options?: { placeholder?: string; defaultValue?: string; submitLabel?: string }
    ): Promise<string | null> => {
        return new Promise<string | null>((resolve) => {
            promptResolveRef.current = resolve;
            setPromptState({
                title, message,
                placeholder: options?.placeholder,
                defaultValue: options?.defaultValue,
                submitLabel: options?.submitLabel,
            });
        });
    }, []);

    const handleConfirm = useCallback(() => {
        confirmResolveRef.current?.(true);
        confirmResolveRef.current = null;
        setConfirmState(null);
    }, []);

    const handleConfirmCancel = useCallback(() => {
        confirmResolveRef.current?.(false);
        confirmResolveRef.current = null;
        setConfirmState(null);
    }, []);

    const handlePromptSubmit = useCallback((value: string) => {
        promptResolveRef.current?.(value);
        promptResolveRef.current = null;
        setPromptState(null);
    }, []);

    const handlePromptCancel = useCallback(() => {
        promptResolveRef.current?.(null);
        promptResolveRef.current = null;
        setPromptState(null);
    }, []);

    /** Render this component once near the root of your component tree. */
    const DialogRenderer: React.FC = useCallback(() => (
        <>
            <ConfirmModal
                isOpen={!!confirmState}
                title={confirmState?.title || ''}
                message={confirmState?.message || ''}
                variant={confirmState?.variant || 'danger'}
                confirmLabel={confirmState?.confirmLabel}
                cancelLabel={confirmState?.confirmLabel === 'OK' ? undefined : undefined}
                onConfirm={handleConfirm}
                onCancel={confirmState?.confirmLabel === 'OK' ? handleConfirm : handleConfirmCancel}
            />
            <PromptModal
                isOpen={!!promptState}
                title={promptState?.title || ''}
                message={promptState?.message || ''}
                placeholder={promptState?.placeholder}
                defaultValue={promptState?.defaultValue}
                submitLabel={promptState?.submitLabel}
                onSubmit={handlePromptSubmit}
                onCancel={handlePromptCancel}
            />
        </>
    ), [confirmState, promptState, handleConfirm, handleConfirmCancel, handlePromptSubmit, handlePromptCancel]);

    return { confirm, alert, prompt, DialogRenderer };
}

import { useState, useCallback, useRef } from 'react';

interface FormField<T> {
    value: T;
    error: string | null;
    touched: boolean;
    dirty: boolean;
}

type FormFields<T extends Record<string, any>> = {
    [K in keyof T]: FormField<T[K]>;
};

interface UseFormOptions<T extends Record<string, any>> {
    initialValues: T;
    validate?: (values: T) => Partial<Record<keyof T, string>>;
    onSubmit: (values: T) => Promise<void> | void;
}

/**
 * #13: Reusable form state management hook.
 * Provides validation, dirty tracking, error display, and submit handling.
 *
 * Usage:
 *   const form = useForm({
 *     initialValues: { email: '', password: '' },
 *     validate: (v) => ({ email: !v.email ? 'Required' : null }),
 *     onSubmit: async (v) => { await login(v); }
 *   });
 *
 *   <input value={form.values.email} onChange={form.handleChange('email')} />
 *   {form.errors.email && <span>{form.errors.email}</span>}
 */
export function useForm<T extends Record<string, any>>({ initialValues, validate, onSubmit }: UseFormOptions<T>) {
    const [values, setValues] = useState<T>(initialValues);
    const [errors, setErrors] = useState<Partial<Record<keyof T, string>>>({});
    const [touched, setTouched] = useState<Partial<Record<keyof T, boolean>>>({});
    const [submitting, setSubmitting] = useState(false);
    const [submitError, setSubmitError] = useState<string | null>(null);
    const initialRef = useRef(initialValues);

    const isDirty = JSON.stringify(values) !== JSON.stringify(initialRef.current);

    const handleChange = useCallback((field: keyof T) => {
        return (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>) => {
            const newValue = e.target.type === 'checkbox' ? (e.target as HTMLInputElement).checked : e.target.value;
            setValues(prev => ({ ...prev, [field]: newValue }));
            setTouched(prev => ({ ...prev, [field]: true }));
            // Clear field error on change
            setErrors(prev => ({ ...prev, [field]: undefined }));
        };
    }, []);

    const setValue = useCallback((field: keyof T, value: T[keyof T]) => {
        setValues(prev => ({ ...prev, [field]: value }));
        setTouched(prev => ({ ...prev, [field]: true }));
    }, []);

    const handleSubmit = useCallback(async (e?: React.FormEvent) => {
        if (e) e.preventDefault();
        setSubmitError(null);

        // Run validation
        if (validate) {
            const validationErrors = validate(values);
            const hasErrors = Object.values(validationErrors).some(Boolean);
            if (hasErrors) {
                setErrors(validationErrors);
                // Mark all fields as touched
                const allTouched: any = {};
                for (const key of Object.keys(values)) allTouched[key] = true;
                setTouched(allTouched);
                return;
            }
        }

        setSubmitting(true);
        try {
            await onSubmit(values);
        } catch (err: any) {
            setSubmitError(err.message || 'Submission failed');
        } finally {
            setSubmitting(false);
        }
    }, [values, validate, onSubmit]);

    const reset = useCallback(() => {
        setValues(initialRef.current);
        setErrors({});
        setTouched({});
        setSubmitError(null);
    }, []);

    return {
        values,
        errors,
        touched,
        submitting,
        submitError,
        isDirty,
        handleChange,
        setValue,
        handleSubmit,
        reset,
        setValues,
    };
}

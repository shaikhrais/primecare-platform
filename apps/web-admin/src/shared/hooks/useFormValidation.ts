/**
 * useFormValidation — Zod-powered form validation hook
 *
 * Provides real-time validation, field-level errors, dirty tracking,
 * and submit handling with typed schemas.
 *
 * Usage:
 *   const form = useFormValidation(CreateVisitSchema, {
 *       clientId: '', serviceId: '', scheduledStart: '', scheduledEnd: '',
 *   });
 *
 *   <input value={form.values.clientId} onChange={e => form.setValue('clientId', e.target.value)} />
 *   {form.errors.clientId && <span>{form.errors.clientId}</span>}
 *   <button onClick={() => form.handleSubmit(onSubmit)} disabled={!form.isValid}>Save</button>
 */
import { useState, useCallback, useMemo, useRef } from 'react';
import { z, type ZodSchema, type ZodError } from 'zod';

interface FormState<T> {
    values: T;
    errors: Partial<Record<keyof T, string>>;
    touched: Partial<Record<keyof T, boolean>>;
    isDirty: boolean;
    isValid: boolean;
    isSubmitting: boolean;
}

interface FormActions<T> {
    setValue: <K extends keyof T>(field: K, value: T[K]) => void;
    setValues: (values: Partial<T>) => void;
    setError: (field: keyof T, error: string) => void;
    clearErrors: () => void;
    touch: (field: keyof T) => void;
    reset: (values?: T) => void;
    validate: () => boolean;
    handleSubmit: (onSubmit: (values: T) => Promise<void> | void) => Promise<void>;
}

export function useFormValidation<T extends Record<string, unknown>>(
    schema: ZodSchema<T>,
    initialValues: T
): FormState<T> & FormActions<T> {
    const [values, setValuesState] = useState<T>(initialValues);
    const [errors, setErrors] = useState<Partial<Record<keyof T, string>>>({});
    const [touched, setTouched] = useState<Partial<Record<keyof T, boolean>>>({});
    const [isSubmitting, setIsSubmitting] = useState(false);
    const initialRef = useRef(initialValues);

    const isDirty = useMemo(() => {
        return Object.keys(values).some(
            key => values[key as keyof T] !== initialRef.current[key as keyof T]
        );
    }, [values]);

    const validateField = useCallback((field: keyof T, value: unknown): string | null => {
        try {
            const partial = { ...values, [field]: value };
            schema.parse(partial);
            return null;
        } catch (err) {
            const zodErr = err as ZodError;
            const fieldError = zodErr.errors.find(e => e.path[0] === field);
            return fieldError?.message || null;
        }
    }, [schema, values]);

    const validateAll = useCallback((): boolean => {
        try {
            schema.parse(values);
            setErrors({});
            return true;
        } catch (err) {
            const zodErr = err as ZodError;
            const newErrors: Partial<Record<keyof T, string>> = {};
            zodErr.errors.forEach(e => {
                const field = e.path[0] as keyof T;
                if (!newErrors[field]) newErrors[field] = e.message;
            });
            setErrors(newErrors);
            return false;
        }
    }, [schema, values]);

    const isValid = useMemo(() => {
        try {
            schema.parse(values);
            return true;
        } catch {
            return false;
        }
    }, [schema, values]);

    const setValue = useCallback(<K extends keyof T>(field: K, value: T[K]) => {
        setValuesState(prev => ({ ...prev, [field]: value }));
        // Validate on change if field was touched
        if (touched[field]) {
            const error = validateField(field, value);
            setErrors(prev => {
                const next = { ...prev };
                if (error) next[field] = error;
                else delete next[field];
                return next;
            });
        }
    }, [touched, validateField]);

    const setValuesMulti = useCallback((partial: Partial<T>) => {
        setValuesState(prev => ({ ...prev, ...partial }));
    }, []);

    const setError = useCallback((field: keyof T, error: string) => {
        setErrors(prev => ({ ...prev, [field]: error }));
    }, []);

    const clearErrors = useCallback(() => setErrors({}), []);

    const touchField = useCallback((field: keyof T) => {
        setTouched(prev => ({ ...prev, [field]: true }));
        // Validate on blur
        const error = validateField(field, values[field]);
        if (error) setErrors(prev => ({ ...prev, [field]: error }));
        else setErrors(prev => { const n = { ...prev }; delete n[field]; return n; });
    }, [validateField, values]);

    const reset = useCallback((newValues?: T) => {
        const v = newValues || initialRef.current;
        setValuesState(v);
        setErrors({});
        setTouched({});
        if (newValues) initialRef.current = newValues;
    }, []);

    const handleSubmit = useCallback(async (onSubmit: (values: T) => Promise<void> | void) => {
        // Touch all fields
        const allTouched: Partial<Record<keyof T, boolean>> = {};
        Object.keys(values).forEach(k => { allTouched[k as keyof T] = true; });
        setTouched(allTouched);

        if (!validateAll()) return;

        setIsSubmitting(true);
        try {
            await onSubmit(values);
        } catch (err) {
            // Allow submit handler to handle errors
            throw err;
        } finally {
            setIsSubmitting(false);
        }
    }, [values, validateAll]);

    return {
        values, errors, touched, isDirty, isValid, isSubmitting,
        setValue, setValues: setValuesMulti, setError, clearErrors,
        touch: touchField, reset, validate: validateAll, handleSubmit,
    };
}

export default useFormValidation;

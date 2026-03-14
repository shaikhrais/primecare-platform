// PcButton: style maps and helper functions extracted
import React from 'react';
import { ButtonRegistry, type ButtonDef } from 'prime-care-shared';

export type ButtonVariant = 'primary' | 'secondary' | 'ghost' | 'danger';
export type ButtonSize = 'xs' | 'sm' | 'md' | 'lg';

export const VARIANT_STYLES: Record<ButtonVariant, React.CSSProperties> = {
    primary: { backgroundColor: 'var(--brand-500, #004d40)', color: 'white', border: 'none' },
    secondary: { backgroundColor: 'var(--bg-100, #f3f4f6)', color: 'var(--text-100, #374151)', border: '1px solid var(--border, #e5e7eb)' },
    ghost: { backgroundColor: 'transparent', color: 'var(--brand-500, #004d40)', border: 'none' },
    danger: { backgroundColor: '#ef4444', color: 'white', border: 'none' },
};

export const SIZE_STYLES: Record<ButtonSize, React.CSSProperties> = {
    xs: { padding: '4px 8px', fontSize: '0.7rem', borderRadius: '6px' },
    sm: { padding: '6px 12px', fontSize: '0.8rem', borderRadius: '8px' },
    md: { padding: '10px 18px', fontSize: '0.875rem', borderRadius: '10px' },
    lg: { padding: '14px 24px', fontSize: '1rem', borderRadius: '12px' },
};

export const BASE_STYLE: React.CSSProperties = {
    fontWeight: 600, cursor: 'pointer', display: 'inline-flex', alignItems: 'center',
    justifyContent: 'center', gap: '8px', transition: 'all 0.15s ease',
    whiteSpace: 'nowrap', textDecoration: 'none', lineHeight: 1.4,
};

export function resolveButtonDef(registryId?: string): ButtonDef | undefined {
    if (!registryId) return undefined;
    return ButtonRegistry.find((b: ButtonDef) => b.id === registryId);
}

export function replaceParams(path: string, params?: Record<string, string>): string {
    if (!params) return path;
    let result = path;
    for (const [key, value] of Object.entries(params)) { result = result.replace(`:${key}`, encodeURIComponent(value)); }
    return result;
}

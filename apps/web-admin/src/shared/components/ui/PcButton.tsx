import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { ButtonRegistry, type ButtonDef } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';

/* ═══════════════════════════════════════════════════════════════════════════════
 * PcButton — Centralized, registry-driven button component.
 *
 * Usage modes:
 *
 * 1) REGISTRY MODE — pass registryId, everything auto-resolves:
 *    <PcButton registryId="btn-admin-user-invite" onClick={openModal} />
 *
 * 2) REGISTRY + ROUTE — auto-navigates for UI_NAVIGATION buttons:
 *    <PcButton registryId="btn-client-request-care" to="/client/booking" />
 *
 * 3) REGISTRY + API — auto-triggers API for API_TRIGGER buttons:
 *    <PcButton registryId="btn-admin-search-reindex" />
 *    (apiPath comes from ButtonRegistry, POST is automatic)
 *
 * 4) MANUAL MODE — for one-off buttons not in the registry:
 *    <PcButton variant="danger" size="sm" label="Delete" onClick={handler} />
 *
 * 5) REGISTRY + PARAMS — route with dynamic params:
 *    <PcButton registryId="btn-adm-leads-convert" params={{ id: leadId }} />
 * ═══════════════════════════════════════════════════════════════════════════ */

type ButtonVariant = 'primary' | 'secondary' | 'ghost' | 'danger';
type ButtonSize = 'xs' | 'sm' | 'md' | 'lg';

export interface PcButtonProps {
    /** Registry ID from ButtonRegistry (e.g. 'btn-admin-user-invite') */
    registryId?: string;
    /** Override label from registry */
    label?: string;
    /** Override variant from registry */
    variant?: ButtonVariant;
    /** Button size */
    size?: ButtonSize;
    /** Route to navigate to (overrides registry apiPath for UI_NAVIGATION) */
    to?: string;
    /** Dynamic route params — replaces :param in `to` or registry apiPath */
    params?: Record<string, string>;
    /** API body for API_TRIGGER actions */
    apiBody?: Record<string, any>;
    /** Success message after API call */
    successMessage?: string;
    /** Error message after API failure */
    errorMessage?: string;
    /** Click handler (overrides auto-behavior) */
    onClick?: (e: React.MouseEvent) => void | Promise<void>;
    /** Loading state */
    loading?: boolean;
    /** Disabled state */
    disabled?: boolean;
    /** Custom data-cy (defaults to registryId) */
    'data-cy'?: string;
    /** Icon element to render before label */
    icon?: React.ReactNode;
    /** Render as block (full-width) */
    block?: boolean;
    /** Additional className */
    className?: string;
    /** Additional inline styles */
    style?: React.CSSProperties;
    /** Children (overrides label) */
    children?: React.ReactNode;
    /** Type attribute for form submission */
    type?: 'button' | 'submit' | 'reset';
}

// ── Style Maps ──────────────────────────────────────────────────────────────

const VARIANT_STYLES: Record<ButtonVariant, React.CSSProperties> = {
    primary: {
        backgroundColor: 'var(--brand-500, #004d40)',
        color: 'white',
        border: 'none',
    },
    secondary: {
        backgroundColor: 'var(--bg-100, #f3f4f6)',
        color: 'var(--text-100, #374151)',
        border: '1px solid var(--border, #e5e7eb)',
    },
    ghost: {
        backgroundColor: 'transparent',
        color: 'var(--brand-500, #004d40)',
        border: 'none',
    },
    danger: {
        backgroundColor: '#ef4444',
        color: 'white',
        border: 'none',
    },
};

const SIZE_STYLES: Record<ButtonSize, React.CSSProperties> = {
    xs: { padding: '4px 8px', fontSize: '0.7rem', borderRadius: '6px' },
    sm: { padding: '6px 12px', fontSize: '0.8rem', borderRadius: '8px' },
    md: { padding: '10px 18px', fontSize: '0.875rem', borderRadius: '10px' },
    lg: { padding: '14px 24px', fontSize: '1rem', borderRadius: '12px' },
};

const BASE_STYLE: React.CSSProperties = {
    fontWeight: 600,
    cursor: 'pointer',
    display: 'inline-flex',
    alignItems: 'center',
    justifyContent: 'center',
    gap: '8px',
    transition: 'all 0.15s ease',
    whiteSpace: 'nowrap',
    textDecoration: 'none',
    lineHeight: 1.4,
};

// ── Helper: resolve registry entry ──────────────────────────────────────────

function resolveButtonDef(registryId?: string): ButtonDef | undefined {
    if (!registryId) return undefined;
    return ButtonRegistry.find((b: ButtonDef) => b.id === registryId);
}

function replaceParams(path: string, params?: Record<string, string>): string {
    if (!params) return path;
    let result = path;
    for (const [key, value] of Object.entries(params)) {
        result = result.replace(`:${key}`, encodeURIComponent(value));
    }
    return result;
}

// ── Component ───────────────────────────────────────────────────────────────

export const PcButton: React.FC<PcButtonProps> = (props) => {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [isLoading, setIsLoading] = useState(false);

    // Resolve from registry
    const def = resolveButtonDef(props.registryId);

    const variant: ButtonVariant = props.variant || def?.type || 'primary';
    const size: ButtonSize = props.size || 'md';
    const label = props.children || props.label || def?.label || 'Action';
    const dataCy = props['data-cy'] || props.registryId || undefined;
    const isDisabled = props.disabled || isLoading || props.loading;

    // ── Click behavior ──────────────────────────────────────────────────────
    const handleClick = async (e: React.MouseEvent) => {
        if (isDisabled) return;

        // If custom onClick is provided, use it
        if (props.onClick) {
            await props.onClick(e);
            return;
        }

        // Auto-behavior based on registry action type
        if (def) {
            switch (def.action) {
                case 'UI_NAVIGATION': {
                    const path = props.to || def.apiPath;
                    if (path) navigate(replaceParams(path, props.params));
                    return;
                }
                case 'API_TRIGGER':
                case 'API_SIGNATURE':
                case 'GEOLOCATION_STAMP':
                case 'API_DISPATCH': {
                    const apiPath = def.apiPath;
                    if (!apiPath) return;
                    setIsLoading(true);
                    try {
                        const res = await apiClient.post(
                            replaceParams(apiPath, props.params),
                            props.apiBody || {}
                        );
                        if (res.ok) {
                            showToast(props.successMessage || `${def.label} — success`, 'success');
                        } else {
                            const err = await res.json().catch(() => ({}));
                            showToast(props.errorMessage || (err as any).error || `${def.label} failed`, 'error');
                        }
                    } catch {
                        showToast(props.errorMessage || `${def.label} failed — network error`, 'error');
                    } finally {
                        setIsLoading(false);
                    }
                    return;
                }
                case 'OPEN_MODAL':
                case 'CI_TRIGGER':
                default:
                    // These require a custom onClick — no auto-behavior
                    break;
            }
        }

        // If `to` is provided without registry, navigate
        if (props.to) {
            navigate(replaceParams(props.to, props.params));
        }
    };

    // ── Compose styles ──────────────────────────────────────────────────────
    const composedStyle: React.CSSProperties = {
        ...BASE_STYLE,
        ...VARIANT_STYLES[variant],
        ...SIZE_STYLES[size],
        ...(props.block ? { width: '100%' } : {}),
        ...(isDisabled ? { opacity: 0.5, cursor: 'not-allowed' } : {}),
        ...props.style,
    };

    return (
        <button
            type={props.type || 'button'}
            className={props.className}
            style={composedStyle}
            onClick={handleClick}
            disabled={isDisabled}
            data-cy={dataCy}
            title={def?.description}
        >
            {props.icon}
            {(isLoading || props.loading) ? (
                <span style={{ display: 'inline-flex', alignItems: 'center', gap: '6px' }}>
                    <span style={{ 
                        width: '14px', height: '14px', 
                        border: '2px solid currentColor', borderTopColor: 'transparent',
                        borderRadius: '50%', 
                        animation: 'pcBtnSpin 0.6s linear infinite',
                        display: 'inline-block'
                    }} />
                    Processing...
                </span>
            ) : label}
            <style>{`@keyframes pcBtnSpin { to { transform: rotate(360deg); } }`}</style>
        </button>
    );
};

// ── PcIconButton — for icon-only compact actions ────────────────────────────

export interface PcIconButtonProps {
    icon: React.ReactNode;
    onClick?: (e: React.MouseEvent) => void;
    variant?: ButtonVariant;
    size?: ButtonSize;
    disabled?: boolean;
    'data-cy'?: string;
    title?: string;
    style?: React.CSSProperties;
}

export const PcIconButton: React.FC<PcIconButtonProps> = ({
    icon, onClick, variant = 'ghost', size = 'sm', disabled, title, style, ...rest
}) => {
    const sizeMap: Record<ButtonSize, string> = { xs: '28px', sm: '32px', md: '36px', lg: '44px' };
    const dim = sizeMap[size];

    return (
        <button
            type="button"
            onClick={onClick}
            disabled={disabled}
            title={title}
            data-cy={rest['data-cy']}
            style={{
                width: dim, height: dim,
                display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
                borderRadius: '8px', border: 'none', cursor: disabled ? 'not-allowed' : 'pointer',
                transition: 'all 0.15s ease',
                ...VARIANT_STYLES[variant],
                padding: 0,
                ...(disabled ? { opacity: 0.5 } : {}),
                ...style,
            }}
        >
            {icon}
        </button>
    );
};

// ── PcLinkButton — renders as a styled <Link> for SEO-friendly navigation ──

export { PcButton as default };

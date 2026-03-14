import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { type ButtonDef } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';
import { type ButtonVariant, type ButtonSize, VARIANT_STYLES, SIZE_STYLES, BASE_STYLE, resolveButtonDef, replaceParams } from './pcButtonStyles';

export interface PcButtonProps {
    registryId?: string; label?: string; variant?: ButtonVariant; size?: ButtonSize;
    to?: string; params?: Record<string, string>; apiBody?: Record<string, any>;
    successMessage?: string; errorMessage?: string;
    onClick?: (e: React.MouseEvent) => void | Promise<void>;
    loading?: boolean; disabled?: boolean; 'data-cy'?: string;
    icon?: React.ReactNode; block?: boolean; className?: string;
    style?: React.CSSProperties; children?: React.ReactNode;
    type?: 'button' | 'submit' | 'reset';
}

export const PcButton: React.FC<PcButtonProps> = (props) => {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [isLoading, setIsLoading] = useState(false);
    const def = resolveButtonDef(props.registryId);
    const VARIANT_MAP: Record<string, ButtonVariant> = { link: 'ghost', interaction: 'secondary', touchpoint: 'ghost' };
    const variant: ButtonVariant = props.variant || (def?.type ? (VARIANT_MAP[def.type] || def.type as ButtonVariant) : 'primary');
    const size: ButtonSize = props.size || 'md';
    const label = props.children || props.label || def?.label || 'Action';
    const dataCy = props['data-cy'] || props.registryId || undefined;
    const isDisabled = props.disabled || isLoading || props.loading;

    const handleClick = async (e: React.MouseEvent) => {
        if (isDisabled) return;
        if (props.onClick) { await props.onClick(e); return; }
        if (def) {
            switch (def.action) {
                case 'UI_NAVIGATION': { const p = props.to || def.apiPath; if (p) navigate(replaceParams(p, props.params)); return; }
                case 'API_TRIGGER': case 'API_SIGNATURE': case 'GEOLOCATION_STAMP': case 'API_DISPATCH': {
                    if (!def.apiPath) return; setIsLoading(true);
                    try { const res = await apiClient.post(replaceParams(def.apiPath, props.params), props.apiBody || {}); if (res.ok) showToast(props.successMessage || `${def.label} — success`, 'success'); else { const err = await res.json().catch(() => ({})); showToast(props.errorMessage || (err as any).error || `${def.label} failed`, 'error'); } }
                    catch { showToast(props.errorMessage || `${def.label} failed — network error`, 'error'); }
                    finally { setIsLoading(false); } return;
                }
                default: break;
            }
        }
        if (props.to) navigate(replaceParams(props.to, props.params));
    };

    const composedStyle: React.CSSProperties = { ...BASE_STYLE, ...VARIANT_STYLES[variant], ...SIZE_STYLES[size], ...(props.block ? { width: '100%' } : {}), ...(isDisabled ? { opacity: 0.5, cursor: 'not-allowed' } : {}), ...props.style };

    return (
        <button type={props.type || 'button'} className={props.className} style={composedStyle} onClick={handleClick} disabled={isDisabled} data-cy={dataCy} title={def?.description}>
            {props.icon}
            {(isLoading || props.loading) ? (<span style={{ display: 'inline-flex', alignItems: 'center', gap: '6px' }}><span style={{ width: '14px', height: '14px', border: '2px solid currentColor', borderTopColor: 'transparent', borderRadius: '50%', animation: 'pcBtnSpin 0.6s linear infinite', display: 'inline-block' }} />Processing...</span>) : label}
            <style>{`@keyframes pcBtnSpin { to { transform: rotate(360deg); } }`}</style>
        </button>
    );
};

export interface PcIconButtonProps { icon: React.ReactNode; onClick?: (e: React.MouseEvent) => void; variant?: ButtonVariant; size?: ButtonSize; disabled?: boolean; 'data-cy'?: string; title?: string; style?: React.CSSProperties; }

export const PcIconButton: React.FC<PcIconButtonProps> = ({ icon, onClick, variant = 'ghost', size = 'sm', disabled, title, style, ...rest }) => {
    const dim = ({ xs: '28px', sm: '32px', md: '36px', lg: '44px' })[size];
    return (<button type="button" onClick={onClick} disabled={disabled} title={title} data-cy={rest['data-cy']} style={{ width: dim, height: dim, display: 'inline-flex', alignItems: 'center', justifyContent: 'center', borderRadius: '8px', border: 'none', cursor: disabled ? 'not-allowed' : 'pointer', transition: 'all 0.15s ease', ...VARIANT_STYLES[variant], padding: 0, ...(disabled ? { opacity: 0.5 } : {}), ...style }}>{icon}</button>);
};

export { PcButton as default };

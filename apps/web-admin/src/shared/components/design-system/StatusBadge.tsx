/**
 * StatusBadge — Consistent status indicators across all portals
 *
 * Usage:
 *   <StatusBadge status="active" />
 *   <StatusBadge status="pending" size="sm" />
 *   <StatusBadge status="critical" pulse />
 */
import React from 'react';

type BadgeStatus =
    | 'active' | 'inactive' | 'pending' | 'completed' | 'cancelled'
    | 'draft' | 'approved' | 'rejected' | 'expired'
    | 'success' | 'warning' | 'error' | 'critical' | 'info'
    | 'open' | 'closed' | 'resolved' | 'in_progress' | 'scheduled'
    | 'paid' | 'overdue' | 'refunded' | 'denied'
    | 'online' | 'offline' | 'away' | 'busy';

type BadgeSize = 'xs' | 'sm' | 'md';

interface StatusBadgeProps {
    status: BadgeStatus | string;
    size?: BadgeSize;
    pulse?: boolean;
    className?: string;
    label?: string; // Override display label
}

const STATUS_COLORS: Record<string, { bg: string; text: string; dot: string }> = {
    // Positive
    active: { bg: '#ECFDF5', text: '#065F46', dot: '#10B981' },
    completed: { bg: '#ECFDF5', text: '#065F46', dot: '#10B981' },
    success: { bg: '#ECFDF5', text: '#065F46', dot: '#10B981' },
    approved: { bg: '#ECFDF5', text: '#065F46', dot: '#10B981' },
    paid: { bg: '#ECFDF5', text: '#065F46', dot: '#10B981' },
    resolved: { bg: '#ECFDF5', text: '#065F46', dot: '#10B981' },
    online: { bg: '#ECFDF5', text: '#065F46', dot: '#10B981' },
    // Warning
    pending: { bg: '#FFFBEB', text: '#92400E', dot: '#F59E0B' },
    warning: { bg: '#FFFBEB', text: '#92400E', dot: '#F59E0B' },
    in_progress: { bg: '#FFFBEB', text: '#92400E', dot: '#F59E0B' },
    scheduled: { bg: '#EFF6FF', text: '#1E40AF', dot: '#3B82F6' },
    draft: { bg: '#F3F4F6', text: '#374151', dot: '#9CA3AF' },
    overdue: { bg: '#FEF3C7', text: '#B45309', dot: '#D97706' },
    away: { bg: '#FFFBEB', text: '#92400E', dot: '#F59E0B' },
    busy: { bg: '#FEF3C7', text: '#B45309', dot: '#D97706' },
    // Negative
    inactive: { bg: '#F3F4F6', text: '#6B7280', dot: '#9CA3AF' },
    cancelled: { bg: '#FEF2F2', text: '#991B1B', dot: '#EF4444' },
    rejected: { bg: '#FEF2F2', text: '#991B1B', dot: '#EF4444' },
    error: { bg: '#FEF2F2', text: '#991B1B', dot: '#EF4444' },
    critical: { bg: '#FEF2F2', text: '#991B1B', dot: '#DC2626' },
    expired: { bg: '#F3F4F6', text: '#6B7280', dot: '#9CA3AF' },
    denied: { bg: '#FEF2F2', text: '#991B1B', dot: '#EF4444' },
    closed: { bg: '#F3F4F6', text: '#6B7280', dot: '#9CA3AF' },
    offline: { bg: '#F3F4F6', text: '#6B7280', dot: '#9CA3AF' },
    refunded: { bg: '#EFF6FF', text: '#1E40AF', dot: '#3B82F6' },
    // Info
    info: { bg: '#EFF6FF', text: '#1E40AF', dot: '#3B82F6' },
    open: { bg: '#EFF6FF', text: '#1E40AF', dot: '#3B82F6' },
};

const SIZE_STYLES: Record<BadgeSize, { fontSize: string; padding: string; dotSize: string }> = {
    xs: { fontSize: '0.625rem', padding: '0.125rem 0.375rem', dotSize: '0.375rem' },
    sm: { fontSize: '0.75rem', padding: '0.125rem 0.5rem', dotSize: '0.4375rem' },
    md: { fontSize: '0.8125rem', padding: '0.25rem 0.625rem', dotSize: '0.5rem' },
};

function formatLabel(status: string): string {
    return status
        .replace(/_/g, ' ')
        .replace(/\b\w/g, c => c.toUpperCase());
}

export const StatusBadge: React.FC<StatusBadgeProps> = ({ status, size = 'sm', pulse = false, className, label }) => {
    const normalizedStatus = status.toLowerCase().replace(/[- ]/g, '_');
    const colors = STATUS_COLORS[normalizedStatus] || { bg: '#F3F4F6', text: '#374151', dot: '#9CA3AF' };
    const sizeStyle = SIZE_STYLES[size];
    const displayLabel = label || formatLabel(status);

    return (
        <span
            className={className}
            data-cy={`status-badge-${normalizedStatus}`}
            style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: '0.375rem',
                padding: sizeStyle.padding,
                borderRadius: '9999px',
                backgroundColor: colors.bg,
                color: colors.text,
                fontSize: sizeStyle.fontSize,
                fontWeight: 600,
                lineHeight: 1,
                whiteSpace: 'nowrap',
            }}
        >
            <span
                style={{
                    width: sizeStyle.dotSize,
                    height: sizeStyle.dotSize,
                    borderRadius: '50%',
                    backgroundColor: colors.dot,
                    flexShrink: 0,
                    ...(pulse ? { animation: 'primecare-pulse 2s infinite' } : {}),
                }}
            />
            {displayLabel}
            {pulse && (
                <style>{`@keyframes primecare-pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.4; } }`}</style>
            )}
        </span>
    );
};

export default StatusBadge;

import React from 'react';

interface AsyncViewProps<T> {
    data: T | null | undefined;
    loading: boolean;
    error?: string | null;
    children: (data: T) => React.ReactNode;
    loadingFallback?: React.ReactNode;
    errorFallback?: React.ReactNode;
    emptyFallback?: React.ReactNode;
}

/** Inline shimmer skeleton bar */
const ShimmerBar: React.FC<{ width?: string; height?: string }> = ({ width = '100%', height = '16px' }) => (
    <div style={{
        width, height,
        borderRadius: '6px',
        background: 'linear-gradient(90deg, var(--pc-bg-tertiary, #F3F4F6) 25%, var(--pc-bg-secondary, #E5E7EB) 50%, var(--pc-bg-tertiary, #F3F4F6) 75%)',
        backgroundSize: '200% 100%',
        animation: 'pcShimmer 1.5s ease-in-out infinite',
    }} />
);

/**
 * #12: Standardized loading/error/empty state pattern.
 * Wraps async data rendering with consistent UX.
 *
 * Usage:
 *   <AsyncView data={users} loading={loading} error={error}>
 *     {(data) => <UserList users={data} />}
 *   </AsyncView>
 */
export function AsyncView<T>({
    data,
    loading,
    error,
    children,
    loadingFallback,
    errorFallback,
    emptyFallback,
}: AsyncViewProps<T>) {
    if (loading) {
        return (loadingFallback as React.ReactElement) || (
            <div style={{ padding: '24px', display: 'flex', flexDirection: 'column', gap: '12px' }}>
                <ShimmerBar width="60%" height="20px" />
                <ShimmerBar width="100%" height="14px" />
                <ShimmerBar width="85%" height="14px" />
                <ShimmerBar width="70%" height="14px" />
                <style>{`@keyframes pcShimmer { 0% { background-position: 200% 0; } 100% { background-position: -200% 0; } }`}</style>
            </div>
        );
    }

    if (error) {
        return (errorFallback as React.ReactElement) || (
            <div style={{
                display: 'flex', justifyContent: 'center', padding: '48px',
                color: 'var(--pc-error, #ef4444)', background: 'var(--pc-error-bg, #fef2f2)', borderRadius: 12, margin: 16
            }}>
                <div style={{ textAlign: 'center' }}>
                    <div style={{ fontSize: 24, marginBottom: 8 }}>⚠️</div>
                    <div style={{ fontSize: 14, fontWeight: 600 }}>Something went wrong</div>
                    <div style={{ fontSize: 13, color: 'var(--pc-error, #b91c1c)', marginTop: 4 }}>{error}</div>
                </div>
            </div>
        );
    }

    if (data === null || data === undefined || (Array.isArray(data) && data.length === 0)) {
        return (emptyFallback as React.ReactElement) || (
            <div style={{ display: 'flex', justifyContent: 'center', padding: '48px', color: 'var(--pc-text-tertiary, #94a3b8)' }}>
                <div style={{ textAlign: 'center' }}>
                    <div style={{ fontSize: 24, marginBottom: 8 }}>📭</div>
                    <div style={{ fontSize: 14 }}>No data found</div>
                </div>
            </div>
        );
    }

    return <>{children(data)}</>;
}

export default AsyncView;


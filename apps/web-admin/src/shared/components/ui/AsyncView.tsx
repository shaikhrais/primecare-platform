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
            <div style={{ display: 'flex', justifyContent: 'center', padding: '48px', color: '#94a3b8' }}>
                <div style={{ textAlign: 'center' }}>
                    <div style={{ fontSize: 24, marginBottom: 8, animation: 'spin 1s linear infinite' }}>⏳</div>
                    <div style={{ fontSize: 14 }}>Loading...</div>
                </div>
            </div>
        );
    }

    if (error) {
        return (errorFallback as React.ReactElement) || (
            <div style={{
                display: 'flex', justifyContent: 'center', padding: '48px',
                color: '#ef4444', background: '#fef2f2', borderRadius: 12, margin: 16
            }}>
                <div style={{ textAlign: 'center' }}>
                    <div style={{ fontSize: 24, marginBottom: 8 }}>⚠️</div>
                    <div style={{ fontSize: 14, fontWeight: 600 }}>Something went wrong</div>
                    <div style={{ fontSize: 13, color: '#b91c1c', marginTop: 4 }}>{error}</div>
                </div>
            </div>
        );
    }

    if (data === null || data === undefined || (Array.isArray(data) && data.length === 0)) {
        return (emptyFallback as React.ReactElement) || (
            <div style={{ display: 'flex', justifyContent: 'center', padding: '48px', color: '#94a3b8' }}>
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

/**
 * LoadingSkeleton — Shimmer animation placeholder
 *
 * Usage:
 *   <LoadingSkeleton variant="card" />
 *   <LoadingSkeleton variant="table" rows={5} />
 *   <LoadingSkeleton variant="text" lines={3} />
 */
import React from 'react';

type SkeletonVariant = 'card' | 'table' | 'text' | 'dashboard' | 'form';

interface LoadingSkeletonProps {
    variant?: SkeletonVariant;
    rows?: number;
    lines?: number;
    className?: string;
}

const shimmerStyle: React.CSSProperties = {
    background: 'linear-gradient(90deg, var(--skeleton-base, #e5e7eb) 25%, var(--skeleton-shine, #f3f4f6) 50%, var(--skeleton-base, #e5e7eb) 75%)',
    backgroundSize: '200% 100%',
    animation: 'primecare-shimmer 1.5s infinite',
    borderRadius: '0.5rem',
};

const ShimmerBar: React.FC<{ width: string; height: string; style?: React.CSSProperties }> = ({ width, height, style }) => (
    <div style={{ ...shimmerStyle, width, height, ...style }} />
);

const CardSkeleton: React.FC = () => (
    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', gap: '1rem' }}>
        {[1, 2, 3, 4].map(i => (
            <div key={i} style={{ padding: '1.25rem', borderRadius: '0.75rem', border: '1px solid var(--border-color, #e5e7eb)' }}>
                <ShimmerBar width="60%" height="1rem" />
                <ShimmerBar width="40%" height="2.5rem" style={{ marginTop: '0.75rem' }} />
                <ShimmerBar width="80%" height="0.75rem" style={{ marginTop: '0.5rem' }} />
            </div>
        ))}
    </div>
);

const TableSkeleton: React.FC<{ rows: number }> = ({ rows }) => (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
        {/* Header */}
        <div style={{ display: 'flex', gap: '1rem', padding: '0.75rem 0', borderBottom: '2px solid var(--border-color, #e5e7eb)' }}>
            {[1, 2, 3, 4].map(i => <ShimmerBar key={i} width="25%" height="0.875rem" />)}
        </div>
        {/* Rows */}
        {Array.from({ length: rows }).map((_, i) => (
            <div key={i} style={{ display: 'flex', gap: '1rem', padding: '0.75rem 0', borderBottom: '1px solid var(--border-color, #f3f4f6)' }}>
                {[1, 2, 3, 4].map(j => <ShimmerBar key={j} width="25%" height="0.75rem" />)}
            </div>
        ))}
    </div>
);

const TextSkeleton: React.FC<{ lines: number }> = ({ lines }) => (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
        {Array.from({ length: lines }).map((_, i) => (
            <ShimmerBar key={i} width={`${90 - i * 10}%`} height="0.875rem" />
        ))}
    </div>
);

const DashboardSkeleton: React.FC = () => (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
        {/* Hero stats row */}
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(200px, 1fr))', gap: '1rem' }}>
            {[1, 2, 3, 4].map(i => (
                <div key={i} style={{ padding: '1.5rem', borderRadius: '0.75rem', border: '1px solid var(--border-color, #e5e7eb)' }}>
                    <ShimmerBar width="50%" height="0.75rem" />
                    <ShimmerBar width="30%" height="2rem" style={{ marginTop: '0.5rem' }} />
                </div>
            ))}
        </div>
        {/* Chart area */}
        <ShimmerBar width="100%" height="250px" style={{ borderRadius: '0.75rem' }} />
        {/* Table */}
        <TableSkeleton rows={4} />
    </div>
);

const FormSkeleton: React.FC = () => (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem', maxWidth: '600px' }}>
        {[1, 2, 3].map(i => (
            <div key={i} style={{ display: 'flex', flexDirection: 'column', gap: '0.375rem' }}>
                <ShimmerBar width="30%" height="0.75rem" />
                <ShimmerBar width="100%" height="2.5rem" />
            </div>
        ))}
        <ShimmerBar width="120px" height="2.5rem" style={{ marginTop: '0.5rem' }} />
    </div>
);

export const LoadingSkeleton: React.FC<LoadingSkeletonProps> = ({ variant = 'card', rows = 5, lines = 3, className }) => {
    return (
        <div className={className} data-cy="loading-skeleton">
            {variant === 'card' && <CardSkeleton />}
            {variant === 'table' && <TableSkeleton rows={rows} />}
            {variant === 'text' && <TextSkeleton lines={lines} />}
            {variant === 'dashboard' && <DashboardSkeleton />}
            {variant === 'form' && <FormSkeleton />}
            <style>{`@keyframes primecare-shimmer { 0% { background-position: 200% 0; } 100% { background-position: -200% 0; } }`}</style>
        </div>
    );
};

export default LoadingSkeleton;

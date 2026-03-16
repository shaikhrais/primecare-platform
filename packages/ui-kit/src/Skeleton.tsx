// ================================================================
// Skeleton Loading Components
// Reusable placeholder skeletons for page, dashboard, and table layouts
// ================================================================
import React from 'react';
import './Skeleton.css';

// --- Primitive Building Blocks ---

interface SkeletonBoxProps {
    width?: string;
    height?: string;
    borderRadius?: string;
    style?: React.CSSProperties;
    dark?: boolean;
}

/** Generic skeleton rectangle with shimmer animation */
export const SkeletonBox: React.FC<SkeletonBoxProps> = ({
    width = '100%',
    height = '16px',
    borderRadius = '6px',
    style,
    dark = false,
}) => (
    <div
        className={dark ? 'skeleton-dark' : 'skeleton'}
        style={{ width, height, borderRadius, ...style }}
    />
);

/** Circular skeleton avatar */
export const SkeletonCircle: React.FC<{ size?: number; dark?: boolean }> = ({ size = 40, dark = false }) => (
    <div
        className={dark ? 'skeleton-dark' : 'skeleton'}
        style={{ width: size, height: size, borderRadius: '50%', flexShrink: 0 }}
    />
);

// --- Composite Skeletons ---

/** Skeleton for stat cards (e.g. dashboard KPI tiles) */
export const StatCardSkeleton: React.FC = () => (
    <div style={{
        padding: '1.5rem',
        backgroundColor: '#FFFFFF',
        borderRadius: '0.75rem',
        boxShadow: '0 1px 3px 0 rgba(0,0,0,0.1)',
        borderLeft: '4px solid #E2E8F0',
    }}>
        <SkeletonBox width="60%" height="12px" />
        <SkeletonBox width="40%" height="28px" style={{ marginTop: '12px' }} />
    </div>
);

/** Skeleton for dashboard pages — header + stat cards + content panels */
export const DashboardSkeleton: React.FC<{ statCount?: number }> = ({ statCount = 3 }) => (
    <div style={{ padding: '2rem' }}>
        {/* Title */}
        <SkeletonBox width="280px" height="32px" style={{ marginBottom: '8px' }} />
        <SkeletonBox width="400px" height="16px" style={{ marginBottom: '2rem' }} />

        {/* Stat Cards */}
        <div style={{ display: 'grid', gridTemplateColumns: `repeat(auto-fit, minmax(240px, 1fr))`, gap: '1.5rem', marginBottom: '2rem' }}>
            {Array.from({ length: statCount }).map((_, i) => <StatCardSkeleton key={i} />)}
        </div>

        {/* Content Panels */}
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
            <SkeletonBox height="200px" borderRadius="12px" />
            <SkeletonBox height="200px" borderRadius="12px" />
        </div>
    </div>
);

/** Skeleton for table/list pages — table header + rows */
export const TableSkeleton: React.FC<{ rows?: number; columns?: number }> = ({ rows = 5, columns = 4 }) => (
    <div style={{ padding: '2rem' }}>
        {/* Title */}
        <SkeletonBox width="280px" height="32px" style={{ marginBottom: '2rem' }} />

        {/* Table */}
        <div style={{ backgroundColor: '#FFFFFF', borderRadius: '12px', border: '1px solid #E5E7EB', overflow: 'hidden' }}>
            {/* Header */}
            <div style={{ display: 'grid', gridTemplateColumns: `repeat(${columns}, 1fr)`, gap: '16px', padding: '16px', backgroundColor: '#F9FAFB', borderBottom: '2px solid #E5E7EB' }}>
                {Array.from({ length: columns }).map((_, i) => (
                    <SkeletonBox key={i} height="12px" width="80%" />
                ))}
            </div>

            {/* Rows */}
            {Array.from({ length: rows }).map((_, rowIdx) => (
                <div key={rowIdx} style={{ display: 'grid', gridTemplateColumns: `repeat(${columns}, 1fr)`, gap: '16px', padding: '16px', borderBottom: '1px solid #F3F4F6' }}>
                    {Array.from({ length: columns }).map((_, colIdx) => (
                        <SkeletonBox key={colIdx} height="16px" width={colIdx === 0 ? '90%' : '60%'} />
                    ))}
                </div>
            ))}
        </div>
    </div>
);

/** Skeleton for card grid pages — grid of card placeholders */
export const CardGridSkeleton: React.FC<{ cards?: number }> = ({ cards = 6 }) => (
    <div style={{ padding: '2rem' }}>
        {/* Title */}
        <SkeletonBox width="280px" height="32px" style={{ marginBottom: '1.5rem' }} />

        {/* Grid */}
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(350px, 1fr))', gap: '1.5rem' }}>
            {Array.from({ length: cards }).map((_, i) => (
                <div key={i} style={{ padding: '1.5rem', borderRadius: '12px', border: '1px solid #E5E7EB', backgroundColor: 'white' }}>
                    <div style={{ display: 'flex', gap: '12px', alignItems: 'center', marginBottom: '16px' }}>
                        <SkeletonCircle size={40} />
                        <div style={{ flex: 1 }}>
                            <SkeletonBox width="70%" height="14px" />
                            <SkeletonBox width="40%" height="12px" style={{ marginTop: '8px' }} />
                        </div>
                    </div>
                    <SkeletonBox height="60px" style={{ marginBottom: '16px' }} />
                    <div style={{ display: 'flex', gap: '12px' }}>
                        <SkeletonBox width="100px" height="36px" borderRadius="8px" />
                        <SkeletonBox width="100px" height="36px" borderRadius="8px" />
                    </div>
                </div>
            ))}
        </div>
    </div>
);

/** Skeleton for a radar/map area (dark theme) */
export const MapSkeleton: React.FC<{ height?: string }> = ({ height = '600px' }) => (
    <div style={{
        height,
        backgroundColor: '#0F172A',
        borderRadius: '16px',
        overflow: 'hidden',
        display: 'flex',
        flexDirection: 'column',
    }}>
        {/* Header bar */}
        <div style={{ padding: '16px 24px', backgroundColor: '#1E293B', display: 'flex', gap: '16px', alignItems: 'center', borderBottom: '1px solid #334155' }}>
            <SkeletonBox dark width="120px" height="20px" />
            <SkeletonBox dark width="80px" height="16px" />
            <SkeletonBox dark width="100px" height="16px" />
        </div>
        {/* Map area */}
        <div style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <div className="skeleton-pulse" style={{ color: '#475569', fontSize: '0.9rem', fontWeight: 600 }}>
                Loading map data...
            </div>
        </div>
    </div>
);

/** Inline skeleton row — for use within already-rendered containers */
export const InlineRowSkeleton: React.FC<{ count?: number }> = ({ count = 3 }) => (
    <>
        {Array.from({ length: count }).map((_, i) => (
            <div key={i} style={{ display: 'flex', alignItems: 'center', gap: '12px', padding: '16px', borderBottom: '1px solid #F3F4F6' }}>
                <SkeletonCircle size={32} />
                <div style={{ flex: 1 }}>
                    <SkeletonBox width="60%" height="14px" />
                    <SkeletonBox width="30%" height="10px" style={{ marginTop: '6px' }} />
                </div>
                <SkeletonBox width="80px" height="14px" />
            </div>
        ))}
    </>
);

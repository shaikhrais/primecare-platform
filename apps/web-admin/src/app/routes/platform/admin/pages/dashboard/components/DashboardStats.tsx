import React, { useState, useEffect, useRef } from 'react';
import { Link } from 'react-router';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

/**
 * Animated counter — smoothly counts from 0 to target value.
 * Uses requestAnimationFrame for 60fps smoothness.
 */
function useAnimatedCount(target: number, duration = 600): number {
    const [current, setCurrent] = useState(0);
    const prevTarget = useRef(0);
    const frameRef = useRef<number>(0);

    useEffect(() => {
        const start = prevTarget.current;
        const diff = target - start;
        if (diff === 0) return;

        const startTime = performance.now();

        const animate = (now: number) => {
            const elapsed = now - startTime;
            const progress = Math.min(elapsed / duration, 1);
            // Ease-out cubic for a snappy feel
            const eased = 1 - Math.pow(1 - progress, 3);
            setCurrent(Math.round(start + diff * eased));

            if (progress < 1) {
                frameRef.current = requestAnimationFrame(animate);
            } else {
                prevTarget.current = target;
            }
        };

        frameRef.current = requestAnimationFrame(animate);
        return () => cancelAnimationFrame(frameRef.current);
    }, [target, duration]);

    return current;
}

interface DashboardStatsProps {
    stats: {
        totalUsers: number;
        totalLeads: number;
        pendingVisits: number;
        totalVisits: number;
    };
}

const AnimatedStat: React.FC<{ value: number }> = ({ value }) => {
    const animated = useAnimatedCount(value);
    return <>{animated.toLocaleString()}</>;
};

export const DashboardStats: React.FC<DashboardStatsProps> = ({ stats }) => {
    const { t } = useTranslation();

    const cards = [
        { label: t(ContentRegistry.ADMIN_DASHBOARD.STATS.TOTAL_USERS), value: stats.totalUsers, icon: '👥', link: `${RouteRegistry.ADMIN.USERS}?role=psw`, color: 'var(--pc-info)' },
        { label: t(ContentRegistry.ADMIN_DASHBOARD.STATS.NEW_INQUIRIES), value: stats.totalLeads, icon: '📥', link: `${RouteRegistry.ADMIN.LEADS}?status=new`, color: 'var(--pc-warning)' },
        { label: t(ContentRegistry.ADMIN_DASHBOARD.STATS.PENDING_VISITS), value: stats.pendingVisits, icon: '📝', link: `${RouteRegistry.ADMIN.SCHEDULE}`, color: 'var(--pc-error)' },
        { label: t(ContentRegistry.ADMIN_DASHBOARD.STATS.TOTAL_VISITS), value: stats.totalVisits, icon: '📋', link: `${RouteRegistry.ADMIN.SCHEDULE}`, color: 'var(--pc-success)' },
    ];

    return (
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '1.5rem', marginBottom: '3rem' }} data-cy="stats-cards">
            {cards.map((card, index) => (
                <Link key={index} to={card.link} style={{ textDecoration: 'none' }}>
                    <div className="pc-card" data-cy={`stat-card-${card.label.toLowerCase().replace(/\s+/g, '-')}`} style={{
                        padding: '1.5rem',
                        display: 'flex',
                        flexDirection: 'column',
                        gap: '0.5rem',
                        cursor: 'pointer',
                        transition: 'transform 0.2s, box-shadow 0.2s',
                        borderLeft: `3px solid ${card.color}`,
                    }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                            <span style={{ color: 'var(--pc-text-secondary)', fontSize: '0.875rem', fontWeight: '600' }}>{card.label}</span>
                            <span style={{ fontSize: '1.25rem' }}>{card.icon}</span>
                        </div>
                        <div style={{ fontSize: '2rem', fontWeight: 800, color: 'var(--pc-primary)' }}>
                            <AnimatedStat value={card.value} />
                        </div>
                        <div style={{ fontSize: '0.75rem', color: 'var(--pc-text-secondary)', marginTop: '0.5rem' }}>
                            {t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.VIEW_DETAILS)}
                        </div>
                    </div>
                </Link>
            ))}
        </div>
    );
};

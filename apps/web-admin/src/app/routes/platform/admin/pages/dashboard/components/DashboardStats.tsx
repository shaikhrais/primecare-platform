import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

interface DashboardStatsProps {
    stats: {
        totalUsers: number;
        totalLeads: number;
        pendingVisits: number;
        totalVisits: number;
    };
}

export const DashboardStats: React.FC<DashboardStatsProps> = ({ stats }) => {
    const { t } = useTranslation();

    const cards = [
        { label: t(ContentRegistry.ADMIN_DASHBOARD.STATS.TOTAL_USERS), value: stats.totalUsers, icon: '👥', link: `${RouteRegistry.ADMIN.USERS}?role=psw` },
        { label: t(ContentRegistry.ADMIN_DASHBOARD.STATS.NEW_INQUIRIES), value: stats.totalLeads, icon: '📥', link: `${RouteRegistry.ADMIN.LEADS}?status=new` },
        { label: t(ContentRegistry.ADMIN_DASHBOARD.STATS.PENDING_VISITS), value: stats.pendingVisits, icon: '📝', link: `${RouteRegistry.ADMIN.SCHEDULE}` },
        { label: t(ContentRegistry.ADMIN_DASHBOARD.STATS.TOTAL_VISITS), value: stats.totalVisits, icon: '📋', link: `${RouteRegistry.ADMIN.SCHEDULE}` },
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
                    }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                            <span style={{ color: 'var(--text-300)', fontSize: '0.875rem', fontWeight: '600' }}>{card.label}</span>
                            <span style={{ fontSize: '1.25rem' }}>{card.icon}</span>
                        </div>
                        <div style={{ fontSize: '2rem', fontWeight: 800, color: 'var(--brand-500)' }}>
                            {card.value}
                        </div>
                        <div style={{ fontSize: '0.75rem', color: 'var(--text-300)', marginTop: '0.5rem' }}>
                            {t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.VIEW_DETAILS)}
                        </div>
                    </div>
                </Link>
            ))}
        </div>
    );
};

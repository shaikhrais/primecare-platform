import React from 'react';
import { NavLink } from 'react-router';
import { Home, Calendar, MessageSquare, User } from 'lucide-react';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

export const PswBottomNav: React.FC = () => {
    const { t } = useTranslation();
    const { RouteRegistry, ContentRegistry } = AdminRegistry;

    const navItems = [
        { route: '/tenancy', icon: <Home size={24} />, label: t('psw.nav_home', 'Home') },
        { route: RouteRegistry.PSW?.SCHEDULE || '/tenancy/psw/schedule', icon: <Calendar size={24} />, label: t('psw.nav_schedule', 'Schedule') },
        { route: '/tenancy/messages', icon: <MessageSquare size={24} />, label: t('psw.nav_messages', 'Msgs') },
        { route: '/tenancy/profile', icon: <User size={24} />, label: t('psw.nav_profile', 'Profile') }
    ];

    return (
        <nav
            style={{
                position: 'fixed',
                bottom: 0,
                left: 0,
                right: 0,
                backgroundColor: '#ffffff',
                borderTop: '1px solid #e5e7eb',
                display: 'flex',
                justifyContent: 'space-around',
                padding: '12px 0 calc(12px + env(safe-area-inset-bottom)) 0',
                zIndex: 9998,
                boxShadow: '0 -4px 6px -1px rgba(0, 0, 0, 0.05)'
            }}
            data-cy="psw-bottom-nav"
            className="mobile-only-flex"
        >
            {navItems.map((item, i) => (
                <NavLink
                    key={i}
                    to={item.route}
                    style={({ isActive }) => ({
                        display: 'flex',
                        flexDirection: 'column',
                        alignItems: 'center',
                        textDecoration: 'none',
                        color: isActive ? 'var(--brand-600, #0f172a)' : '#6b7280',
                        fontWeight: isActive ? 700 : 500,
                        gap: '4px'
                    })}
                >
                    {item.icon}
                    <span style={{ fontSize: '0.7rem' }}>{item.label}</span>
                </NavLink>
            ))}

            <style>{`
                @media (min-width: 1025px) {
                    .mobile-only-flex {
                        display: none !important;
                    }
                }
            `}</style>
        </nav>
    );
};

export default PswBottomNav;

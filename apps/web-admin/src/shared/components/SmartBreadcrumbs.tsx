import React from 'react';
import { useLocation, Link } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

export const SmartBreadcrumbs: React.FC = () => {
    const location = useLocation();
    const pathnames = location.pathname.split('/').filter((x) => x);

    // Identify the dashboard root based on the path
    const isPlatform = location.pathname.startsWith('/platform');
    const isTenancy = location.pathname.startsWith('/tenancy');
    const dashboardRoot = isPlatform ? RouteRegistry.ADMIN.DASHBOARD : (isTenancy ? '/tenancy' : '/');

    // Don't show on dashboard to avoid redundancy
    if (location.pathname === dashboardRoot || location.pathname === '/admin/dashboard' || location.pathname === '/admin') {
        return null;
    }

    return (
        <nav aria-label="breadcrumb" style={{ marginBottom: '1rem' }}>
            <ol style={{ display: 'flex', listStyle: 'none', padding: 0, margin: 0, fontSize: '0.875rem', color: '#6b7280' }}>
                <li style={{ display: 'flex', alignItems: 'center' }}>
                    <Link to={dashboardRoot} style={{ color: '#9ca3af', textDecoration: 'none', transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = '#4b5563'} onMouseLeave={(e) => e.currentTarget.style.color = '#9ca3af'}>
                        Dashboard
                    </Link>
                </li>
                {pathnames.map((value, index) => {
                    // Skip prefix segments that are part of the root layout
                    if (['platform', 'admin', 'tenancy'].includes(value)) return null;

                    const to = `/${pathnames.slice(0, index + 1).join('/')}`;
                    const isLast = index === pathnames.length - 1;
                    const label = value.charAt(0).toUpperCase() + value.slice(1).replace(/-/g, ' ');

                    return (
                        <li key={to} style={{ display: 'flex', alignItems: 'center' }}>
                            <span style={{ margin: '0 0.5rem', color: '#d1d5db' }}>/</span>
                            {isLast ? (
                                <span style={{ fontWeight: 600, color: '#111827' }} aria-current="page">
                                    {label}
                                </span>
                            ) : (
                                <Link to={to} style={{ color: '#6b7280', textDecoration: 'none', fontWeight: 500 }} onMouseEnter={(e) => e.currentTarget.style.color = '#111827'} onMouseLeave={(e) => e.currentTarget.style.color = '#6b7280'}>
                                    {label}
                                </Link>
                            )}
                        </li>
                    );
                })}
            </ol>
        </nav>
    );
};

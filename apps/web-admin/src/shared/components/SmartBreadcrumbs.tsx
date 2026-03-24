import React from 'react';
import { useLocation, Link } from 'react-router';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

export const SmartBreadcrumbs: React.FC = () => {
    const location = useLocation();
    const pathnames = location.pathname.split('/').filter((x) => x);

    // Identify the home root based on the path
    const isPlatform = location.pathname.startsWith('/platform');
    const isTenancy = location.pathname.startsWith('/tenancy');
    const homeRoot = isPlatform ? RouteRegistry.ADMIN.DASHBOARD : (isTenancy ? '/tenancy' : '/');

    // Don't show on home to avoid redundancy
    if (location.pathname === homeRoot || location.pathname === RouteRegistry.ADMIN.DASHBOARD) {
        return null;
    }

    return (
        <nav aria-label="breadcrumb" style={{ marginBottom: '1rem' }}>
            <ol style={{ display: 'flex', listStyle: 'none', padding: 0, margin: 0, fontSize: '0.875rem', color: 'var(--pc-text-tertiary)' }}>
                <li style={{ display: 'flex', alignItems: 'center' }}>
                    <Link to={homeRoot} style={{ color: 'var(--pc-text-tertiary)', textDecoration: 'none', transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--pc-text-primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'var(--pc-text-tertiary)'}>
                        Home
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
                            <span style={{ margin: '0 0.5rem', color: 'var(--pc-border-secondary)' }}>/</span>
                            {isLast ? (
                                <span style={{ fontWeight: 600, color: 'var(--pc-text-primary)' }} aria-current="page">
                                    {label}
                                </span>
                            ) : (
                                <Link to={to} style={{ color: 'var(--pc-text-secondary)', textDecoration: 'none', fontWeight: 500 }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--pc-text-primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'var(--pc-text-secondary)'}>
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

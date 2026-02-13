import React from 'react';
import { Link, useLocation } from 'react-router-dom';

export const Breadcrumb: React.FC = () => {
    const location = useLocation();
    const pathnames = location.pathname.split('/').filter((x) => x);

    return (
        <nav
            data-cy="breadcrumb"
            aria-label="Breadcrumb"
            style={{
                marginBottom: '1rem',
                fontSize: '0.85rem',
                fontWeight: 600,
                color: '#6B7280'
            }}
        >
            <ol style={{ listStyle: 'none', padding: 0, margin: 0, display: 'flex', alignItems: 'center', gap: '8px' }}>
                <li>
                    <Link to="/" style={{ color: '#00875A', textDecoration: 'none' }}>Home</Link>
                </li>
                {pathnames.map((value, index) => {
                    const last = index === pathnames.length - 1;
                    const to = `/${pathnames.slice(0, index + 1).join('/')}`;

                    return (
                        <li key={to} style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                            <span>/</span>
                            {last ? (
                                <span style={{ color: '#111827', textTransform: 'capitalize' }}>
                                    {value.replace(/-/g, ' ')}
                                </span>
                            ) : (
                                <Link to={to} style={{ color: '#00875A', textDecoration: 'none', textTransform: 'capitalize' }}>
                                    {value.replace(/-/g, ' ')}
                                </Link>
                            )}
                        </li>
                    );
                })}
            </ol>
        </nav>
    );
};

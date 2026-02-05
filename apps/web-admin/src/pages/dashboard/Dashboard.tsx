import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function Dashboard() {
    const [stats, setStats] = useState({ users: 0, approvals: 0, unassigned: 0 });

    useEffect(() => {
        // Mock fetching stats
        setStats({ users: 12, approvals: 3, unassigned: 5 });
    }, []);

    return (
        <div style={{ minHeight: '100vh', backgroundColor: '#f3f4f6' }}>
            <nav style={{ backgroundColor: '#004d40', padding: '1rem' }}>
                <div style={{ maxWidth: '1200px', margin: '0 auto', color: 'white', fontWeight: 'bold' }}>
                    {ContentRegistry.APP.NAME}
                </div>
            </nav>

            <div style={{ maxWidth: '1200px', margin: '0 auto', padding: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', marginBottom: '1.5rem' }}>{ContentRegistry.DASHBOARD.TITLE}</h2>

                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1.5rem' }}>
                    <Link to={RouteRegistry.USERS} style={{ textDecoration: 'none' }}>
                        <div style={{ padding: '1.5rem', backgroundColor: 'white', borderRadius: '8px', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', cursor: 'pointer' }}>
                            <div style={{ color: '#6b7280', fontSize: '0.875rem' }}>{ContentRegistry.DASHBOARD.STATS.USERS}</div>
                            <div style={{ fontSize: '2rem', fontWeight: 'bold', color: '#111827' }}>{stats.users}</div>
                        </div>
                    </Link>
                    <div style={{ padding: '1.5rem', backgroundColor: 'white', borderRadius: '8px', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                        <div style={{ color: '#6b7280', fontSize: '0.875rem' }}>{ContentRegistry.DASHBOARD.STATS.PSWS}</div>
                        <div style={{ fontSize: '2rem', fontWeight: 'bold', color: '#f59e0b' }}>{stats.approvals}</div>
                    </div>
                    <div style={{ padding: '1.5rem', backgroundColor: 'white', borderRadius: '8px', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                        <div style={{ color: '#6b7280', fontSize: '0.875rem' }}>{ContentRegistry.DASHBOARD.STATS.VISITS}</div>
                        <div style={{ fontSize: '2rem', fontWeight: 'bold', color: '#ef4444' }}>{stats.unassigned}</div>
                    </div>

                    <Link to={RouteRegistry.SCHEDULE} style={{ textDecoration: 'none' }}>
                        <div style={{ padding: '1.5rem', backgroundColor: 'white', borderRadius: '8px', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', cursor: 'pointer' }}>
                            <div style={{ color: '#6b7280', fontSize: '0.875rem' }}>View Schedule</div>
                            <div style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#004d40', marginTop: '0.5rem' }}>Calendar &rarr;</div>
                        </div>
                    </Link>
                </div>
            </div>
        </div>
    );
}

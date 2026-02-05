import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function Dashboard() {
    const [stats, setStats] = useState({ users: 0, approvals: 0, unassigned: 0, leads: 0 });

    useEffect(() => {
        // Mock fetching stats
        setStats({ users: 124, approvals: 8, unassigned: 15, leads: 27 });
    }, []);

    const statCards = [
        { label: 'Total Clients', value: stats.users, color: '#004d40', icon: '👥' },
        { label: 'Pending PSWs', value: stats.approvals, color: '#f59e0b', icon: '📝' },
        { label: 'Unassigned Visits', value: stats.unassigned, color: '#ef4444', icon: '⚠️' },
        { label: 'New Lead Inquiries', value: stats.leads, color: '#2563eb', icon: '📥' },
    ];

    return (
        <div>
            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: '0 0 0.5rem 0', color: '#111827' }}>
                    Welcome back, Admin
                </h2>
                <p style={{ color: '#6b7280', margin: 0 }}>Here is what's happening today at PrimeCare.</p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '1.5rem', marginBottom: '3rem' }}>
                {statCards.map((card, index) => (
                    <div key={index} style={{
                        padding: '1.5rem',
                        backgroundColor: 'white',
                        borderRadius: '0.75rem',
                        boxShadow: '0 1px 3px rgba(0,0,0,0.1)',
                        display: 'flex',
                        flexDirection: 'column',
                        gap: '0.5rem'
                    }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                            <span style={{ color: '#6b7280', fontSize: '0.875rem', fontWeight: '500' }}>{card.label}</span>
                            <span style={{ fontSize: '1.25rem' }}>{card.icon}</span>
                        </div>
                        <div style={{ fontSize: '2rem', fontWeight: 'bold', color: card.color }}>
                            {card.value}
                        </div>
                    </div>
                ))}
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))', gap: '2rem' }}>
                {/* Recent Activity / Quick Actions Container */}
                <div style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                    <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '1.25rem', color: '#111827' }}>Quick Actions</h3>
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                        <Link to={RouteRegistry.USERS} style={{ textDecoration: 'none' }}>
                            <button style={{ width: '100%', padding: '1rem', backgroundColor: '#f9fafb', border: '1px solid #e5e7eb', borderRadius: '0.5rem', cursor: 'pointer', textAlign: 'left' }}>
                                <div style={{ fontWeight: '600', color: '#004d40' }}>Verify PSWs</div>
                                <div style={{ fontSize: '0.75rem', color: '#6b7280' }}>Check certifications</div>
                            </button>
                        </Link>
                        <Link to={RouteRegistry.SCHEDULE} style={{ textDecoration: 'none' }}>
                            <button style={{ width: '100%', padding: '1rem', backgroundColor: '#f9fafb', border: '1px solid #e5e7eb', borderRadius: '0.5rem', cursor: 'pointer', textAlign: 'left' }}>
                                <div style={{ fontWeight: '600', color: '#004d40' }}>View Schedule</div>
                                <div style={{ fontSize: '0.75rem', color: '#6b7280' }}>Manage assignments</div>
                            </button>
                        </Link>
                        <Link to="/leads" style={{ textDecoration: 'none' }}>
                            <button style={{ width: '100%', padding: '1rem', backgroundColor: '#f9fafb', border: '1px solid #e5e7eb', borderRadius: '0.5rem', cursor: 'pointer', textAlign: 'left' }}>
                                <div style={{ fontWeight: '600', color: '#004d40' }}>Review Leads</div>
                                <div style={{ fontSize: '0.75rem', color: '#6b7280' }}>Respond to inquiries</div>
                            </button>
                        </Link>
                        <button style={{ width: '100%', padding: '1rem', backgroundColor: '#f9fafb', border: '1px solid #e5e7eb', borderRadius: '0.5rem', cursor: 'pointer', textAlign: 'left' }}>
                            <div style={{ fontWeight: '600', color: '#004d40' }}>System Config</div>
                            <div style={{ fontSize: '0.75rem', color: '#6b7280' }}>App adjustments</div>
                        </button>
                    </div>
                </div>

                <div style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                    <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '1.25rem', color: '#111827' }}>Operational Status</h3>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.75rem 0', borderBottom: '1px solid #f3f4f6' }}>
                            <span style={{ color: '#374151' }}>Worker API Status</span>
                            <span style={{ color: '#059669', fontWeight: '600' }}>● Healthy</span>
                        </div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.75rem 0', borderBottom: '1px solid #f3f4f6' }}>
                            <span style={{ color: '#374151' }}>Mobile Client App</span>
                            <span style={{ color: '#059669', fontWeight: '600' }}>● v1.0.4 Online</span>
                        </div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.75rem 0' }}>
                            <span style={{ color: '#374151' }}>Mobile PSW App</span>
                            <span style={{ color: '#059669', fontWeight: '600' }}>● v1.0.4 Online</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}

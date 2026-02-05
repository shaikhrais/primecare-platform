import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry, ApiRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

export default function AdminDashboard() {
    const [stats, setStats] = useState({ totalUsers: 0, pendingVisits: 0, totalVisits: 0, totalLeads: 0 });
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchStats = async () => {
            try {
                const token = localStorage.getItem('token');
                const response = await fetch(`${API_URL}${ApiRegistry.ADMIN.STATS}`, {
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                if (response.ok) {
                    const data = await response.json();
                    setStats(data);
                }
            } catch (error) {
                console.error('Failed to fetch stats', error);
            } finally {
                setLoading(false);
            }
        };
        fetchStats();
    }, []);

    const statCards = [
        { label: ContentRegistry.ADMIN_DASHBOARD.STATS.TOTAL_USERS, value: stats.totalUsers, color: '#004d40', icon: '👥' },
        { label: ContentRegistry.ADMIN_DASHBOARD.STATS.NEW_INQUIRIES, value: stats.totalLeads, color: '#2563eb', icon: '📥' },
        { label: ContentRegistry.ADMIN_DASHBOARD.STATS.PENDING_VISITS, value: stats.pendingVisits, color: '#f59e0b', icon: '📝' },
        { label: ContentRegistry.ADMIN_DASHBOARD.STATS.TOTAL_VISITS, value: stats.totalVisits, color: '#ef4444', icon: '📋' },
    ];

    return (
        <div>
            <div style={{ marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: '0 0 0.5rem 0', color: '#111827' }}>
                    {ContentRegistry.ADMIN_DASHBOARD.TITLES.WELCOME}
                </h2>
                <p style={{ color: '#6b7280', margin: 0 }}>{ContentRegistry.ADMIN_DASHBOARD.TITLES.SUBTITLE}</p>
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
                    <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '1.25rem', color: '#111827' }}>
                        {ContentRegistry.ADMIN_DASHBOARD.TITLES.QUICK_ACTIONS}
                    </h3>
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                        <Link to={RouteRegistry.USERS} style={{ textDecoration: 'none' }}>
                            <button style={{ width: '100%', padding: '1rem', backgroundColor: '#f9fafb', border: '1px solid #e5e7eb', borderRadius: '0.5rem', cursor: 'pointer', textAlign: 'left' }}>
                                <div style={{ fontWeight: '600', color: '#004d40' }}>{ContentRegistry.USERS.TITLE}</div>
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
                        <Link to="/settings" style={{ textDecoration: 'none' }}>
                            <button style={{ width: '100%', padding: '1rem', backgroundColor: '#f9fafb', border: '1px solid #e5e7eb', borderRadius: '0.5rem', cursor: 'pointer', textAlign: 'left' }}>
                                <div style={{ fontWeight: '600', color: '#004d40' }}>System Config</div>
                                <div style={{ fontSize: '0.75rem', color: '#6b7280' }}>App adjustments</div>
                            </button>
                        </Link>
                    </div>
                </div>

                <div style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
                    <h3 style={{ fontSize: '1.125rem', fontWeight: '600', marginBottom: '1.25rem', color: '#111827' }}>
                        {ContentRegistry.ADMIN_DASHBOARD.TITLES.OPERATIONAL_STATUS}
                    </h3>
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

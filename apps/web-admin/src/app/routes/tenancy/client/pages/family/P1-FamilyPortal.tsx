// ================================================================
// PAGE IDENTITY: P1 · Family Portal — Enhanced
// Type: Portal | Owner: client
// ================================================================
import React, { useState } from 'react';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';
import { AdminRegistry } from 'prime-care-shared';
const { ApiRegistry } = AdminRegistry;

export default function FamilyPortal() {
    const [activeTab, setActiveTab] = useState('overview');

    // Family-specific data queries
    const { data: schedule = [] } = useRegistryQuery<any[]>('/v1/client/family/schedule', {
        queryKey: ['family', 'schedule'],
        staleTime: 30_000,
    });
    const { data: notifications = [] } = useRegistryQuery<any[]>('/v1/client/family/notifications', {
        queryKey: ['family', 'notifications'],
        staleTime: 15_000,
    });

    const tabs = [
        { id: 'overview', label: '📊 Overview', icon: '📊' },
        { id: 'schedule', label: '📋 Care Schedule', icon: '📋' },
        { id: 'notes', label: '📝 Visit Notes', icon: '📝' },
        { id: 'messages', label: '💬 Messages', icon: '💬' },
        { id: 'documents', label: '📁 Documents', icon: '📁' },
    ];

    return (
        <div role="main" aria-label="Family Portal" data-cy="P1-page" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            {/* Header with gradient */}
            <div style={{
                background: 'linear-gradient(135deg, var(--pc-primary) 0%, var(--pc-primary-light) 100%)',
                borderRadius: '20px', padding: '32px', marginBottom: '24px', color: 'white',
                position: 'relative', overflow: 'hidden',
            }}>
                <div style={{ position: 'absolute', top: '-20px', right: '-20px', width: '160px', height: '160px', borderRadius: '50%', background: 'rgba(255,255,255,0.08)' }} />
                <div style={{ position: 'absolute', bottom: '-30px', left: '40%', width: '120px', height: '120px', borderRadius: '50%', background: 'rgba(255,255,255,0.05)' }} />
                <h1 style={{ fontSize: '1.75rem', fontWeight: 800, margin: '0 0 8px', position: 'relative' }}>🏠 Family Care Portal</h1>
                <p style={{ opacity: 0.9, fontSize: '0.9rem', margin: 0, position: 'relative' }}>
                    Stay connected with your loved one's care journey
                </p>
            </div>

            {/* Tab Navigation */}
            <div style={{ display: 'flex', gap: '4px', marginBottom: '24px', overflowX: 'auto', paddingBottom: '4px' }}>
                {tabs.map(tab => (
                    <button
                        key={tab.id}
                        onClick={() => setActiveTab(tab.id)}
                        data-cy={`tab-family-${tab.id}`}
                        style={{
                            padding: '10px 20px', borderRadius: '10px', border: 'none',
                            backgroundColor: activeTab === tab.id ? 'var(--pc-primary)' : 'var(--pc-bg-secondary)',
                            color: activeTab === tab.id ? 'white' : 'var(--pc-text-secondary)',
                            fontWeight: 700, fontSize: '0.85rem', cursor: 'pointer',
                            transition: 'all 0.2s ease', whiteSpace: 'nowrap',
                        }}
                    >
                        {tab.label}
                    </button>
                ))}
            </div>

            {/* Tab Content */}
            {activeTab === 'overview' && (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(260px, 1fr))', gap: '16px' }}>
                    {/* Live Visit Status */}
                    <div style={{ background: 'var(--pc-surface-card)', borderRadius: '16px', padding: '24px', border: '1px solid var(--pc-border-primary)', gridColumn: 'span 2' }}>
                        <h3 style={{ margin: '0 0 16px', fontSize: '1rem', fontWeight: 700, color: 'var(--pc-text-primary)' }}>🟢 Today's Care Status</h3>
                        <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap' }}>
                            <div style={{ flex: '1 1 200px', padding: '16px', background: 'var(--pc-success-bg, rgba(5,150,105,0.08))', borderRadius: '12px', textAlign: 'center' }}>
                                <div style={{ fontSize: '2rem', fontWeight: 900, color: 'var(--pc-success)' }}>
                                    {schedule.filter((s: any) => s?.status === 'completed').length}
                                </div>
                                <div style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--pc-text-secondary)' }}>Visits Completed</div>
                            </div>
                            <div style={{ flex: '1 1 200px', padding: '16px', background: 'var(--pc-info-bg, rgba(37,99,235,0.08))', borderRadius: '12px', textAlign: 'center' }}>
                                <div style={{ fontSize: '2rem', fontWeight: 900, color: 'var(--pc-info, #2563EB)' }}>
                                    {schedule.filter((s: any) => s?.status === 'scheduled').length}
                                </div>
                                <div style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--pc-text-secondary)' }}>Upcoming</div>
                            </div>
                            <div style={{ flex: '1 1 200px', padding: '16px', background: 'var(--pc-warning-bg, rgba(245,158,11,0.08))', borderRadius: '12px', textAlign: 'center' }}>
                                <div style={{ fontSize: '2rem', fontWeight: 900, color: 'var(--pc-warning)' }}>
                                    {notifications.length}
                                </div>
                                <div style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--pc-text-secondary)' }}>Notifications</div>
                            </div>
                        </div>
                    </div>

                    {/* Quick Actions */}
                    {[
                        { icon: '📅', title: 'Weekly Schedule', desc: 'View upcoming visits and care plans', color: '#2563EB' },
                        { icon: '📞', title: 'Contact Care Team', desc: 'Message or call the assigned PSW', color: '#059669' },
                        { icon: '⭐', title: 'Rate Recent Visit', desc: 'Share feedback on care quality', color: '#F59E0B' },
                        { icon: '🚨', title: 'Report Concern', desc: 'Flag an issue for immediate review', color: '#DC2626' },
                        { icon: '📄', title: 'Care Plan', desc: 'Review the current care plan details', color: '#7C3AED' },
                        { icon: '💊', title: 'Medications', desc: 'View medication schedule and logs', color: '#0891B2' },
                    ].map((item, i) => (
                        <div key={i} style={{
                            background: 'var(--pc-surface-card)', borderRadius: '14px', padding: '20px',
                            border: '1px solid var(--pc-border-primary)', cursor: 'pointer',
                            transition: 'transform 0.2s ease, box-shadow 0.2s ease',
                        }}
                        onMouseEnter={e => { e.currentTarget.style.transform = 'translateY(-2px)'; e.currentTarget.style.boxShadow = '0 8px 25px rgba(0,0,0,0.08)'; }}
                        onMouseLeave={e => { e.currentTarget.style.transform = 'translateY(0)'; e.currentTarget.style.boxShadow = 'none'; }}
                        >
                            <div style={{ fontSize: '2rem', marginBottom: '8px' }}>{item.icon}</div>
                            <div style={{ fontSize: '0.95rem', fontWeight: 700, color: 'var(--pc-text-primary)', marginBottom: '4px' }}>{item.title}</div>
                            <div style={{ fontSize: '0.75rem', color: 'var(--pc-text-tertiary)' }}>{item.desc}</div>
                        </div>
                    ))}
                </div>
            )}

            {activeTab === 'schedule' && (
                <div style={{ background: 'var(--pc-surface-card)', borderRadius: '16px', padding: '24px', border: '1px solid var(--pc-border-primary)' }}>
                    <h3 style={{ margin: '0 0 16px', fontWeight: 700, color: 'var(--pc-text-primary)' }}>📋 This Week's Care Schedule</h3>
                    {schedule.length === 0 ? (
                        <div style={{ textAlign: 'center', padding: '40px', color: 'var(--pc-text-tertiary)' }}>
                            <div style={{ fontSize: '3rem', marginBottom: '12px' }}>📅</div>
                            <p>No scheduled visits this week. Contact your care coordinator to set up visits.</p>
                        </div>
                    ) : (
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                            {schedule.map((visit: any, i: number) => (
                                <div key={i} style={{
                                    display: 'flex', alignItems: 'center', gap: '16px', padding: '16px',
                                    background: 'var(--pc-bg-secondary)', borderRadius: '12px',
                                }}>
                                    <div style={{ fontSize: '1.5rem' }}>🏥</div>
                                    <div style={{ flex: 1 }}>
                                        <div style={{ fontWeight: 700, color: 'var(--pc-text-primary)' }}>
                                            {visit.service?.name || 'Personal Care'}
                                        </div>
                                        <div style={{ fontSize: '0.8rem', color: 'var(--pc-text-secondary)' }}>
                                            {visit.psw?.fullName || 'TBD'} • {visit.requestedStartAt ? new Date(visit.requestedStartAt).toLocaleString() : 'Time TBD'}
                                        </div>
                                    </div>
                                    <span style={{
                                        padding: '4px 12px', borderRadius: '20px', fontSize: '0.7rem', fontWeight: 700,
                                        backgroundColor: visit.status === 'completed' ? 'rgba(5,150,105,0.12)' : 'rgba(37,99,235,0.12)',
                                        color: visit.status === 'completed' ? '#059669' : '#2563EB',
                                    }}>
                                        {(visit.status || 'scheduled').toUpperCase()}
                                    </span>
                                </div>
                            ))}
                        </div>
                    )}
                </div>
            )}

            {activeTab === 'notes' && (
                <div style={{ background: 'var(--pc-surface-card)', borderRadius: '16px', padding: '24px', border: '1px solid var(--pc-border-primary)' }}>
                    <h3 style={{ margin: '0 0 16px', fontWeight: 700, color: 'var(--pc-text-primary)' }}>📝 Recent Visit Notes</h3>
                    <div style={{ textAlign: 'center', padding: '40px', color: 'var(--pc-text-tertiary)' }}>
                        <div style={{ fontSize: '3rem', marginBottom: '12px' }}>📝</div>
                        <p>Visit notes from your care team will appear here after each visit.</p>
                    </div>
                </div>
            )}

            {activeTab === 'messages' && (
                <div style={{ background: 'var(--pc-surface-card)', borderRadius: '16px', padding: '24px', border: '1px solid var(--pc-border-primary)' }}>
                    <h3 style={{ margin: '0 0 16px', fontWeight: 700, color: 'var(--pc-text-primary)' }}>💬 Messages</h3>
                    <div style={{ textAlign: 'center', padding: '40px', color: 'var(--pc-text-tertiary)' }}>
                        <div style={{ fontSize: '3rem', marginBottom: '12px' }}>💬</div>
                        <p>Communicate securely with your care team. Messages are encrypted and HIPAA-compliant.</p>
                    </div>
                </div>
            )}

            {activeTab === 'documents' && (
                <div style={{ background: 'var(--pc-surface-card)', borderRadius: '16px', padding: '24px', border: '1px solid var(--pc-border-primary)' }}>
                    <h3 style={{ margin: '0 0 16px', fontWeight: 700, color: 'var(--pc-text-primary)' }}>📁 Documents</h3>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(200px, 1fr))', gap: '12px' }}>
                        {['Care Plan', 'Insurance Card', 'Medical History', 'Emergency Contacts', 'Consent Forms', 'Assessment Reports'].map((doc, i) => (
                            <div key={i} style={{
                                padding: '16px', background: 'var(--pc-bg-secondary)', borderRadius: '12px',
                                cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '10px',
                                transition: 'background 0.2s',
                            }}
                            onMouseEnter={e => e.currentTarget.style.background = 'var(--pc-bg-tertiary, #E2E8F0)'}
                            onMouseLeave={e => e.currentTarget.style.background = 'var(--pc-bg-secondary)'}
                            >
                                <span style={{ fontSize: '1.5rem' }}>📄</span>
                                <div>
                                    <div style={{ fontWeight: 600, fontSize: '0.85rem', color: 'var(--pc-text-primary)' }}>{doc}</div>
                                    <div style={{ fontSize: '0.7rem', color: 'var(--pc-text-tertiary)' }}>PDF • Updated recently</div>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>
            )}
        </div>
    );
}

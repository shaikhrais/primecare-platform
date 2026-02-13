import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { SecureSessionGuard } from '../components/SecureSessionGuard';
import { WelcomeCard } from '../components/WelcomeCard';
import { TodayShiftCard } from '../components/TodayShiftCard';
import { QuickActionPanel } from '../components/QuickActionPanel';
import { UpcomingVisitsList } from '../components/UpcomingVisitsList';
import { ConnectionStatusBanner } from '../components/ConnectionStatusBanner';
import { VitalsSummaryChart } from '../components/VitalsSummaryChart';
import { DashboardStats } from '../components/DashboardStats';

const { ApiRegistry } = AdminRegistry;
import { apiClient } from '@/shared/utils/apiClient';

export default function PswDashboardEnterprise() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [shifts, setShifts] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    const getUser = () => {
        try {
            const userStr = localStorage.getItem('user');
            if (!userStr || userStr === 'undefined') return { fullName: 'Caregiver', roles: [], activeRole: 'psw' };
            return JSON.parse(userStr);
        } catch (e) {
            console.error('Failed to parse user session', e);
            return { fullName: 'Caregiver', roles: [], activeRole: 'psw' };
        }
    };

    const user = getUser();

    const fetchShifts = async () => {
        setLoading(true);
        try {
            const response = await apiClient.get('/v1/psw/schedule/visits');
            if (response.ok) {
                const data = await response.json();
                setShifts(Array.isArray(data) ? data : []);
            } else {
                setShifts([]);
            }
        } catch (error) {
            console.error('Failed to fetch shifts', error);
            showToast('Failed to load shifts', 'error');
            setShifts([]);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchShifts();
    }, []);

    const activeShift = (shifts && shifts.length > 0)
        ? (shifts.find(s => s?.status?.toLowerCase() === 'in_progress') || shifts[0])
        : null;

    const upcomingVisits = (shifts || [])
        .filter(s => s?.id !== activeShift?.id)
        .slice(0, 3)
        .map(s => ({
            id: s?.id || Math.random().toString(),
            clientName: s?.client?.fullName || 'Unknown Client',
            time: s?.requestedStartAt ? new Date(s.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) : 'TBD'
        }));

    return (
        <SecureSessionGuard allowedRoles={['psw', 'admin']}>
            <ConnectionStatusBanner />
            <div
                data-cy="page.container"
                style={{
                    display: 'flex',
                    flexDirection: 'column',
                    gap: '2.5rem',
                    paddingBottom: '4rem',
                    animation: 'fadeIn 0.6s cubic-bezier(0.16, 1, 0.3, 1)'
                }}
            >
                {/* Hero Section: Welcome & Key Stats */}
                <div style={{ display: 'flex', flexDirection: 'column', gap: '2rem' }}>
                    <WelcomeCard
                        userName={user?.fullName?.split(' ')[0] || 'Caregiver'}
                        shiftCount={shifts?.length || 0}
                    />
                    <DashboardStats />
                </div>

                {/* --- BENTO BOX GRID --- */}
                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(12, 1fr)',
                    gridAutoRows: 'min-content',
                    gap: '2rem'
                }}>
                    {/* Active Shift Card - Spans 8 columns on desktop */}
                    <div style={{ gridColumn: 'span 8', gridRow: 'span 1' }}>
                        {loading ? (
                            <div style={{ padding: '64px', textAlign: 'center', backgroundColor: '#F9FAFB', borderRadius: '24px', border: '1px solid #E5E7EB' }}>
                                <div style={{ marginBottom: '16px', color: '#00875A', fontSize: '1.5rem', fontWeight: 800 }}>Loading visits...</div>
                                <div style={{ color: '#6B7280' }}>Preparing your enterprise workspace</div>
                            </div>
                        ) : activeShift ? (
                            <div onClick={() => navigate(`/visits/${activeShift.id}`)} style={{ cursor: 'pointer' }}>
                                <TodayShiftCard
                                    clientName={activeShift?.client?.fullName || 'Client'}
                                    startTime={activeShift?.requestedStartAt ? new Date(activeShift.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) : 'TBD'}
                                    address={activeShift?.serviceAddressLine1 || activeShift?.client?.addressLine1 || 'Address unavailable'}
                                    status={activeShift?.status || 'Active'}
                                    onCheckIn={(e: any) => { e.stopPropagation(); showToast('Starting visit...', 'info'); }}
                                    onCheckOut={(e: any) => { e.stopPropagation(); showToast('Completing visit...', 'info'); }}
                                />
                            </div>
                        ) : (
                            <div style={{ padding: '64px', textAlign: 'center', backgroundColor: '#F9FAFB', borderRadius: '24px', border: '1px solid #E5E7EB' }}>
                                <div style={{ fontSize: '3rem', marginBottom: '1rem' }}>🎉</div>
                                <p style={{ color: '#111827', margin: 0, fontWeight: 900, fontSize: '1.25rem' }}>You're all set for now!</p>
                                <p style={{ color: '#6B7280', marginTop: '8px' }}>No shifts scheduled for the rest of today.</p>
                            </div>
                        )}
                    </div>

                    {/* Quick Actions Panel - Spans 4 columns */}
                    <div style={{ gridColumn: 'span 4', gridRow: 'span 1' }}>
                        <QuickActionPanel />
                    </div>

                    {/* Vitals Chart - Spans 7 columns */}
                    <div style={{ gridColumn: 'span 7' }}>
                        <VitalsSummaryChart />
                    </div>

                    {/* Upcoming Visits - Spans 5 columns */}
                    <div style={{ gridColumn: 'span 5' }}>
                        <UpcomingVisitsList visits={upcomingVisits} onItemClick={(id: string) => navigate(`/visits/${id}`)} />
                    </div>

                    {/* Compliance Status - Spans 4 columns */}
                    <div style={{ gridColumn: 'span 4' }}>
                        <div style={{
                            padding: '32px',
                            backgroundColor: '#E6F4EF',
                            border: '1px solid #00875A',
                            borderRadius: '24px',
                            height: '100%',
                            boxSizing: 'border-box',
                            display: 'flex',
                            flexDirection: 'column',
                            justifyContent: 'space-between'
                        }}>
                            <div>
                                <h4 style={{ margin: '0 0 16px 0', fontSize: '0.9rem', fontWeight: 900, color: '#00875A', textTransform: 'uppercase', letterSpacing: '1px' }}>
                                    🛡️ Compliance
                                </h4>
                                <p style={{ margin: 0, fontSize: '1.25rem', fontWeight: 900, lineHeight: 1.4, color: '#064E3B' }}>
                                    Your certifications are <span style={{ color: '#059669' }}>fully active</span>.
                                </p>
                            </div>
                            <button style={{
                                marginTop: '24px',
                                background: '#059669',
                                color: 'white',
                                border: 'none',
                                padding: '14px 20px',
                                borderRadius: '16px',
                                fontWeight: 800,
                                fontSize: '0.9rem',
                                cursor: 'pointer',
                                transition: 'all 0.2s',
                                boxShadow: '0 4px 12px rgba(5, 150, 105, 0.2)'
                            }}>
                                Review Documents
                            </button>
                        </div>
                    </div>

                    {/* Monthly Summary - Spans 8 columns */}
                    <div style={{ gridColumn: 'span 8' }}>
                        <div style={{
                            padding: '32px',
                            backgroundColor: '#000000',
                            borderRadius: '24px',
                            color: '#FFFFFF',
                            display: 'flex',
                            justifyContent: 'space-between',
                            alignItems: 'center',
                            height: '100%',
                            boxSizing: 'border-box'
                        }}>
                            <div style={{ display: 'flex', gap: '4rem', alignItems: 'center' }}>
                                <div>
                                    <h4 style={{ margin: '0 0 8px 0', fontSize: '0.75rem', fontWeight: 800, color: '#00875A', textTransform: 'uppercase', opacity: 0.8 }}>
                                        Monthly Visits
                                    </h4>
                                    <div style={{ fontSize: '2.5rem', fontWeight: 900, letterSpacing: '-1px' }}>42</div>
                                </div>
                                <div style={{ height: '60px', width: '1px', background: 'rgba(255,255,255,0.1)' }}></div>
                                <div>
                                    <h4 style={{ margin: '0 0 8px 0', fontSize: '0.75rem', fontWeight: 800, color: '#00875A', textTransform: 'uppercase', opacity: 0.8 }}>
                                        Hours Logged
                                    </h4>
                                    <div style={{ fontSize: '2.5rem', fontWeight: 900, letterSpacing: '-1px' }}>128.5 <span style={{ fontSize: '1rem', opacity: 0.5 }}>hrs</span></div>
                                </div>
                                <div style={{ height: '60px', width: '1px', background: 'rgba(255,255,255,0.1)' }}></div>
                                <div>
                                    <h4 style={{ margin: '0 0 8px 0', fontSize: '0.75rem', fontWeight: 800, color: '#00875A', textTransform: 'uppercase', opacity: 0.8 }}>
                                        Care Score
                                    </h4>
                                    <div style={{ fontSize: '2.5rem', fontWeight: 900, letterSpacing: '-1px' }}>98%</div>
                                </div>
                            </div>
                            <div style={{ textAlign: 'right' }}>
                                <div style={{ color: '#00875A', fontWeight: 800, fontSize: '0.9rem' }}>Legendary Performance</div>
                                <div style={{ fontSize: '0.75rem', opacity: 0.5 }}>You're in the top 5% this month</div>
                            </div>
                        </div>
                    </div>
                </div>

                <style dangerouslySetInnerHTML={{
                    __html: `
                    @keyframes fadeIn {
                        from { opacity: 0; transform: translateY(20px); }
                        to { opacity: 1; transform: translateY(0); }
                    }
                    @media (max-width: 1280px) {
                        div[data-cy="page.container"] > div { grid-template-columns: 1fr !important; }
                        div[data-cy="page.container"] > div > div { grid-column: span 1 !important; }
                    }
                ` }} />
            </div>
        </SecureSessionGuard>
    );
}

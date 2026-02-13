import React, { useEffect, useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { SecureSessionGuard } from '../components/SecureSessionGuard';
import { WelcomeCard } from '../components/WelcomeCard';
import { TodayShiftCard } from '../components/TodayShiftCard';
import { QuickActionPanel } from '../components/QuickActionPanel';
import { UpcomingVisitsList } from '../components/UpcomingVisitsList';
import { ConnectionStatusBanner } from '../components/ConnectionStatusBanner';
import { VitalsSummaryChart } from '../components/VitalsSummaryChart';
import { Breadcrumb } from '../components/Breadcrumb';

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
                    gap: '2rem',
                    paddingBottom: '3rem',
                    animation: 'fadeIn 0.5s ease-out'
                }}
            >
                <Breadcrumb />

                <WelcomeCard
                    userName={user?.fullName?.split(' ')[0] || 'Caregiver'}
                    shiftCount={shifts?.length || 0}
                />

                {/* --- COMPONENT BOARD GRID --- */}
                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(350px, 1fr))',
                    gap: '2rem',
                    alignItems: 'start'
                }}>
                    {/* Primary Column: Shifts & Vitals */}
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '2rem' }}>
                        {loading ? (
                            <div style={{ padding: '60px', textAlign: 'center', backgroundColor: '#F9FAFB', borderRadius: '24px', border: '1px solid #E5E7EB' }}>
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
                            <div style={{ padding: '48px', textAlign: 'center', backgroundColor: '#F9FAFB', borderRadius: '24px', border: '1px solid #E5E7EB' }}>
                                <p style={{ color: '#6B7280', margin: 0, fontWeight: 600 }}>No shifts scheduled today.</p>
                            </div>
                        )}
                        <VitalsSummaryChart />
                    </div>

                    {/* Secondary Column: Actions & Upcoming */}
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '2rem' }}>
                        <QuickActionPanel />
                        <UpcomingVisitsList visits={upcomingVisits} onItemClick={(id: string) => navigate(`/visits/${id}`)} />
                    </div>

                    {/* Tertiary Column: Compliance & Insights (Visible on wide screens) */}
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '2rem' }}>
                        <div style={{
                            padding: '32px',
                            backgroundColor: '#E6F4EF',
                            border: '1px solid #00875A',
                            borderRadius: '24px',
                            boxShadow: '0 4px 6px -1px rgba(0, 135, 90, 0.1)'
                        }}>
                            <h4 style={{ margin: '0 0 12px 0', fontSize: '0.9rem', fontWeight: 900, color: '#00875A', textTransform: 'uppercase', letterSpacing: '1px' }}>
                                🛡️ Compliance Status
                            </h4>
                            <p style={{ margin: 0, fontSize: '1rem', fontWeight: 700, lineHeight: 1.5 }}>
                                All certifications are **active** and up to date.<br />
                                <span style={{ fontSize: '0.8rem', opacity: 0.7, fontWeight: 500 }}>Refreshed 2 days ago.</span>
                            </p>
                            <button style={{
                                marginTop: '20px',
                                background: '#00875A',
                                color: 'white',
                                border: 'none',
                                padding: '10px 16px',
                                borderRadius: '12px',
                                fontWeight: 800,
                                fontSize: '0.85rem',
                                cursor: 'pointer'
                            }}>
                                View Certificates
                            </button>
                        </div>

                        <div style={{
                            padding: '32px',
                            backgroundColor: '#000000',
                            borderRadius: '24px',
                            color: '#FFFFFF'
                        }}>
                            <h4 style={{ margin: '0 0 12px 0', fontSize: '0.8rem', fontWeight: 800, color: '#00875A', textTransform: 'uppercase' }}>
                                Monthly Summary
                            </h4>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                <div>
                                    <div style={{ fontSize: '1.75rem', fontWeight: 900 }}>42</div>
                                    <div style={{ fontSize: '0.8rem', opacity: 0.6 }}>Visits Completed</div>
                                </div>
                                <div style={{ height: '40px', width: '2px', background: 'rgba(255,255,255,0.1)' }}></div>
                                <div>
                                    <div style={{ fontSize: '1.75rem', fontWeight: 900 }}>128.5</div>
                                    <div style={{ fontSize: '0.8rem', opacity: 0.6 }}>Hours Worked</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <style>{`
                    @keyframes fadeIn {
                        from { opacity: 0; transform: translateY(10px); }
                        to { opacity: 1; transform: translateY(0); }
                    }
                `}</style>
            </div>
        </SecureSessionGuard>
    );
}

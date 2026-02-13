import React, { useEffect, useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { SecureSessionGuard } from '../../components/SecureSessionGuard';
import { WelcomeCard } from '../../components/WelcomeCard';
import { TodayShiftCard } from '../../components/TodayShiftCard';
import { QuickActionPanel } from '../../components/QuickActionPanel';
import { UpcomingVisitsList } from '../../components/UpcomingVisitsList';
import { ConnectionStatusBanner } from '../../components/ConnectionStatusBanner';
import { VitalsSummaryChart } from '../../components/VitalsSummaryChart';

const { ApiRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

interface Shift {
    id: string;
    client: { fullName: string };
    serviceAddressLine1: string;
    requestedStartAt: string;
    status: string;
    service: { name: string };
}

export default function PswDashboardEnterprise() {
    const { showToast } = useNotification();
    const [shifts, setShifts] = useState<Shift[]>([]);
    const [loading, setLoading] = useState(true);

    const userStr = localStorage.getItem('user');
    const user = userStr ? JSON.parse(userStr) : { fullName: 'Caregiver' };

    const fetchShifts = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.PSW.VISITS}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                setShifts(data);
            }
        } catch (error) {
            console.error('Failed to fetch shifts', error);
            showToast('Failed to load shifts', 'error');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchShifts();
    }, []);

    const activeShift = shifts.find(s => s.status.toLowerCase() === 'in_progress') || shifts[0];
    const upcomingVisits = shifts.filter(s => s.id !== activeShift?.id).map(s => ({
        id: s.id,
        clientName: s.client.fullName,
        time: new Date(s.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
    }));

    return (
        <SecureSessionGuard allowedRoles={['psw', 'admin']}>
            <ConnectionStatusBanner />
            <div data-cy="page.container" style={{ display: 'flex', flexDirection: 'column', gap: '2rem' }}>
                <WelcomeCard
                    userName={user.fullName.split(' ')[0]}
                    shiftCount={shifts.length}
                />

                <div style={{ display: 'grid', gridTemplateColumns: '1fr 350px', gap: '2rem' }}>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '2rem' }}>
                        {loading ? (
                            <p>Loading visits...</p>
                        ) : activeShift ? (
                            <TodayShiftCard
                                clientName={activeShift.client.fullName}
                                startTime={new Date(activeShift.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                                address={activeShift.serviceAddressLine1}
                                status={activeShift.status}
                                onCheckIn={() => showToast('Starting visit...', 'info')}
                                onCheckOut={() => showToast('Completing visit...', 'info')}
                            />
                        ) : (
                            <p>No shifts scheduled today.</p>
                        )}
                        <VitalsSummaryChart />
                    </div>

                    <div style={{ display: 'flex', flexDirection: 'column', gap: '2.5rem' }}>
                        <QuickActionPanel />
                        <UpcomingVisitsList visits={upcomingVisits} />
                    </div>
                </div>
            </div>
        </SecureSessionGuard>
    );
}

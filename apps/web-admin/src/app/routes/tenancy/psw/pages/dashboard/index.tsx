import React, { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { useAuth } from '@/shared/context/AuthContext';
import { useMediaQuery } from '@/shared/hooks/useMediaQuery';
import { MOCK_PSW_DATA, MOCK_MANAGER_DATA } from '@/shared/data/mockChartData';

// Components
import { PswStats } from './components/PswStats';
import { ShiftList } from './components/ShiftList';
import { ComplianceSection } from './components/ComplianceSection';
import { WellnessPulse } from './components/WellnessPulse';
import { useTranslation } from 'react-i18next';

const { ContentRegistry, ApiRegistry, RouteRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

interface Shift {
    id: string;
    client: { fullName: string };
    serviceAddressLine1: string;
    requestedStartAt: string;
    status: string;
    service: { name: string };
}

export default function PswDashboard() {
    const { t } = useTranslation();
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [shifts, setShifts] = useState<Shift[]>([]);
    const [chartData, setChartData] = useState<any>(null);
    const [loading, setLoading] = useState(true);

    const fetchShiftsAndStats = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            const [shiftsRes, statsRes] = await Promise.all([
                fetch(`${API_URL}${ApiRegistry.PSW.VISITS}`, { headers: { 'Authorization': `Bearer ${token}` } }),
                fetch(`${API_URL}${ApiRegistry.PSW.DASHBOARD_STATS}`, { headers: { 'Authorization': `Bearer ${token}` } })
            ]);

            if (shiftsRes.ok) {
                const data = await shiftsRes.json();
                setShifts(data);
            }

            if (statsRes.ok) {
                const statsData = await statsRes.json();
                setChartData(statsData);
            }

        } catch (error) {
            console.error('Failed to fetch dashboard data', error);
            showToast(ContentRegistry.COMMON.NETWORK_ERROR, 'error');
        } finally {
            setLoading(false);
        }
    };

    const handleCheckIn = async (id: string) => {
        if (!navigator.geolocation) {
            showToast('Geolocation is not supported by your browser', 'error');
            return;
        }

        navigator.geolocation.getCurrentPosition(async (position) => {
            try {
                const token = localStorage.getItem('token');
                const response = await fetch(`${API_URL}${ApiRegistry.PSW.CHECK_IN(id)}`, {
                    method: 'POST',
                    headers: {
                        'Authorization': `Bearer ${token}`,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        lat: position.coords.latitude,
                        lng: position.coords.longitude,
                        accuracy: position.coords.accuracy
                    })
                });
                if (response.ok) {
                    fetchShiftsAndStats();
                    showToast('Check-in successful!', 'success');
                } else {
                    const data = await response.json();
                    showToast(`Check-in failed: ${data.error || 'Unknown error'}`, 'error');
                }
            } catch (error) {
                showToast('Check-in failed', 'error');
            }
        }, (error) => {
            showToast(`Could not get location: ${error.message}`, 'error');
        });
    };

    const handleCheckOut = async (id: string) => {
        if (!navigator.geolocation) {
            showToast('Geolocation is not supported by your browser', 'error');
            return;
        }

        navigator.geolocation.getCurrentPosition(async (position) => {
            try {
                const token = localStorage.getItem('token');
                const response = await fetch(`${API_URL}${ApiRegistry.PSW.CHECK_OUT(id)}`, {
                    method: 'POST',
                    headers: {
                        'Authorization': `Bearer ${token}`,
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        lat: position.coords.latitude,
                        lng: position.coords.longitude,
                        accuracy: position.coords.accuracy
                    })
                });
                if (response.ok) {
                    fetchShiftsAndStats();
                    showToast('Check-out successful! Visit completed.', 'success');
                } else {
                    const data = await response.json();
                    showToast(`Check-out failed: ${data.error || 'Unknown error'}`, 'error');
                }
            } catch (error) {
                showToast('Check-out failed', 'error');
            }
        }, (error) => {
            showToast(`Could not get location: ${error.message}`, 'error');
        });
    };

    useEffect(() => {
        fetchShiftsAndStats();
    }, []);

    if (loading) {
        return <div style={{ padding: '2rem', textAlign: 'center' }}>Loading PSW Dashboard...</div>;
    }

    const { user } = useAuth();
    return (
        <div data-cy="page.container" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto', boxSizing: 'border-box' }}>
            <div style={{
                display: 'flex',
                flexWrap: 'wrap',
                justifyContent: 'space-between',
                alignItems: 'center',
                gap: '1.5rem',
                marginBottom: '2.5rem'
            }}>
                <div style={{ flex: '1 1 300px' }}>
                    <h1 data-cy="page.title" style={{ margin: '0', fontSize: '2.5rem', fontWeight: 800, color: '#000000', lineHeight: 1.1 }}>
                        {user?.tenantId ? 'My Provider Dashboard' : t(ContentRegistry.PSW_DASHBOARD.TITLE)}
                    </h1>
                    <p data-cy="page.subtitle" style={{ margin: '12px 0 0 0', color: '#4B5563', fontSize: '1.1rem' }}>
                        {user?.email ? `${user.email} • Independent Provider` : t(ContentRegistry.PSW_DASHBOARD.SUBTITLE)}
                    </p>
                </div>
                <div style={{ display: 'flex', gap: '12px', flexWrap: 'wrap', flex: '1 1 auto', justifyContent: 'flex-end' }}>
                    <button
                        className="btn-premium danger"
                        onClick={() => alert('Launching Incident Reporting Flow...')}
                        style={{
                            padding: '12px 24px',
                            fontWeight: '600',
                            cursor: 'pointer',
                            flex: '1 1 auto',
                            maxWidth: '200px'
                        }}
                    >
                        🚨 {AdminRegistry.ButtonRegistry.find(b => b.id === 'btn-psw-incident-report')?.label || 'Report Incident'}
                    </button>
                    <Link to={RouteRegistry.LEARN} style={{ textDecoration: 'none', flex: '1 1 auto', maxWidth: '200px' }}>
                        <button style={{
                            padding: '12px 24px',
                            backgroundColor: '#FFFFFF',
                            color: '#000000',
                            border: '1px solid #E5E7EB',
                            borderRadius: '8px',
                            fontWeight: '600',
                            cursor: 'pointer',
                            width: '100%',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            gap: '8px'
                        }}>
                            🎓 {t(ContentRegistry.LEARN.TITLE)}
                        </button>
                    </Link>
                    <button
                        onClick={() => alert('Opening Wellness Pulse...')}
                        style={{
                            padding: '12px 24px',
                            backgroundColor: '#10b981',
                            color: '#FFFFFF',
                            border: 'none',
                            borderRadius: '8px',
                            fontWeight: '600',
                            cursor: 'pointer',
                            flex: '1 1 auto',
                            maxWidth: '200px'
                        }}
                    >
                        ❤️ {AdminRegistry.ButtonRegistry.find(b => b.id === 'btn-psw-wellness-pulse')?.label || 'Report Status'}
                    </button>
                    <button
                        data-cy="btn-view-all-shifts"
                        onClick={() => navigate(AdminRegistry.RouteRegistry.PSW.SCHEDULE)}
                        style={{
                            padding: '12px 24px',
                            backgroundColor: 'var(--brand-500, #0f172a)',
                            color: '#FFFFFF',
                            border: 'none',
                            borderRadius: '8px',
                            fontWeight: '600',
                            cursor: 'pointer',
                            flex: '1 1 auto',
                            maxWidth: '200px'
                        }}
                    >
                        {AdminRegistry.ButtonRegistry.find(b => b.id === 'btn-psw-view-schedule')?.label || 'View Schedule'}
                    </button>
                </div>
            </div>

            {/* Phase 13 extra PSW actions */}
            <div style={{ display: 'flex', gap: '8px', marginBottom: '20px' }}>
                <button className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} onClick={() => alert('Sync Availability')}>{AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-psw-availability-sync')?.label || 'Sync Availability'}</button>
                <button className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} onClick={() => alert('Accept Offer')}>{AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-psw-offer-accept')?.label || 'Accept Offer'}</button>
                <button className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} onClick={() => alert('Decline Offer')}>{AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-psw-offer-decline')?.label || 'Decline Offer'}</button>
                <button className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} onClick={() => alert('Live Visit Options')}>{AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-psw-live-visit')?.label || 'Live Visit'}</button>
            </div>

            <PswStats chartData={chartData} />

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(350px, 1fr))', gap: '2rem' }}>
                <div style={{ gridColumn: '1 / -1', '@media (min-width: 1024px)': { gridColumn: 'auto' } } as any}>
                    <ShiftList
                        shifts={shifts}
                        loading={loading}
                        isMobile={false} // Component likely needs refactoring inside too, but for outer layout we pass false
                        onCheckIn={handleCheckIn}
                        onCheckOut={handleCheckOut}
                    />
                </div>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '2rem', minWidth: '350px' }}>
                    <ComplianceSection />
                    <WellnessPulse />
                </div>
            </div>
        </div >
    );
}

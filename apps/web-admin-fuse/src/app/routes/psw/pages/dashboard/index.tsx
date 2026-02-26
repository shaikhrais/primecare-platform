import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { useMediaQuery } from '@/shared/hooks/useMediaQuery';
import { MOCK_PSW_DATA, MOCK_MANAGER_DATA } from '@/shared/data/mockChartData';

// Components
import { PswStats } from './components/PswStats';
import { ShiftList } from './components/ShiftList';
import { ComplianceSection } from './components/ComplianceSection';

const { ContentRegistry, ApiRegistry } = AdminRegistry;
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
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [shifts, setShifts] = useState<Shift[]>([]);
    const [chartData, setChartData] = useState<any>(null);
    const [loading, setLoading] = useState(true);
    const isMobile = useMediaQuery('(max-width: 1024px)');

    const fetchShiftsAndStats = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            const [shiftsRes, statsRes] = await Promise.all([
                fetch(`${API_URL}${ApiRegistry.PSW.VISITS}`, { headers: { 'Authorization': `Bearer ${token}` } }),
                fetch(`${API_URL}/psw/dashboard/stats`, { headers: { 'Authorization': `Bearer ${token}` } })
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
            showToast('Failed to load dashboard data', 'error');
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

    return (
        <div data-cy="page.container" style={{ padding: isMobile ? '0' : '24px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{
                display: 'flex',
                flexDirection: isMobile ? 'column' : 'row',
                justifyContent: 'space-between',
                alignItems: isMobile ? 'flex-start' : 'flex-end',
                gap: '1.5rem',
                marginBottom: '2.5rem'
            }}>
                <div>
                    <h1 data-cy="page.title" style={{ margin: '0', fontSize: isMobile ? '2rem' : '2.5rem', fontWeight: 800, color: '#000000', lineHeight: 1.1 }}>
                        {ContentRegistry.PSW_DASHBOARD.TITLE}
                    </h1>
                    <p data-cy="page.subtitle" style={{ margin: '12px 0 0 0', color: '#4B5563', fontSize: isMobile ? '1rem' : '1.1rem' }}>
                        {ContentRegistry.PSW_DASHBOARD.SUBTITLE}
                    </p>
                </div>
                <button
                    data-cy="btn-view-all-shifts"
                    onClick={() => navigate('/psw/schedule')}
                    style={{
                        padding: '12px 24px',
                        backgroundColor: '#000000',
                        color: '#FFFFFF',
                        border: 'none',
                        borderRadius: '8px',
                        fontWeight: '600',
                        cursor: 'pointer',
                        width: isMobile ? '100%' : 'auto'
                    }}
                >
                    {ContentRegistry.PSW_DASHBOARD.BUTTON_FULL_SCHEDULE}
                </button>
            </div>

            <PswStats chartData={chartData} />

            <div style={{ display: 'grid', gridTemplateColumns: isMobile ? '1fr' : '1fr 350px', gap: '2rem' }}>
                <ShiftList
                    shifts={shifts}
                    loading={loading}
                    isMobile={isMobile}
                    onCheckIn={handleCheckIn}
                    onCheckOut={handleCheckOut}
                />

                <ComplianceSection />
            </div>
        </div >
    );
}

import React, { useEffect, useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';

// Components
import { ClientOverview } from './components/ClientOverview';
import { ServiceBookingModal } from './components/ServiceBookingModal';

const { ContentRegistry, ApiRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

interface Booking {
    id: string;
    service: { name: string };
    requestedStartAt: string;
    status: string;
    psw?: { fullName: string };
}

export default function ClientDashboard() {
    const { showToast } = useNotification();
    const [bookings, setBookings] = useState<Booking[]>([]);
    const [loading, setLoading] = useState(true);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [services, setServices] = useState<any[]>([]);
    const [stats, setStats] = useState<any>(null);

    const fetchBookings = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.CLIENT.BOOKINGS}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                setBookings(data);
            }
        } catch (error) {
            console.error('Failed to fetch bookings', error);
        } finally {
            setLoading(false);
        }
    };

    const fetchServices = async () => {
        try {
            const response = await fetch(`${API_URL}${ApiRegistry.CLIENT.SERVICES}`);
            if (response.ok) {
                const data = await response.json();
                setServices(data.filter((s: any) => s.isActive));
            }
        } catch (error) {
            console.error('Failed to fetch services', error);
        }
    };

    const fetchStats = async () => {
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}/client/dashboard/stats`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                setStats(data);
            }
        } catch (error) {
            console.error('Failed to fetch dashboard stats', error);
        }
    };

    useEffect(() => {
        fetchBookings();
        fetchServices();
        fetchStats();
    }, []);

    if (loading) {
        return <div style={{ padding: '2rem', textAlign: 'center' }}>Loading Client Dashboard...</div>;
    }

    return (
        <div data-cy="page.container">
            {/* Header */}
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h1 style={{ margin: '0 0 6px 0', fontSize: '34px', letterSpacing: '.2px', color: 'var(--text-100)' }} data-cy="page.title">{ContentRegistry.CLIENT_DASHBOARD.TITLE}</h1>
                    <p className="sub" style={{ margin: 0 }} data-cy="page.subtitle">{ContentRegistry.CLIENT_DASHBOARD.SUBTITLE}</p>
                </div>
                <button
                    data-cy="btn-request-care"
                    className="btn btn-primary"
                    onClick={() => setIsModalOpen(true)}
                >
                    {ContentRegistry.CLIENT_DASHBOARD.BUTTON_REQUEST}
                </button>
            </div>

            <ClientOverview stats={stats} />

            <ServiceBookingModal
                isOpen={isModalOpen}
                onClose={() => setIsModalOpen(false)}
                services={services}
                onSuccess={fetchBookings}
                showToast={showToast}
            />
        </div>
    );
}

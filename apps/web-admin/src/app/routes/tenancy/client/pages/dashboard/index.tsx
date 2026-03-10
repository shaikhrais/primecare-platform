import React, { useEffect, useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
const { ContentRegistry, ApiRegistry, RouteRegistry } = AdminRegistry;
import { useNotification } from '@/shared/context/NotificationContext';
import { useAuth } from '@/shared/context/AuthContext';

// Components
import { ClientOverview } from './components/ClientOverview';
import { ServiceBookingModal } from './components/ServiceBookingModal';
import { useTranslation } from 'react-i18next';

const API_URL = import.meta.env.VITE_API_URL;

interface Booking {
    id: string;
    service: { name: string };
    requestedStartAt: string;
    status: string;
    psw?: { fullName: string };
}

export default function ClientDashboard() {
    const navigate = useNavigate();
    const { t } = useTranslation();
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
            const response = await fetch(`${API_URL}${ApiRegistry.CLIENT.DASHBOARD_STATS}`, {
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
        return <div style={{ padding: '2rem', textAlign: 'center' }}>{t(ContentRegistry.CLIENT_DASHBOARD.MESSAGES.LOADING)}</div>;
    }

    const { user } = useAuth();
    return (
        <div data-cy="page.container">
            {/* Header */}
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h1 style={{ margin: '0 0 6px 0', fontSize: '34px', letterSpacing: '.2px', color: 'var(--text-100)' }} data-cy="page.title">
                        {user?.tenantId ? 'Patient Care Portal' : t(ContentRegistry.CLIENT_DASHBOARD.TITLE)}
                    </h1>
                    <p className="sub" style={{ margin: 0 }} data-cy="page.subtitle">
                        {user?.email ? `${user.email} • Your Care Team` : t(ContentRegistry.CLIENT_DASHBOARD.SUBTITLE)}
                    </p>
                </div>
                <div style={{ display: 'flex', gap: '1rem', alignItems: 'center' }}>
                    <Link
                        to={RouteRegistry.LEARN}
                        style={{
                            display: 'inline-flex',
                            alignItems: 'center',
                            gap: '8px',
                            padding: '12px 24px',
                            backgroundColor: 'white',
                            color: 'var(--brand-600)',
                            borderRadius: '12px',
                            textDecoration: 'none',
                            fontWeight: 700,
                            boxShadow: '0 4px 12px rgba(0,0,0,0.05)',
                            transition: 'all 0.2s'
                        }}
                    >
                        🎓 {t(ContentRegistry.LEARN.TITLE)}
                    </Link>
                    <button
                        className="btn"
                        style={{ backgroundColor: 'white', color: 'var(--brand-600)', border: '1px solid #e5e7eb', padding: '12px 16px', borderRadius: '12px', fontWeight: 600 }}
                        onClick={() => alert('Opening Support Chat...')}
                    >
                        💬 {AdminRegistry.ButtonRegistry.find(b => b.id === 'btn-client-support-chat')?.label || 'Chat'}
                    </button>
                    <button
                        className="btn"
                        onClick={() => navigate('/tenancy/client/family')}
                        style={{ backgroundColor: 'var(--brand-100)', color: 'var(--brand-700)', border: 'none', padding: '12px 16px', borderRadius: '12px', fontWeight: 600 }}
                    >
                        👨‍👩‍👧‍👦 {AdminRegistry.ButtonRegistry.find(b => b.id === 'btn-client-family-hub')?.label || 'Family Hub'}
                    </button>
                    <button
                        data-cy="btn-client-request-care"
                        className="btn btn-primary"
                        onClick={() => setIsModalOpen(true)}
                    >
                        {AdminRegistry.ButtonRegistry.find(b => b.id === 'btn-client-request-care')?.label || t(ContentRegistry.CLIENT_DASHBOARD.BUTTON_REQUEST)}
                    </button>
                </div>
            </div>
            {/* Phase 13 extra client actions */}
            <div style={{ display: 'flex', gap: '8px', marginBottom: '20px' }}>
                <button className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} onClick={() => alert('View Careplan')}>{AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-client-view-careplan')?.label || 'View Careplan'}</button>
                <button className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} onClick={() => setIsModalOpen(true)}>{AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-client-booking-request')?.label || 'Booking Request'}</button>
                <button className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px', color: 'red' }} onClick={() => alert('Cancel Visit')}>{AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-client-visit-cancel')?.label || 'Cancel Visit'}</button>
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

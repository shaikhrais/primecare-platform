import React, { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { AdminRegistry, ContentRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';
import './CheckInScreen.css';

const CONTENT = ContentRegistry.PSW_LIVE_VISIT;

export default function CheckInScreen() {
    const { id } = useParams();
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [visit, setVisit] = useState<any>(null);
    const [loading, setLoading] = useState(true);
    const [gpsStatus, setGpsStatus] = useState<'idle' | 'verifying' | 'verified' | 'error'>('idle');
    const [gpsAccuracy, setGpsAccuracy] = useState<number | null>(null);

    useEffect(() => {
        const fetchVisit = async () => {
            try {
                const response = await apiClient.get(AdminRegistry.ApiRegistry.PLATFORM.ADMIN.VISITS_UPDATE(id!));
                if (response.ok) {
                    const data = await response.json();
                    setVisit(data);
                } else {
                    showToast(CONTENT.MESSAGES.LOAD_VISIT_ERROR, 'error');
                }
            } catch (error) {
                showToast(CONTENT.MESSAGES.LOAD_VISIT_NETWORK_ERROR, 'error');
            } finally {
                setLoading(false);
            }
        };

        if (id) fetchVisit();
    }, [id, showToast]);

    const handleCheckIn = async () => {
        setGpsStatus('verifying');

        if (!navigator.geolocation) {
            showToast(CONTENT.MESSAGES.GEOLOCATION_NOT_SUPPORTED, 'error');
            setGpsStatus('error');
            return;
        }

        navigator.geolocation.getCurrentPosition(
            async (pos) => {
                setGpsAccuracy(pos.coords.accuracy);
                try {
                    const response = await apiClient.post(AdminRegistry.ApiRegistry.TENANCY.PSW.CHECK_IN(id!), {
                        lat: pos.coords.latitude,
                        lng: pos.coords.longitude,
                        accuracy: pos.coords.accuracy
                    });

                    if (response.ok) {
                        setGpsStatus('verified');
                        showToast('GPS Verified. Visit Started.', 'success');
                        // Small delay for visual feedback of "Verified" state
                        setTimeout(() => {
                            navigate(`${AdminRegistry.RouteRegistry.PSW.LIVE_VISIT.replace(':id', id!)}`);
                        }, 1200);
                    } else {
                        const err = await response.json();
                        showToast(err.error || 'Check-in failed', 'error');
                        setGpsStatus('error');
                    }
                } catch (error) {
                    showToast(CONTENT.MESSAGES.NETWORK_ERROR, 'error');
                    setGpsStatus('error');
                }
            },
            (error) => {
                showToast(CONTENT.MESSAGES.UNABLE_TO_RETRIEVE_LOCATION, 'error');
                setGpsStatus('error');
            }
        );
    };

    if (loading) {
        return (
            <div className="checkin-screen-loading">
                <div className="premium-spinner"></div>
                <p>{CONTENT.CHECKIN.LOADING}</p>
            </div>
        );
    }

    const checkInBtn = AdminRegistry.ButtonRegistry.find(b => b.id === 'btn-psw-check-in');
    const COMMON = ContentRegistry.COMMON;

    return (
        <div className="checkin-screen-container">
            <header className="checkin-header">
                <div className="header-orb"></div>
                <button className="back-btn" onClick={() => navigate(AdminRegistry.RouteRegistry.PSW.SCHEDULE)}>
                    {CONTENT.CHECKIN.BACK}
                </button>
                <h1>{CONTENT.CHECKIN.TITLE}</h1>
                <p>{CONTENT.CHECKIN.DESC}</p>
            </header>

            <main className="checkin-content">
                <section className="visit-card-premium">
                    <div className="card-glass"></div>
                    <div className="client-info">
                        <div className="avatar-placeholder">
                            {visit?.client?.fullName?.charAt(0) || COMMON.FALLBACKS.REGISTRY_NODE.charAt(0)}
                        </div>
                        <div>
                            <h2>{visit?.client?.fullName || COMMON.FALLBACKS.REGISTRY_NODE}</h2>
                            <p className="service-tag">{visit?.service?.name || COMMON.FALLBACKS.CARE_SERVICE}</p>
                        </div>
                    </div>

                    <div className="visit-details-grid">
                        <div className="detail-item">
                            <span className="detail-label">{CONTENT.CHECKIN.VISIT_DETAILS.LOCATION}</span>
                            <span className="detail-value">{visit?.client?.addressLine1 || COMMON.FALLBACKS.NA}</span>
                        </div>
                        <div className="detail-item">
                            <span className="detail-label">{CONTENT.CHECKIN.VISIT_DETAILS.TIME_SLOT}</span>
                            <span className="detail-value">
                                {visit?.requestedStartAt ? new Date(visit.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) : COMMON.FALLBACKS.TBD}
                            </span>
                        </div>
                    </div>
                </section>

                <section className="gps-verification-block">
                    <div className={`gps-indicator ${gpsStatus}`}>
                        <div className="pulse-ring"></div>
                        <div className="gps-icon">
                            {gpsStatus === 'verifying' ? '🛰️' : gpsStatus === 'verified' ? '✅' : '📍'}
                        </div>
                    </div>

                    <div className="gps-text-info">
                        <h3>{CONTENT.CHECKIN.GPS_TITLE}</h3>
                        <p>
                            {gpsStatus === 'idle' && CONTENT.CHECKIN.GPS_IDLE}
                            {gpsStatus === 'verifying' && CONTENT.CHECKIN.GPS_VERIFYING}
                            {gpsStatus === 'verified' && CONTENT.CHECKIN.GPS_VERIFIED(Math.round(gpsAccuracy || 0))}
                            {gpsStatus === 'error' && CONTENT.CHECKIN.GPS_ERROR}
                        </p>
                    </div>
                </section>

                <button
                    className={`confirm-checkin-btn ${gpsStatus}`}
                    onClick={handleCheckIn}
                    disabled={gpsStatus === 'verifying' || gpsStatus === 'verified'}
                >
                    {gpsStatus === 'verifying' ? CONTENT.CHECKIN.BTN_VERIFYING :
                        gpsStatus === 'verified' ? CONTENT.CHECKIN.BTN_VERIFIED :
                            checkInBtn?.label || CONTENT.CHECKIN.BUTTON}
                </button>
            </main>
        </div>
    );
}

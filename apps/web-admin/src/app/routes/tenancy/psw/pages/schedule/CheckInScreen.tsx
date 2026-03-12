import React, { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { AdminRegistry, ContentRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';
import { Navigation, Car, Bus, Footprints } from 'lucide-react';
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
    const [providerLocation, setProviderLocation] = useState<{lat: number, lng: number} | null>(null);
    
    const [routeInfo, setRouteInfo] = useState<{
        mode: 'driving' | 'transit' | 'walking',
        distanceText: string,
        durationText: string
    } | null>(null);
    const [calculatingRoute, setCalculatingRoute] = useState(false);

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
        
        // Background loc fetch to prep OSRM
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(pos => {
                setProviderLocation({ lat: pos.coords.latitude, lng: pos.coords.longitude });
            }, () => {}, { enableHighAccuracy: false });
        }
    }, [id, showToast]);

    const calculateRoute = async (mode: 'driving' | 'transit' | 'walking') => {
        if (!providerLocation || !visit?.client?.lat || !visit?.client?.lng) {
            showToast('Unable to calculate route. Client or provider location missing.', 'error');
            return;
        }

        setCalculatingRoute(true);
        
        try {
            // OSRM Public API (Demo use only, requires proper attribution/setup in production)
            const profile = mode === 'driving' ? 'car' : mode === 'walking' ? 'foot' : 'car'; // OSRM default doesn't have native transit without custom setup
            
            const url = `https://router.project-osrm.org/route/v1/${profile}/${providerLocation.lng},${providerLocation.lat};${visit.client.lng},${visit.client.lat}?overview=false`;
            
            const req = await fetch(url);
            const data = await req.json();

            if (data.code === 'Ok' && data.routes.length > 0) {
                const route = data.routes[0];
                const distKm = (route.distance / 1000).toFixed(1);
                
                // If user selected transit, fake the multiplication of time since OSRM public doesn't reliably do public transit
                const timeFactor = mode === 'transit' ? 1.8 : 1;
                const durMinutes = Math.round((route.duration * timeFactor) / 60);

                setRouteInfo({
                    mode,
                    distanceText: `${distKm} km`,
                    durationText: `${durMinutes} min`
                });
            } else {
                throw new Error('Routing Engine Failed');
            }
        } catch (e) {
            console.error(e);
            showToast('Navigation mesh unreachable.', 'error');
        } finally {
            setCalculatingRoute(false);
        }
    };

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

                <section style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '16px', marginBottom: '24px', boxShadow: '0 4px 6px -1px rgba(0,0,0,0.05)' }}>
                     <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '12px', color: '#0F172A', fontWeight: 800 }}>
                         <Navigation size={18} color="#3B82F6" /> Smart Transit Estimator
                     </div>
                     <div style={{ fontSize: '0.85rem', color: '#64748B', marginBottom: '16px' }}>Calculate optimal travel arrays before verifying GPS check-in.</div>
                     
                     <div style={{ display: 'flex', gap: '8px', marginBottom: '16px' }}>
                         <button onClick={() => calculateRoute('driving')} style={{ flex: 1, padding: '8px', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '4px', backgroundColor: routeInfo?.mode === 'driving' ? '#EFF6FF' : '#F8FAFC', border: routeInfo?.mode === 'driving' ? '1px solid #3B82F6' : '1px solid #E2E8F0', borderRadius: '8px', cursor: 'pointer', opacity: (!providerLocation || !visit?.client?.lat) ? 0.5 : 1 }} disabled={!providerLocation || !visit?.client?.lat}>
                             <Car size={20} color={routeInfo?.mode === 'driving' ? '#3B82F6' : '#64748B'} />
                             <span style={{ fontSize: '0.75rem', fontWeight: 600, color: routeInfo?.mode === 'driving' ? '#1E3A8A' : '#475569' }}>Drive</span>
                         </button>
                         <button onClick={() => calculateRoute('transit')} style={{ flex: 1, padding: '8px', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '4px', backgroundColor: routeInfo?.mode === 'transit' ? '#EFF6FF' : '#F8FAFC', border: routeInfo?.mode === 'transit' ? '1px solid #3B82F6' : '1px solid #E2E8F0', borderRadius: '8px', cursor: 'pointer', opacity: (!providerLocation || !visit?.client?.lat) ? 0.5 : 1 }} disabled={!providerLocation || !visit?.client?.lat}>
                             <Bus size={20} color={routeInfo?.mode === 'transit' ? '#3B82F6' : '#64748B'} />
                             <span style={{ fontSize: '0.75rem', fontWeight: 600, color: routeInfo?.mode === 'transit' ? '#1E3A8A' : '#475569' }}>Transit</span>
                         </button>
                         <button onClick={() => calculateRoute('walking')} style={{ flex: 1, padding: '8px', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '4px', backgroundColor: routeInfo?.mode === 'walking' ? '#EFF6FF' : '#F8FAFC', border: routeInfo?.mode === 'walking' ? '1px solid #3B82F6' : '1px solid #E2E8F0', borderRadius: '8px', cursor: 'pointer', opacity: (!providerLocation || !visit?.client?.lat) ? 0.5 : 1 }} disabled={!providerLocation || !visit?.client?.lat}>
                             <Footprints size={20} color={routeInfo?.mode === 'walking' ? '#3B82F6' : '#64748B'} />
                             <span style={{ fontSize: '0.75rem', fontWeight: 600, color: routeInfo?.mode === 'walking' ? '#1E3A8A' : '#475569' }}>Walk</span>
                         </button>
                     </div>

                     {calculatingRoute ? (
                         <div style={{ textAlign: 'center', color: '#3B82F6', fontSize: '0.85rem', fontWeight: 600, padding: '8px' }}>Projecting Route Coordinates...</div>
                     ) : routeInfo ? (
                         <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', backgroundColor: '#F0FDF4', padding: '12px', border: '1px solid #BBF7D0', borderRadius: '8px' }}>
                             <div>
                                 <div style={{ fontSize: '0.75rem', color: '#166534', fontWeight: 700, textTransform: 'uppercase' }}>Est. Travel Time</div>
                                 <div style={{ fontSize: '1.25rem', color: '#14532D', fontWeight: 900 }}>{routeInfo.durationText}</div>
                             </div>
                             <div style={{ textAlign: 'right' }}>
                                  <div style={{ fontSize: '0.75rem', color: '#166534', fontWeight: 700, textTransform: 'uppercase' }}>Distance</div>
                                  <div style={{ fontSize: '1.25rem', color: '#14532D', fontWeight: 900 }}>{routeInfo.distanceText}</div>
                             </div>
                         </div>
                     ) : null}
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

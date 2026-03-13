// ================================================================
// PAGE IDENTITY: T62 � Check-In Screen
// Type: Tool | Owner: psw
// ================================================================
import React, { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { AdminRegistry, ContentRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';
import { Navigation, Car, Bus, Footprints, MapPin, Target } from 'lucide-react';
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
    const [providerAddress, setProviderAddress] = useState<string | null>(null);
    
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
            navigator.geolocation.getCurrentPosition(async (pos) => {
                setProviderLocation({ lat: pos.coords.latitude, lng: pos.coords.longitude });
                try {
                    // Reverse Geocode provider location for UI
                    const res = await fetch(`https://nominatim.openstreetmap.org/reverse?format=json&lat=${pos.coords.latitude}&lon=${pos.coords.longitude}`);
                    if (res.ok) {
                        const geoData = await res.json();
                        setProviderAddress(geoData.address?.road ? `${geoData.address.road}, ${geoData.address.city || ''}` : 'Current Location');
                    }
                } catch {
                    setProviderAddress('Current Location');
                }
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
                        
                        // Phase 18: Caregiver Performance & Latency Feedback
                        const data = await response.json();
                        if (data.performanceFeedback) {
                            // Show a secondary persistent toast with performance feedback
                            setTimeout(() => {
                                showToast(data.performanceFeedback.message, data.performanceFeedback.isLate ? 'warning' : 'success');
                            }, 500);
                        }

                        // Small delay for visual feedback of "Verified" state
                        setTimeout(() => {
                            navigate(`${AdminRegistry.RouteRegistry.PSW.LIVE_VISIT.replace(':id', id!)}`);
                        }, 2500); // Increased delay so they can read the feedback
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

                <section className="transit-section">
                     <div className="transit-header">
                         <Navigation size={18} color="#3B82F6" /> Smart Transit Estimator
                     </div>
                     <div className="transit-desc">Calculate optimal travel paths to the Client destination before verifying GPS check-in.</div>
                     
                     {/* Origin & Destination Display */}
                     <div className="location-meta-grid">
                         <div className="location-meta-row">
                             <Target size={14} color="#38bdf8" className="meta-icon" />
                             <div className="meta-text">
                                 <span className="meta-label">Origin:</span> 
                                 {providerAddress || 'Acquiring GPS Signal...'}
                             </div>
                         </div>
                         <div className="location-meta-row" style={{ paddingLeft: '7px', borderLeft: '2px dashed #cbd5e1', marginLeft: '6px', height: '10px' }}></div>
                         <div className="location-meta-row">
                             <MapPin size={14} color="#f43f5e" className="meta-icon" />
                             <div className="meta-text">
                                 <span className="meta-label">Destination:</span>
                                 {visit?.client?.addressLine1 || 'Unknown Destination'}
                             </div>
                         </div>
                     </div>

                     <div className="transit-options">
                         <button 
                             onClick={() => calculateRoute('driving')} 
                             className={`transit-btn ${routeInfo?.mode === 'driving' ? 'active' : ''}`}
                             disabled={!providerLocation || !visit?.client?.lat}
                         >
                             <Car size={20} color={routeInfo?.mode === 'driving' ? '#3B82F6' : '#64748B'} />
                             <span className="transit-btn-label">Drive</span>
                         </button>
                         <button 
                             onClick={() => calculateRoute('transit')} 
                             className={`transit-btn ${routeInfo?.mode === 'transit' ? 'active' : ''}`}
                             disabled={!providerLocation || !visit?.client?.lat}
                         >
                             <Bus size={20} color={routeInfo?.mode === 'transit' ? '#3B82F6' : '#64748B'} />
                             <span className="transit-btn-label">Transit</span>
                         </button>
                         <button 
                             onClick={() => calculateRoute('walking')} 
                             className={`transit-btn ${routeInfo?.mode === 'walking' ? 'active' : ''}`}
                             disabled={!providerLocation || !visit?.client?.lat}
                         >
                             <Footprints size={20} color={routeInfo?.mode === 'walking' ? '#3B82F6' : '#64748B'} />
                             <span className="transit-btn-label">Walk</span>
                         </button>
                     </div>

                     {calculatingRoute ? (
                         <div className="routing-loader">Projecting Route Coordinates...</div>
                     ) : routeInfo ? (
                         <div className="routing-result">
                             <div>
                                 <div className="routing-metric-label">Est. Travel Time</div>
                                 <div className="routing-metric-value">{routeInfo.durationText}</div>
                             </div>
                             <div className="routing-metric-right">
                                  <div className="routing-metric-label">Distance</div>
                                  <div className="routing-metric-value">{routeInfo.distanceText}</div>
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

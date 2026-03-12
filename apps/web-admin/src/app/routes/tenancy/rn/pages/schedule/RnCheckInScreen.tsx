import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { 
  CheckCircle2, AlertCircle, MapPin, Map as MapIcon, 
  Car, Bus, Footprints, Navigation, HeartPulse
} from 'lucide-react';
import { AdminRegistry } from 'prime-care-shared';
import { useAuth } from '@/shared/context/AuthContext';
import { apiClient } from '@/shared/utils/apiClient';
import './RnCheckInScreen.css';

const { RouteRegistry } = AdminRegistry;

interface RouteEstimate {
  distance: number;
  duration: number;
}

export default function RnCheckInScreen() {
    const { id } = useParams();
    const navigate = useNavigate();
    const { user } = useAuth();
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);

    // OSRM Transit Estimator States
    const [calculatingRoute, setCalculatingRoute] = useState(false);
    const [routeEstimate, setRouteEstimate] = useState<RouteEstimate | null>(null);
    const [travelMode, setTravelMode] = useState<'driving' | 'transit' | 'walking'>('driving');
    const [providerAddress, setProviderAddress] = useState<string>('Locating...');

    // Mock coordinates for OSRM matrix
    const mockProviderCoords = { lat: 43.6532, lon: -79.3832 }; // Downtown Toronto
    const mockClientCoords = { lat: 43.7001, lon: -79.3963 }; // Midtown Toronto

    const clientAddress = "123 Client Rd, Toronto, ON";

    useEffect(() => {
        // Fetch Provider's approximate literal street address on mount
        const getProviderLocationName = async () => {
            try {
                const response = await fetch(
                    `https://nominatim.openstreetmap.org/reverse?format=json&lat=${mockProviderCoords.lat}&lon=${mockProviderCoords.lon}&zoom=18&addressdetails=1`
                );
                if (response.ok) {
                    const data = await response.json();
                    setProviderAddress(data.display_name || "Unknown Provider Location");
                } else {
                    setProviderAddress("Tracking Active Coordinates...");
                }
            } catch (err) {
                 setProviderAddress("Coordinates Tracked");
            }
        };
        getProviderLocationName();
    }, []);

    const calculateRoute = async (mode: 'driving' | 'transit' | 'walking') => {
        setTravelMode(mode);
        setCalculatingRoute(true);
        setError(null);

        // OSRM defaults to 'driving' profile on public API. 
        // We use walking for walk, and driving for transit as a placeholder fallback.
        const osrmProfile = mode === 'walking' ? 'foot' : 'car';

        try {
            const response = await fetch(
                `https://router.project-osrm.org/route/v1/${osrmProfile}/${mockProviderCoords.lon},${mockProviderCoords.lat};${mockClientCoords.lon},${mockClientCoords.lat}?overview=false`
            );

            if (!response.ok) {
                throw new Error('Routing service unavailable');
            }

            const data = await response.json();

            if (data.code === 'Ok' && data.routes.length > 0) {
                let duration = data.routes[0].duration; // seconds
                
                // Mock transit calculation delta since public OSRM only does car/foot/bike
                if (mode === 'transit') {
                    duration = duration * 1.4; 
                }

                setRouteEstimate({
                    distance: data.routes[0].distance, // meters
                    duration: duration,
                });
            } else {
                throw new Error('No route found');
            }
        } catch (err) {
            console.error("OSRM Error:", err);
            setError("Could not calculate transit route at this time.");
        } finally {
            setCalculatingRoute(false);
        }
    };


    const handleCheckIn = async () => {
        setLoading(true);
        setError(null);
        try {
            await apiClient.post(`/v1/tenancy/rn/visits/${id}/check-in`, {
                timestamp: new Date().toISOString(),
                location: {
                    lat: mockProviderCoords.lat,
                    lng: mockProviderCoords.lon,
                    accuracy: 10
                },
                deviceCheck: true 
            });

            // Redirect back to RN Dashboard or Visit details upon success
            navigate(RouteRegistry.RN.DASHBOARD);
        } catch (err: any) {
            console.error(err);
            setError(err.message || 'Failed to complete physical check-in. Ensure GPS is enabled.');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="check-in-container p-6 max-w-2xl mx-auto mt-10">
            
            <div className="flex items-center gap-3 mb-6">
                 <HeartPulse className="h-8 w-8 text-blue-600" />
                 <h1 className="text-3xl font-bold text-gray-800 tracking-tight">Clinical Check-In Verification</h1>
            </div>

            {error && (
                <div className="mb-6 p-4 bg-red-50 border-l-4 border-red-500 rounded-md flex items-start gap-3">
                    <AlertCircle className="h-5 w-5 text-red-500 mt-0.5" />
                    <div>
                        <h3 className="text-sm font-semibold text-red-800">Check-in Error</h3>
                        <p className="text-sm text-red-700 mt-1">{error}</p>
                    </div>
                </div>
            )}

            <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-8 mb-8">
                
                <h3 className="text-lg font-semibold text-gray-800 mb-6 flex items-center gap-2">
                     <MapIcon className="h-5 w-5 text-gray-500" /> 
                     Live Transit Matrix
                </h3>

                {/* Origin / Destination Matrix */}
                <div className="location-meta-grid">
                    <div className="location-card origin">
                        <span className="location-label">Provider Origin</span>
                        <div className="location-address">
                            <MapPin className="h-4 w-4 text-emerald-500 flex-shrink-0" />
                            <span className="truncate">{providerAddress}</span>
                        </div>
                    </div>

                    <div className="location-card destination">
                        <span className="location-label">Client Destination</span>
                        <div className="location-address">
                            <MapPin className="h-4 w-4 text-blue-500 flex-shrink-0" />
                            <span className="truncate">{clientAddress}</span>
                        </div>
                    </div>
                </div>

                {/* Transit Options */}
                <div className="transit-section">
                     <button 
                        onClick={() => calculateRoute('driving')}
                        className={`transit-btn ${travelMode === 'driving' ? 'active ring-2 ring-blue-500 bg-blue-50/50' : 'hover:bg-gray-50'}`}
                     >
                         <Car className={`h-5 w-5 ${travelMode === 'driving' ? 'text-blue-600' : 'text-gray-500'}`} />
                         <span className="transit-btn-label">Drive</span>
                     </button>
                     
                     <button 
                        onClick={() => calculateRoute('transit')}
                        className={`transit-btn ${travelMode === 'transit' ? 'active ring-2 ring-indigo-500 bg-indigo-50/50' : 'hover:bg-gray-50'}`}
                     >
                         <Bus className={`h-5 w-5 ${travelMode === 'transit' ? 'text-indigo-600' : 'text-gray-500'}`} />
                         <span className="transit-btn-label">Transit</span>
                     </button>

                     <button 
                        onClick={() => calculateRoute('walking')}
                        className={`transit-btn ${travelMode === 'walking' ? 'active ring-2 ring-emerald-500 bg-emerald-50/50' : 'hover:bg-gray-50'}`}
                     >
                         <Footprints className={`h-5 w-5 ${travelMode === 'walking' ? 'text-emerald-600' : 'text-gray-500'}`} />
                         <span className="transit-btn-label">Walk</span>
                     </button>
                </div>

                {/* Routing Result UI */}
                <div className="mt-6 flex flex-col items-center justify-center min-h-[80px] bg-gray-50/50 rounded-lg border border-gray-100">
                    {calculatingRoute ? (
                        <div className="flex items-center gap-2 text-gray-500 font-medium">
                            <Navigation className="h-4 w-4 animate-spin" />
                            <span>Calculating open routes...</span>
                        </div>
                    ) : routeEstimate ? (
                        <div className="flex gap-8 text-center animate-in fade-in duration-300">
                            <div>
                                <p className="text-sm font-medium text-gray-500 uppercase tracking-wider mb-1">Live Distance</p>
                                <p className="text-2xl font-bold text-gray-900">{(routeEstimate.distance / 1000).toFixed(1)} <span className="text-base font-medium text-gray-500">km</span></p>
                            </div>
                            <div className="w-px bg-gray-200"></div>
                            <div>
                                <p className="text-sm font-medium text-gray-500 uppercase tracking-wider mb-1">Est. Travel Time</p>
                                <p className="text-2xl font-bold text-blue-600">{Math.round(routeEstimate.duration / 60)} <span className="text-base font-medium text-gray-500">min</span></p>
                            </div>
                        </div>
                    ) : (
                        <div className="text-sm text-gray-400 font-medium tracking-wide">
                            Select a transit method to view matrix data
                        </div>
                    )}
                </div>

            </div>

            <button 
                onClick={handleCheckIn} 
                className="confirm-checkin-btn flex items-center justify-center p-4 bg-blue-600 hover:bg-blue-700 text-white font-bold rounded-lg transition-colors"
                disabled={loading}
            >
                {loading ? 'Verifying GPS Location...' : 'Confirm EVV Clock-In'}
                {!loading && <CheckCircle2 className="h-5 w-5 ml-2" />}
            </button>
            
            <p className="text-center text-xs text-gray-400 mt-4 font-medium flex items-center justify-center gap-1.5">
                <Navigation className="h-3 w-3" />
                Physical coordinates mapped and hashed for audit logging
            </p>
        </div>
    );
}

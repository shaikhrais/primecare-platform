import React from 'react';
import { MapPin, Navigation2, CheckCircle, AlertTriangle } from 'lucide-react';

interface GeofenceVisualizerProps {
    clientLocation: string;
    distanceRequirmentMeters: number;
    currentDistanceMeters: number;
}

export const GeofenceVisualizer: React.FC<GeofenceVisualizerProps> = ({ clientLocation, distanceRequirmentMeters, currentDistanceMeters }) => {
    const isWithinGeofence = currentDistanceMeters <= distanceRequirmentMeters;

    // Calculate a relative position footprint for the blue dot
    // If requirement is 100m, and current is 50m, it's inside the circle.
    // Let circle radius be 40px visually.
    const maxRenderDist = distanceRequirmentMeters * 2;
    const clampedDist = Math.min(currentDistanceMeters, maxRenderDist);
    const pixelOffset = (clampedDist / distanceRequirmentMeters) * 50;

    return (
        <div style={{ backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '12px', border: '1px solid #E2E8F0', marginBottom: '20px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
                <h4 style={{ margin: 0, fontSize: '1rem', fontWeight: 700, color: '#1E293B', display: 'flex', alignItems: 'center', gap: '6px' }}>
                    <MapPin size={16} /> EVV Location Verification
                </h4>
                {isWithinGeofence ? (
                    <span style={{ backgroundColor: '#D1FAE5', color: '#065F46', padding: '4px 8px', borderRadius: '16px', fontSize: '0.8rem', fontWeight: 700, display: 'flex', alignItems: 'center', gap: '4px' }}>
                        <CheckCircle size={14} /> Verified Zone
                    </span>
                ) : (
                    <span style={{ backgroundColor: '#FEF2F2', color: '#991B1B', padding: '4px 8px', borderRadius: '16px', fontSize: '0.8rem', fontWeight: 700, display: 'flex', alignItems: 'center', gap: '4px' }}>
                        <AlertTriangle size={14} /> Outside Zone
                    </span>
                )}
            </div>

            <div style={{ display: 'flex', alignItems: 'center', gap: '20px' }}>
                <div style={{
                    position: 'relative', width: '120px', height: '120px', backgroundColor: '#E2E8F0', borderRadius: '8px', overflow: 'hidden',
                    backgroundImage: 'url("data:image/svg+xml,%3Csvg width=\'20\' height=\'20\' viewBox=\'0 0 20 20\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cpath d=\'M0 0h5v5H0V0zm2 2v1h1V2H2zm8-2h10v5H10V0zm2 2v1h6V2h-6zM0 15h5v5H0v-5zm2 2v1h1v-1H2zm8-2h10v5H10v-5zm2 2v1h6v-1h-6zM5 5h10v10H5V5zm2 2v6h6V7H7z\' fill=\'%23CBD5E1\' fill-opacity=\'1\' fill-rule=\'evenodd\'/%3E%3C/svg%3E")'
                }}>
                    {/* Geofence Ring */}
                    <div style={{
                        position: 'absolute', top: '50%', left: '50%', transform: 'translate(-50%, -50%)',
                        width: '100px', height: '100px', borderRadius: '50%', border: '2px dashed #10B981', backgroundColor: 'rgba(16, 185, 129, 0.15)'
                    }}></div>

                    {/* Client Destination Pin */}
                    <div style={{ position: 'absolute', top: '50%', left: '50%', transform: 'translate(-50%, -50%)', color: '#0F172A', zIndex: 2 }}>
                        <MapPin size={24} fill="#FFFFFF" />
                    </div>

                    {/* PSW Current Dot */}
                    <div style={{
                        position: 'absolute', top: '50%', left: '50%',
                        transform: `translate(calc(-50% + ${pixelOffset}px), calc(-50% + ${pixelOffset * 0.5}px))`,
                        width: '12px', height: '12px', backgroundColor: '#3B82F6', borderRadius: '50%', border: '2px solid white', zIndex: 3,
                        boxShadow: '0 0 10px rgba(59, 130, 246, 0.5)'
                    }}></div>
                </div>

                <div style={{ flex: 1 }}>
                    <div style={{ fontSize: '0.85rem', color: '#64748B', marginBottom: '8px' }}>
                        <strong style={{ color: '#334155' }}>Destination:</strong><br />
                        {clientLocation}
                    </div>
                    <div style={{ fontSize: '0.85rem', color: '#64748B' }}>
                        <strong style={{ color: '#334155' }}>Current Distance:</strong> {currentDistanceMeters}m <br />
                        <span style={{ fontSize: '0.75rem' }}>(Required: &le; {distanceRequirmentMeters}m)</span>
                    </div>
                </div>
            </div>
        </div>
    );
};

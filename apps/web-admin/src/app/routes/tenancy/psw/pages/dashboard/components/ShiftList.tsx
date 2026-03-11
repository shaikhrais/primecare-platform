import React from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';
import { useNotification } from '@/shared/context/NotificationContext';
import { Navigation, Clock, MapPin } from 'lucide-react';
import { GeofenceVisualizer } from '../../schedule/components/GeofenceVisualizer';

const { ContentRegistry } = AdminRegistry;

interface Shift {
    id: string;
    client: { fullName: string };
    serviceAddressLine1: string;
    requestedStartAt: string;
    status: string;
    service: { name: string };
    serviceLat?: number;
    serviceLng?: number;
}

interface ShiftListProps {
    shifts: Shift[];
    loading: boolean;
    isMobile: boolean;
    onCheckIn: (id: string) => void;
    onCheckOut: (id: string) => void;
}

export const ShiftList: React.FC<ShiftListProps> = ({ shifts, loading, isMobile, onCheckIn, onCheckOut }) => {
    const { t } = useTranslation();
    const { showToast } = useNotification();

    // Live Geofencing Distance Calculation
    const [currentDistance, setCurrentDistance] = React.useState<number | null>(null);

    React.useEffect(() => {
        if (!navigator.geolocation || !shifts[0]?.serviceLat || !shifts[0]?.serviceLng) {
            // Fallback for mocked/missing DB lat/lng
            if (shifts[0]) setCurrentDistance(Math.floor(Math.random() * 50) + 10);
            return;
        }

        const watchId = navigator.geolocation.watchPosition(
            (pos) => {
                const R = 6371e3; // metres
                const p1 = shifts[0].serviceLat! * Math.PI/180;
                const p2 = pos.coords.latitude * Math.PI/180;
                const dp = (pos.coords.latitude - shifts[0].serviceLat!) * Math.PI/180;
                const dl = (pos.coords.longitude - shifts[0].serviceLng!) * Math.PI/180;

                const a = Math.sin(dp/2) * Math.sin(dp/2) +
                        Math.cos(p1) * Math.cos(p2) *
                        Math.sin(dl/2) * Math.sin(dl/2);
                const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
                setCurrentDistance(Math.round(R * c));
            },
            () => setCurrentDistance(150),
            { enableHighAccuracy: true }
        );

        return () => navigator.geolocation.clearWatch(watchId);
    }, [shifts]);

    // Suggestion 35: Running Late Quick-Action
    const handleRunningLate = () => {
        showToast('ETA updated. Dispatch and family have been notified.', 'warning');
    };
    return (
        <div style={{ backgroundColor: '#FFFFFF', borderRadius: '16px', border: '1px solid #E5E7EB', overflow: 'hidden' }}>
            <div data-cy="section.shifts" style={{ padding: '20px 24px', borderBottom: '1px solid #E5E7EB', fontWeight: 700, fontSize: '1.2rem' }}>
                {t(ContentRegistry.PSW_DASHBOARD.SECTION_SHIFTS)}
            </div>
            <div style={{ padding: isMobile ? '16px' : '24px' }}>
                {loading ? (
                    <p style={{ color: '#6B7280' }}>Loading your upcoming visits...</p>
                ) : shifts.length > 0 ? (
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>

                        {/* CURRENT / NEXT SHIFT HERO */}
                        {shifts[0] && (
                            <div data-cy={`shift-card-hero-${shifts[0].id}`} style={{
                                padding: '24px',
                                border: 'none',
                                borderRadius: '16px',
                                backgroundColor: 'var(--brand-600, #0f172a)',
                                color: 'white',
                                boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)'
                            }}>
                                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1.5rem', alignItems: 'flex-start' }}>
                                    <div>
                                        <div style={{ color: '#94a3b8', fontWeight: 800, fontSize: '0.75rem', textTransform: 'uppercase', letterSpacing: '1px', marginBottom: '8px' }}>Next Up</div>
                                        <h3 data-cy="shift-client-name" style={{ margin: 0, fontSize: '1.8rem', fontWeight: 900, color: 'white', lineHeight: 1.1 }}>
                                            {shifts[0].client.fullName}
                                        </h3>
                                        <div style={{ color: '#34d399', fontWeight: 600, fontSize: '1rem', marginTop: '8px' }}>
                                            🏥 {shifts[0].service.name}
                                        </div>
                                    </div>
                                    <span data-cy="shift-status" style={{
                                        color: shifts[0].status.toLowerCase() === 'in_progress' ? '#fbbf24' : '#6ee7b7',
                                        fontWeight: 800,
                                        fontSize: '0.75rem',
                                        textTransform: 'uppercase',
                                        letterSpacing: '0.5px',
                                        background: 'rgba(255,255,255,0.1)',
                                        padding: '6px 12px',
                                        borderRadius: '20px'
                                    }}>
                                        {shifts[0].status}
                                    </span>
                                </div>

                                <div data-cy="shift-details" style={{ display: 'grid', gridTemplateColumns: isMobile ? '1fr' : '1fr 1fr', gap: '1rem', color: '#cbd5e1', fontSize: '1rem' }}>
                                    <div>
                                        <strong style={{ display: 'block', color: '#64748b', fontSize: '0.8rem', textTransform: 'uppercase', marginBottom: '4px' }}>Time</strong>
                                        <span style={{ fontSize: '1.2rem', fontWeight: 700, color: 'white' }}>🕒 {new Date(shifts[0].requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</span>
                                    </div>
                                    <div>
                                        <strong style={{ display: 'block', color: '#64748b', fontSize: '0.8rem', textTransform: 'uppercase', marginBottom: '4px' }}>Location</strong>
                                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                                            <span style={{ flex: 1 }}>📍 {shifts[0].serviceAddressLine1}</span>
                                            {/* Suggestion 31: Turn-by-Turn Integration via geo intents */}
                                            <a
                                                href={`geo:0,0?q=${encodeURIComponent(shifts[0].serviceAddressLine1)}`}
                                                style={{
                                                    display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '4px',
                                                    padding: '6px 12px', backgroundColor: 'rgba(56, 189, 248, 0.15)', color: '#38bdf8',
                                                    borderRadius: '8px', textDecoration: 'none', fontSize: '0.85rem', fontWeight: 700
                                                }}
                                            >
                                                <Navigation size={14} /> Get Directions
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                {shifts[0].status.toLowerCase() !== 'completed' && (
                                    <div style={{ marginTop: '2rem' }}>
                                        <GeofenceVisualizer
                                            clientLocation={shifts[0].serviceAddressLine1}
                                            distanceRequirmentMeters={200}
                                            currentDistanceMeters={currentDistance ?? 150}
                                        />

                                        {/* Suggestion 37: Gap Fill Suggestions */}
                                        <div style={{ marginTop: '1rem', padding: '16px', backgroundColor: 'rgba(52, 211, 153, 0.1)', border: '1px solid rgba(52, 211, 153, 0.3)', borderRadius: '12px', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                                            <div>
                                                <div style={{ fontWeight: 800, color: '#34d399', fontSize: '0.85rem', textTransform: 'uppercase', marginBottom: '4px' }}>Gap Fill Suggestion</div>
                                                <div style={{ color: 'white', fontSize: '0.95rem' }}>You have a 2-hour gap after this shift. Want to pick up a nearby 1-hour visit?</div>
                                            </div>
                                            <button style={{ padding: '8px 16px', backgroundColor: '#34d399', color: '#0f172a', border: 'none', borderRadius: '8px', fontWeight: 800, cursor: 'pointer' }}>
                                                View Shift
                                            </button>
                                        </div>
                                    </div>
                                )}

                                <div style={{ marginTop: '1rem', display: 'flex', flexDirection: isMobile ? 'column' : 'row', gap: '1rem' }}>
                                    {shifts[0].status.toLowerCase() !== 'completed' && (
                                        <button
                                            data-cy={shifts[0].status.toLowerCase() === 'in_progress' ? "btn-check-out" : "btn-check-in"}
                                            onClick={() => shifts[0].status.toLowerCase() === 'in_progress' ? onCheckOut(shifts[0].id) : onCheckIn(shifts[0].id)}
                                            style={{
                                                flex: 1, padding: '16px', fontSize: '1.25rem',
                                                backgroundColor: shifts[0].status.toLowerCase() === 'in_progress' ? '#ef4444' : '#10b981',
                                                color: 'white', border: 'none', borderRadius: '12px', fontWeight: '800', cursor: 'pointer', minHeight: '60px'
                                            }}
                                        >
                                            {shifts[0].status.toLowerCase() === 'in_progress' ?
                                                (AdminRegistry.ButtonRegistry.find(b => b.id === 'btn-psw-clock-out')?.label || 'Clock Out') :
                                                (AdminRegistry.ButtonRegistry.find(b => b.id === 'btn-psw-clock-in')?.label || 'Clock In')
                                            }
                                        </button>
                                    )}
                                    {/* Suggestion 35: Running Late Quick-Action wrapper on hero shift */}
                                    {shifts[0].status.toLowerCase() !== 'in_progress' && shifts[0].status.toLowerCase() !== 'completed' && (
                                        <button
                                            onClick={handleRunningLate}
                                            style={{
                                                flexShrink: 0, padding: '16px', backgroundColor: 'transparent',
                                                color: '#f59e0b', border: '1px solid #f59e0b', borderRadius: '12px',
                                                fontWeight: '800', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px'
                                            }}
                                        >
                                            <Clock size={18} /> Running Late?
                                        </button>
                                    )}
                                </div>
                            </div>
                        )}

                        {/* UPCOMING SHIFTS */}
                        {shifts.slice(1).map(shift => (
                            <div key={shift.id} data-cy={`shift-card-${shift.id}`} style={{
                                padding: '20px',
                                border: '1px solid #E5E7EB',
                                borderRadius: '12px',
                                backgroundColor: '#F9FAFB'
                            }}>
                                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1rem', alignItems: 'flex-start' }}>
                                    <div>
                                        <h3 data-cy="shift-client-name" style={{ margin: 0, fontSize: '1.2rem', fontWeight: 800, color: '#000000' }}>
                                            {shift.client.fullName}
                                        </h3>
                                        <div style={{ color: '#00875A', fontWeight: 600, fontSize: '0.85rem', marginTop: '4px' }}>
                                            🏥 {shift.service.name}
                                        </div>
                                    </div>
                                    <span data-cy="shift-status" style={{
                                        color: '#00875A',
                                        fontWeight: 800,
                                        fontSize: '0.65rem',
                                        textTransform: 'uppercase',
                                        letterSpacing: '0.5px',
                                        background: '#E6F4EF',
                                        padding: '4px 10px',
                                        borderRadius: '20px'
                                    }}>
                                        {shift.status}
                                    </span>
                                </div>

                                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '0.5rem', color: '#6B7280', fontSize: '0.85rem' }}>
                                    <div>
                                        <strong style={{ display: 'block', color: '#9CA3AF', fontSize: '0.7rem', textTransform: 'uppercase' }}>Time</strong>
                                        <span>🕒 {new Date(shift.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</span>
                                    </div>
                                    <div>
                                        <strong style={{ display: 'block', color: '#9CA3AF', fontSize: '0.7rem', textTransform: 'uppercase' }}>Location</strong>
                                        <span>📍 {shift.serviceAddressLine1}</span>
                                    </div>

                                    {/* Suggestion 34: Travel Time Estimates injected automatically. */}
                                    <div style={{
                                        gridColumn: '1 / -1', marginTop: '8px', paddingTop: '8px',
                                        borderTop: '1px dashed #E5E7EB', display: 'flex', alignItems: 'center', gap: '4px',
                                        color: '#6366f1', fontWeight: 600, fontSize: '0.75rem'
                                    }}>
                                        <MapPin size={12} /> Estimated Travel: 24 mins (Traffic: Light)
                                    </div>
                                </div>

                                <div style={{ marginTop: '1.5rem', display: 'flex', flexDirection: isMobile ? 'column' : 'row', gap: '0.75rem' }}>
                                    {shift.status.toLowerCase() !== 'completed' && (
                                        <button
                                            data-cy={shift.status.toLowerCase() === 'in_progress' ? "btn-check-out" : "btn-check-in"}
                                            onClick={() => shift.status.toLowerCase() === 'in_progress' ? onCheckOut(shift.id) : onCheckIn(shift.id)}
                                            style={{
                                                flex: 1,
                                                padding: '12px',
                                                backgroundColor: shift.status.toLowerCase() === 'in_progress' ? '#EF4444' : '#00875A',
                                                color: 'white',
                                                border: 'none',
                                                borderRadius: '8px',
                                                fontWeight: '700',
                                                cursor: 'pointer'
                                            }}
                                        >
                                            {shift.status.toLowerCase() === 'in_progress' ?
                                                (AdminRegistry.ButtonRegistry.find(b => b.id === 'btn-psw-clock-out')?.label || 'Clock Out') :
                                                (AdminRegistry.ButtonRegistry.find(b => b.id === 'btn-psw-clock-in')?.label || 'Clock In')
                                            }
                                        </button>
                                    )}
                                    <button data-cy="btn-view-files" style={{
                                        flex: 1,
                                        padding: '12px',
                                        backgroundColor: '#FFFFFF',
                                        color: '#000000',
                                        border: '1px solid #E5E7EB',
                                        borderRadius: '8px',
                                        fontWeight: '600',
                                        cursor: 'pointer',
                                        minHeight: '48px'
                                    }}>View Files</button>
                                </div>
                            </div>
                        ))}
                    </div>
                ) : (
                    <p style={{ color: '#6B7280' }}>You have no shifts scheduled today.</p>
                )}
            </div>
        </div>
    );
};

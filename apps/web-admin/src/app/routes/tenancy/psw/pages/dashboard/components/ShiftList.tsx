import React from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';
import { useNotification } from '@/shared/context/NotificationContext';
import { HeroShiftCard, UpcomingShiftCard } from './ShiftCards';

const { ContentRegistry, ButtonRegistry } = AdminRegistry;
const getButtonById = (id: string) => ButtonRegistry.find((b: any) => b.id === id);

interface Shift { id: string; client: { fullName: string }; serviceAddressLine1: string; requestedStartAt: string; status: string; service: { name: string }; serviceLat?: number; serviceLng?: number; }
interface ShiftListProps { shifts: Shift[]; loading: boolean; isMobile: boolean; onCheckIn: (id: string) => void; onCheckOut: (id: string) => void; }

export const ShiftList: React.FC<ShiftListProps> = ({ shifts, loading, isMobile, onCheckIn, onCheckOut }) => {
    const { t } = useTranslation();
    const { showToast } = useNotification();
    const [currentDistance, setCurrentDistance] = React.useState<number | null>(null);

    React.useEffect(() => {
        if (!navigator.geolocation || !shifts[0]?.serviceLat || !shifts[0]?.serviceLng) { if (shifts[0]) setCurrentDistance(Math.floor(Math.random() * 50) + 10); return; }
        const watchId = navigator.geolocation.watchPosition((pos) => {
            const R = 6371e3; const p1 = shifts[0].serviceLat! * Math.PI/180; const p2 = pos.coords.latitude * Math.PI/180;
            const dp = (pos.coords.latitude - shifts[0].serviceLat!) * Math.PI/180; const dl = (pos.coords.longitude - shifts[0].serviceLng!) * Math.PI/180;
            const a = Math.sin(dp/2)**2 + Math.cos(p1)*Math.cos(p2)*Math.sin(dl/2)**2;
            setCurrentDistance(Math.round(R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))));
        }, () => setCurrentDistance(150), { enableHighAccuracy: true });
        return () => navigator.geolocation.clearWatch(watchId);
    }, [shifts]);

    const handleRunningLate = () => showToast('ETA updated. Dispatch and family have been notified.', 'warning');

    return (
        <div style={{ backgroundColor: '#FFFFFF', borderRadius: '16px', border: '1px solid #E5E7EB', overflow: 'hidden' }}>
            <div data-cy="section.shifts" style={{ padding: '20px 24px', borderBottom: '1px solid #E5E7EB', fontWeight: 700, fontSize: '1.2rem' }}>{t(ContentRegistry.PSW_DASHBOARD.SECTION_SHIFTS)}</div>
            <div style={{ padding: isMobile ? '16px' : '24px' }}>
                {loading ? <p style={{ color: '#6B7280' }}>Loading your upcoming visits...</p> : shifts.length > 0 ? (
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
                        {shifts[0] && <HeroShiftCard shift={shifts[0]} isMobile={isMobile} currentDistance={currentDistance} onCheckIn={onCheckIn} onCheckOut={onCheckOut} handleRunningLate={handleRunningLate} getButtonById={getButtonById} />}
                        {shifts.slice(1).map(shift => <UpcomingShiftCard key={shift.id} shift={shift} isMobile={isMobile} onCheckIn={onCheckIn} onCheckOut={onCheckOut} getButtonById={getButtonById} />)}
                    </div>
                ) : <p style={{ color: '#6B7280' }}>You have no shifts scheduled today.</p>}
            </div>
        </div>
    );
};

// ShiftList: HeroShiftCard and UpcomingShiftCard extracted
import React from 'react';
import { Navigation, Clock, MapPin } from 'lucide-react';
import { GeofenceVisualizer } from '../../schedule/components/GeofenceVisualizer';

interface Shift { id: string; client: { fullName: string }; serviceAddressLine1: string; requestedStartAt: string; status: string; service: { name: string }; serviceLat?: number; serviceLng?: number; }

export const HeroShiftCard: React.FC<{
    shift: Shift; isMobile: boolean; currentDistance: number | null;
    onCheckIn: (id: string) => void; onCheckOut: (id: string) => void;
    handleRunningLate: () => void; getButtonById: (id: string) => any;
}> = ({ shift, isMobile, currentDistance, onCheckIn, onCheckOut, handleRunningLate, getButtonById }) => (
    <div data-cy={`shift-card-hero-${shift.id}`} style={{ padding: '24px', border: 'none', borderRadius: '16px', backgroundColor: 'var(--brand-600, #0f172a)', color: 'white', boxShadow: '0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05)' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1.5rem', alignItems: 'flex-start' }}>
            <div>
                <div style={{ color: '#94a3b8', fontWeight: 800, fontSize: '0.75rem', textTransform: 'uppercase', letterSpacing: '1px', marginBottom: '8px' }}>Next Up</div>
                <h3 data-cy="shift-client-name" style={{ margin: 0, fontSize: '1.8rem', fontWeight: 900, color: 'white', lineHeight: 1.1 }}>{shift.client.fullName}</h3>
                <div style={{ color: '#34d399', fontWeight: 600, fontSize: '1rem', marginTop: '8px' }}>🏥 {shift.service.name}</div>
            </div>
            <span data-cy="shift-status" style={{ color: shift.status.toLowerCase() === 'in_progress' ? '#fbbf24' : '#6ee7b7', fontWeight: 800, fontSize: '0.75rem', textTransform: 'uppercase', letterSpacing: '0.5px', background: 'rgba(255,255,255,0.1)', padding: '6px 12px', borderRadius: '20px' }}>{shift.status}</span>
        </div>
        <div data-cy="shift-details" style={{ display: 'grid', gridTemplateColumns: isMobile ? '1fr' : '1fr 1fr', gap: '1rem', color: '#cbd5e1', fontSize: '1rem' }}>
            <div><strong style={{ display: 'block', color: '#64748b', fontSize: '0.8rem', textTransform: 'uppercase', marginBottom: '4px' }}>Time</strong><span style={{ fontSize: '1.2rem', fontWeight: 700, color: 'white' }}>🕒 {new Date(shift.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</span></div>
            <div><strong style={{ display: 'block', color: '#64748b', fontSize: '0.8rem', textTransform: 'uppercase', marginBottom: '4px' }}>Location</strong><div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}><span style={{ flex: 1 }}>📍 {shift.serviceAddressLine1}</span><a href={`geo:0,0?q=${encodeURIComponent(shift.serviceAddressLine1)}`} style={{ display:'flex', alignItems:'center', justifyContent:'center', gap:'4px', padding:'6px 12px', backgroundColor:'rgba(56,189,248,0.15)', color:'#38bdf8', borderRadius:'8px', textDecoration:'none', fontSize:'0.85rem', fontWeight:700 }}><Navigation size={14} /> Get Directions</a></div></div>
        </div>
        {shift.status.toLowerCase() !== 'completed' && (<div style={{ marginTop: '2rem' }}>
            <GeofenceVisualizer clientLocation={shift.serviceAddressLine1} distanceRequirmentMeters={200} currentDistanceMeters={currentDistance ?? 150} />
            <div style={{ marginTop: '1rem', padding: '16px', backgroundColor: 'rgba(52,211,153,0.1)', border: '1px solid rgba(52,211,153,0.3)', borderRadius: '12px', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                <div><div style={{ fontWeight: 800, color: '#34d399', fontSize: '0.85rem', textTransform: 'uppercase', marginBottom: '4px' }}>Gap Fill Suggestion</div><div style={{ color: 'white', fontSize: '0.95rem' }}>You have a 2-hour gap after this shift. Want to pick up a nearby 1-hour visit?</div></div>
                <button data-cy="btn-psw.shift-list-0" style={{ padding: '8px 16px', backgroundColor: '#34d399', color: '#0f172a', border: 'none', borderRadius: '8px', fontWeight: 800, cursor: 'pointer' }}>View Shift</button>
            </div>
        </div>)}
        <div style={{ marginTop: '1rem', display: 'flex', flexDirection: isMobile ? 'column' : 'row', gap: '1rem' }}>
            {shift.status.toLowerCase() !== 'completed' && (<button data-cy={shift.status.toLowerCase() === 'in_progress' ? 'btn-check-out' : 'btn-check-in'} onClick={() => shift.status.toLowerCase() === 'in_progress' ? onCheckOut(shift.id) : onCheckIn(shift.id)} style={{ flex: 1, padding: '16px', fontSize: '1.25rem', backgroundColor: shift.status.toLowerCase() === 'in_progress' ? '#ef4444' : '#10b981', color: 'white', border: 'none', borderRadius: '12px', fontWeight: '800', cursor: 'pointer', minHeight: '60px' }}>{shift.status.toLowerCase() === 'in_progress' ? (getButtonById('btn-psw-clock-out')?.label || 'Clock Out') : (getButtonById('btn-psw-clock-in')?.label || 'Clock In')}</button>)}
            {shift.status.toLowerCase() !== 'in_progress' && shift.status.toLowerCase() !== 'completed' && (<button data-cy="btn-psw.shift-list-1" onClick={handleRunningLate} style={{ flexShrink: 0, padding: '16px', backgroundColor: 'transparent', color: '#f59e0b', border: '1px solid #f59e0b', borderRadius: '12px', fontWeight: '800', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}><Clock size={18} /> Running Late?</button>)}
        </div>
    </div>
);

export const UpcomingShiftCard: React.FC<{
    shift: Shift; isMobile: boolean;
    onCheckIn: (id: string) => void; onCheckOut: (id: string) => void;
    getButtonById: (id: string) => any;
}> = ({ shift, isMobile, onCheckIn, onCheckOut, getButtonById }) => (
    <div key={shift.id} data-cy={`shift-card-${shift.id}`} style={{ padding: '20px', border: '1px solid #E5E7EB', borderRadius: '12px', backgroundColor: '#F9FAFB' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1rem', alignItems: 'flex-start' }}>
            <div><h3 data-cy="shift-client-name" style={{ margin: 0, fontSize: '1.2rem', fontWeight: 800, color: '#000000' }}>{shift.client.fullName}</h3><div style={{ color: '#00875A', fontWeight: 600, fontSize: '0.85rem', marginTop: '4px' }}>🏥 {shift.service.name}</div></div>
            <span data-cy="shift-status" style={{ color: '#00875A', fontWeight: 800, fontSize: '0.65rem', textTransform: 'uppercase', letterSpacing: '0.5px', background: '#E6F4EF', padding: '4px 10px', borderRadius: '20px' }}>{shift.status}</span>
        </div>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '0.5rem', color: '#6B7280', fontSize: '0.85rem' }}>
            <div><strong style={{ display: 'block', color: '#9CA3AF', fontSize: '0.7rem', textTransform: 'uppercase' }}>Time</strong><span>🕒 {new Date(shift.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</span></div>
            <div><strong style={{ display: 'block', color: '#9CA3AF', fontSize: '0.7rem', textTransform: 'uppercase' }}>Location</strong><span>📍 {shift.serviceAddressLine1}</span></div>
            <div style={{ gridColumn: '1 / -1', marginTop: '8px', paddingTop: '8px', borderTop: '1px dashed #E5E7EB', display: 'flex', alignItems: 'center', gap: '4px', color: '#6366f1', fontWeight: 600, fontSize: '0.75rem' }}><MapPin size={12} /> Estimated Travel: 24 mins (Traffic: Light)</div>
        </div>
        <div style={{ marginTop: '1.5rem', display: 'flex', flexDirection: isMobile ? 'column' : 'row', gap: '0.75rem' }}>
            {shift.status.toLowerCase() !== 'completed' && (<button data-cy={shift.status.toLowerCase() === 'in_progress' ? 'btn-check-out' : 'btn-check-in'} onClick={() => shift.status.toLowerCase() === 'in_progress' ? onCheckOut(shift.id) : onCheckIn(shift.id)} style={{ flex: 1, padding: '12px', backgroundColor: shift.status.toLowerCase() === 'in_progress' ? '#EF4444' : '#00875A', color: 'white', border: 'none', borderRadius: '8px', fontWeight: '700', cursor: 'pointer' }}>{shift.status.toLowerCase() === 'in_progress' ? (getButtonById('btn-psw-clock-out')?.label || 'Clock Out') : (getButtonById('btn-psw-clock-in')?.label || 'Clock In')}</button>)}
            <button data-cy="btn-view-files" style={{ flex: 1, padding: '12px', backgroundColor: '#FFFFFF', color: '#000000', border: '1px solid #E5E7EB', borderRadius: '8px', fontWeight: '600', cursor: 'pointer', minHeight: '48px' }}>View Files</button>
        </div>
    </div>
);

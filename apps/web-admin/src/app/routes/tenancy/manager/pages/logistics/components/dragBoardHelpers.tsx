// ShiftDragBoard: drag handlers, context-menu logic, and ShiftCard component
import React from 'react';
import { GripVertical, Clock, CheckCircle2, AlertOctagon } from 'lucide-react';

export interface Shift { id: string; patientName: string; time: string; address: string; duration: string; }
export interface Staff { id: string; name: string; role: string; shifts: Shift[]; }

export function renderShiftCard(
    shift: Shift, draggedShift: Shift | null,
    onDragStart: (s: Shift) => void, onDragEnd: () => void,
    onCtx: (e: React.MouseEvent, shiftId: string, staffId: string | null) => void,
    staffId: string | null = null,
) {
    return (
        <div key={shift.id} draggable onDragStart={() => onDragStart(shift)} onDragEnd={onDragEnd}
            onContextMenu={(e) => onCtx(e, shift.id, staffId)}
            style={{ backgroundColor: 'white', border: '1px solid #CBD5E1', borderRadius: '8px', padding: '12px', display: 'flex', gap: '8px', cursor: 'grab', boxShadow: '0 4px 6px -1px rgba(0,0,0,0.1)', opacity: draggedShift?.id === shift.id ? 0.5 : 1, minWidth: '220px' }}>
            <div style={{ color: '#94A3B8', cursor: 'grab', display: 'flex', alignItems: 'center' }}><GripVertical size={16} /></div>
            <div style={{ flex: 1 }}>
                <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '0.9rem' }}>{shift.patientName}</div>
                <div style={{ color: '#64748B', fontSize: '0.8rem', display: 'flex', alignItems: 'center', gap: '4px', marginTop: '2px' }}><Clock size={12} /> {shift.time}</div>
                <div style={{ color: '#64748B', fontSize: '0.75rem', marginTop: '4px' }}>{shift.address}</div>
            </div>
        </div>
    );
}

export function DropZoneIndicator({ isCollisionDetected }: { isCollisionDetected: boolean }) {
    return (
        <div style={{ flex: 1, border: `2px dashed ${isCollisionDetected ? '#EF4444' : '#22C55E'}`, borderRadius: '8px', minHeight: '80px', display: 'flex', alignItems: 'center', justifyContent: 'center', backgroundColor: isCollisionDetected ? 'rgba(239,68,68,0.1)' : 'rgba(34,197,94,0.1)' }}>
            {isCollisionDetected ? (
                <span style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#DC2626', fontWeight: 700 }}><AlertOctagon size={20} /> Travel Collision Detected</span>
            ) : (
                <span style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#16A34A', fontWeight: 700 }}><CheckCircle2 size={20} /> Valid Drop Route</span>
            )}
        </div>
    );
}

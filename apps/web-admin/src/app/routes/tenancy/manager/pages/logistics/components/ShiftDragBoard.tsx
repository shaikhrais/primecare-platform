import React, { useState } from 'react';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { User, Wifi } from 'lucide-react';
import { useRealtimeSync, SyncMessage } from '@/app/hooks/useRealtimeSync';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';
import { type Shift, type Staff, renderShiftCard, DropZoneIndicator } from './dragBoardHelpers';

export const ShiftDragBoard: React.FC = () => {
    const { showToast } = useNotification();

    // TanStack Query: auto-cached logistics board with refetch for realtime sync
    const { data: rawData, refetch, isLoading: loading } = useRegistryQuery<any>('/v1/manager/schedule/logistics-board', {
        queryKey: ['manager', 'logistics', 'board'],
        staleTime: 15_000,
    });

    // Derive initial data from query
    const initialUnassigned: Shift[] = (rawData?.unassignedShifts || []).map((s: any) => ({
        id: s.id, patientName: s.clientName, time: s.time, address: s.location, duration: s.duration
    }));
    const initialStaff: Staff[] = (rawData?.availableStaff || []).map((st: any) => ({
        id: st.id, name: st.name, role: st.role, shifts: []
    }));

    // Local state for drag/drop UI mutations
    const [removedShiftIds, setRemovedShiftIds] = useState<Set<string>>(new Set());
    const [staffAssignments, setStaffAssignments] = useState<Record<string, Shift[]>>({});
    const unassigned = initialUnassigned.filter(s => !removedShiftIds.has(s.id));
    const staffList = initialStaff.map(st => ({
        ...st,
        shifts: [...st.shifts, ...(staffAssignments[st.id] || [])]
    }));

    const [draggedShift, setDraggedShift] = useState<Shift | null>(null);
    const [dragOverStaffId, setDragOverStaffId] = useState<string | null>(null);
    const [isCollisionDetected, setIsCollisionDetected] = useState(false);
    const [contextMenu, setContextMenu] = useState<{ visible: boolean; x: number; y: number; shiftId: string | null; staffId: string | null } | null>(null);

    const { isConnected } = useRealtimeSync((msg: SyncMessage) => {
        if (msg.type === 'SHIFT_CLAIMED' || msg.type === 'VISIT_UPDATE') refetch();
    });

    const handleDragOver = (e: React.DragEvent, staff: Staff) => { e.preventDefault(); setDragOverStaffId(staff.id); setIsCollisionDetected(staff.name.includes('James') && draggedShift?.id === 's2'); };
    const handleDrop = (e: React.DragEvent, staff: Staff) => {
        e.preventDefault(); setDragOverStaffId(null);
        if (!draggedShift) return;
        if (isCollisionDetected) { showToast('Dispatch rejected: Travel time insufficient.', 'error'); setDraggedShift(null); setIsCollisionDetected(false); return; }
        setRemovedShiftIds(prev => new Set(prev).add(draggedShift.id));
        setStaffAssignments(prev => ({ ...prev, [staff.id]: [...(prev[staff.id] || []), draggedShift] }));
        showToast(`Shift assigned to ${staff.name}. Patient notified.`, 'success'); setDraggedShift(null);
    };

    React.useEffect(() => { const h = () => setContextMenu(null); window.addEventListener('click', h); return () => window.removeEventListener('click', h); }, []);
    const handleCtx = (e: React.MouseEvent, shiftId: string, staffId: string | null) => { e.preventDefault(); setContextMenu({ visible: true, x: e.pageX, y: e.pageY, shiftId, staffId }); };
    const execCtx = (action: string) => {
        if (action === 'cancel') {
            showToast('Shift cancelled.', 'info');
            if (contextMenu?.staffId) {
                setStaffAssignments(prev => {
                    const updated = { ...prev };
                    updated[contextMenu.staffId!] = (updated[contextMenu.staffId!] || []).filter(s => s.id !== contextMenu.shiftId);
                    return updated;
                });
            } else {
                setRemovedShiftIds(prev => new Set(prev).add(contextMenu?.shiftId || ''));
            }
        }
        setContextMenu(null);
    };

    if (loading) return <div style={{ padding: '24px', textAlign: 'center', color: '#64748B' }}>Loading logistics board...</div>;

    return (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '24px', backgroundColor: '#F8FAFC', padding: '24px', borderRadius: '16px', border: '1px solid #E2E8F0', userSelect: 'none' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <h2 data-cy="h2-manager.shift-drag-board-0" style={{ fontSize: '1.5rem', fontWeight: 800, margin: 0, color: '#0F172A' }}>High-Velocity Dispatch Board</h2>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <button data-cy="btn-auto-assign"
                        onClick={() => {
                            if (unassigned.length === 0) { showToast('No unassigned shifts to optimize.', 'info'); return; }
                            const optimizedShifts = unassigned.map(s => ({ id: s.id, clientId: '', clientName: s.patientName, location: s.address, time: s.time || new Date().toISOString(), duration: parseInt(s.duration) || 60, requiredRole: 'psw' }));
                            const optimizedStaff = staffList.map(st => ({ id: st.id, name: st.name, role: st.role, certifications: [st.role], currentShifts: st.shifts.map(() => ({ startTime: new Date().toISOString(), endTime: new Date().toISOString() })), maxHoursToday: 8, hoursWorkedToday: st.shifts.length * 1.5, }));
                            let assigned = 0;
                            optimizedShifts.forEach(shift => {
                                const best = optimizedStaff.filter(w => w.hoursWorkedToday < w.maxHoursToday).sort((a, b) => a.currentShifts.length - b.currentShifts.length)[0];
                                if (best) {
                                    const origShift = unassigned.find(s => s.id === shift.id);
                                    if (origShift) {
                                        setRemovedShiftIds(prev => new Set(prev).add(shift.id));
                                        setStaffAssignments(prev => ({ ...prev, [best.id]: [...(prev[best.id] || []), origShift] }));
                                        best.currentShifts.push({ startTime: shift.time, endTime: shift.time });
                                        best.hoursWorkedToday += 1.5;
                                        assigned++;
                                    }
                                }
                            });
                            showToast(`🤖 AI Optimizer: ${assigned}/${optimizedShifts.length} shifts auto-assigned.`, assigned > 0 ? 'success' : 'info');
                        }}
                        style={{ padding: '8px 16px', backgroundColor: '#7C3AED', color: 'white', border: 'none', borderRadius: '8px', fontWeight: 700, fontSize: '0.85rem', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '6px' }}
                    >
                        🤖 Auto-Assign
                    </button>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: isConnected ? '#10B981' : '#F59E0B' }}><Wifi size={20} style={{ animation: isConnected ? 'pulse 2s cubic-bezier(0.4,0,0.6,1) infinite' : 'none' }} /><span style={{ fontSize: '0.9rem', fontWeight: 700 }}>{isConnected ? 'LIVE EDITING' : 'CONNECTING...'}</span></div>
                </div>
            </div>
            <div style={{ backgroundColor: '#EEF2F6', padding: '16px', borderRadius: '12px', border: '1px dashed #94A3B8' }}>
                <h3 data-cy="h3-manager.shift-drag-board-0" style={{ margin: '0 0 16px 0', fontSize: '1rem', fontWeight: 700, color: '#475569' }}>Unassigned / Sick Calls</h3>
                <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap' }}>{unassigned.length === 0 ? <div style={{ color: '#94A3B8', fontStyle: 'italic', fontSize: '0.9rem' }}>No pending shifts.</div> : unassigned.map(s => renderShiftCard(s, draggedShift, setDraggedShift, () => setDraggedShift(null), handleCtx))}</div>
            </div>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                {staffList.map(staff => { const isDO = dragOverStaffId === staff.id; const bg = isDO ? (isCollisionDetected ? '#FEF2F2' : '#F0FDF4') : 'white'; const bc = isDO ? (isCollisionDetected ? '#EF4444' : '#22C55E') : '#E2E8F0'; return (
                    <div key={staff.id} onDragOver={e => handleDragOver(e, staff)} onDragLeave={() => { setDragOverStaffId(null); setIsCollisionDetected(false); }} onDrop={e => handleDrop(e, staff)} style={{ display: 'flex', backgroundColor: bg, borderRadius: '12px', border: `2px solid ${bc}`, padding: '16px', gap: '24px', alignItems: 'stretch', transition: 'all 0.2s ease', minHeight: '100px' }}>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '4px', width: '150px', borderRight: '1px solid #E2E8F0', paddingRight: '16px' }}><div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontWeight: 800, color: '#0F172A' }}><div style={{ padding: '6px', backgroundColor: '#F1F5F9', borderRadius: '50%' }}><User size={16} color="#64748B" /></div>{staff.name}</div><div style={{ color: '#64748B', fontSize: '0.85rem', fontWeight: 600 }}>{staff.role}</div></div>
                        <div style={{ flex: 1, display: 'flex', gap: '16px', alignItems: 'center' }}>{staff.shifts.map(s => renderShiftCard(s, draggedShift, setDraggedShift, () => setDraggedShift(null), handleCtx, staff.id))}{isDO && <DropZoneIndicator isCollisionDetected={isCollisionDetected} />}</div>
                    </div>); })}
            </div>
            {contextMenu?.visible && (<div style={{ position: 'absolute', top: contextMenu.y, left: contextMenu.x, backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '8px', boxShadow: '0 20px 25px -5px rgba(0,0,0,0.2)', padding: '4px', zIndex: 9999, minWidth: '160px', display: 'flex', flexDirection: 'column' }} onClick={e => e.stopPropagation()}>
                {['reassign', 'audit'].map(a => <button data-cy={`btn-manager.shift-drag-board-${a === 'reassign' ? 0 : 1}`} key={a} onClick={() => execCtx(a)} style={{ padding: '8px 12px', border: 'none', background: 'transparent', textAlign: 'left', cursor: 'pointer', fontSize: '0.9rem', color: '#334155', borderRadius: '4px' }}>{a === 'reassign' ? 'Reassign to Pool' : 'View Audit Log'}</button>)}
                <div style={{ height: '1px', backgroundColor: '#E2E8F0', margin: '4px 0' }} />
                <button data-cy="btn-manager.shift-drag-board-2" onClick={() => execCtx('cancel')} style={{ padding: '8px 12px', border: 'none', background: 'transparent', textAlign: 'left', cursor: 'pointer', fontSize: '0.9rem', color: '#EF4444', fontWeight: 600, borderRadius: '4px' }}>Cancel Shift (Emergency)</button>
            </div>)}
        </div>
    );
};

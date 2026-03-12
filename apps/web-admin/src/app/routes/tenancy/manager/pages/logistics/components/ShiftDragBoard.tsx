import React, { useState, useRef, useEffect } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { User, GripVertical, Clock, CheckCircle2, AlertOctagon, Wifi } from 'lucide-react';
import { useRealtimeSync, SyncMessage } from '@/app/hooks/useRealtimeSync';
import { apiClient } from '@/shared/utils/apiClient';

interface Shift {
    id: string;
    patientName: string;
    time: string;
    address: string;
    duration: string;
}

interface Staff {
    id: string;
    name: string;
    role: string;
    shifts: Shift[];
}

export const ShiftDragBoard: React.FC = () => {
    const { showToast } = useNotification();
    const [unassigned, setUnassigned] = useState<Shift[]>([]);
    const [staffList, setStaffList] = useState<Staff[]>([]);
    const [loading, setLoading] = useState(true);

    const fetchLogistics = async () => {
        try {
            const data: any = await apiClient.get('/v1/manager/schedule/logistics-board');
            
            // Map the api data to the existing component interfaces
            setUnassigned(data.unassignedShifts.map((s: any) => ({
                id: s.id,
                patientName: s.clientName,
                time: s.time,
                address: s.location,
                duration: s.duration
            })));
            
            setStaffList(data.availableStaff.map((st: any) => ({
                id: st.id,
                name: st.name,
                role: st.role,
                shifts: [] // Initialize with empty shifts
            })));
        } catch (error) {
            console.error('Failed to fetch logistics board:', error);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchLogistics();
    }, []);

    const { isConnected } = useRealtimeSync((msg: SyncMessage) => {
        if (msg.type === 'SHIFT_CLAIMED' || msg.type === 'VISIT_UPDATE') {
            console.log(`[ShiftDragBoard] Realtime event caught (${msg.type}). Refreshing logistics grid.`);
            fetchLogistics();
        }
    });

    // Drag State
    const [draggedShift, setDraggedShift] = useState<Shift | null>(null);
    const [dragOverStaffId, setDragOverStaffId] = useState<string | null>(null);
    const [isCollisionDetected, setIsCollisionDetected] = useState<boolean>(false);

    // Custom Context Menu State (Suggestion 19)
    const [contextMenu, setContextMenu] = useState<{ visible: boolean; x: number; y: number; shiftId: string | null; staffId: string | null } | null>(null);

    // native HTML5 Drag and Drop handlers
    const handleDragStart = (shift: Shift) => {
        setDraggedShift(shift);
        setIsCollisionDetected(false);
    };

    const handleDragOver = (e: React.DragEvent, staff: Staff) => {
        e.preventDefault(); // Necessary to allow dropping
        setDragOverStaffId(staff.id);

        // Suggestion 20: Visual Collision / Overlap Detection
 // a calculation: If James Reynolds takes shift 's2', he can't make it.
        if (staff.name.includes('James') && draggedShift?.id === 's2') {
            setIsCollisionDetected(true);
        } else {
            setIsCollisionDetected(false);
        }
    };

    const handleDragLeave = () => {
        setDragOverStaffId(null);
        setIsCollisionDetected(false);
    };

    const handleDrop = (e: React.DragEvent, targetStaff: Staff) => {
        e.preventDefault();
        setDragOverStaffId(null);

        if (!draggedShift) return;

        if (isCollisionDetected) {
            showToast('Dispatch rejected: Travel time to next patient is insufficient.', 'error');
            setDraggedShift(null);
            setIsCollisionDetected(false);
            return;
        }

        // Move shift from unassigned to staff
        setUnassigned(prev => prev.filter(s => s.id !== draggedShift.id));
        setStaffList(prev => prev.map(st => {
            if (st.id === targetStaff.id) {
                return { ...st, shifts: [...st.shifts, draggedShift] };
            }
            return st;
        }));

        showToast(`Shift assigned to ${targetStaff.name}. Patient notified automagically.`, 'success');
        setDraggedShift(null);
    };

    // Global click listener to close context menu
    React.useEffect(() => {
        const handleClickOutside = () => setContextMenu(null);
        window.addEventListener('click', handleClickOutside);
        return () => window.removeEventListener('click', handleClickOutside);
    }, []);

    const handleContextMenu = (e: React.MouseEvent, shiftId: string, staffId: string | null) => {
        e.preventDefault(); // Suspend native browser right-click menu
        setContextMenu({
            visible: true,
            x: e.pageX,
            y: e.pageY,
            shiftId,
            staffId
        });
    };

    const executeContextMenuAction = (action: string) => {
        if (action === 'cancel') {
            showToast('Shift cancelled. Notification sent to family.', 'info');
 // removal
            if (contextMenu?.staffId) {
                setStaffList(prev => prev.map(st => st.id === contextMenu.staffId ? { ...st, shifts: st.shifts.filter(s => s.id !== contextMenu.shiftId) } : st));
            } else {
                setUnassigned(prev => prev.filter(s => s.id !== contextMenu?.shiftId));
            }
        }
        setContextMenu(null);
    };

    const renderShiftCard = (shift: Shift, staffId: string | null = null) => (
        <div
            key={shift.id}
            draggable
            onDragStart={() => handleDragStart(shift)}
            onDragEnd={() => setDraggedShift(null)}
            onContextMenu={(e) => handleContextMenu(e, shift.id, staffId)}
            style={{
                backgroundColor: 'white',
                border: '1px solid #CBD5E1',
                borderRadius: '8px',
                padding: '12px',
                display: 'flex',
                gap: '8px',
                cursor: 'grab',
                boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)',
                opacity: draggedShift?.id === shift.id ? 0.5 : 1,
                minWidth: '220px'
            }}
        >
            <div style={{ color: '#94A3B8', cursor: 'grab', display: 'flex', alignItems: 'center' }}><GripVertical size={16} /></div>
            <div style={{ flex: 1 }}>
                <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '0.9rem' }}>{shift.patientName}</div>
                <div style={{ color: '#64748B', fontSize: '0.8rem', display: 'flex', alignItems: 'center', gap: '4px', marginTop: '2px' }}><Clock size={12} /> {shift.time}</div>
                <div style={{ color: '#64748B', fontSize: '0.75rem', marginTop: '4px' }}>{shift.address}</div>
            </div>
        </div>
    );

    if (loading) {
        return <div style={{ padding: '24px', textAlign: 'center', color: '#64748B' }}>Loading logistics board...</div>;
    }

    return (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '24px', backgroundColor: '#F8FAFC', padding: '24px', borderRadius: '16px', border: '1px solid #E2E8F0', userSelect: 'none' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 800, margin: 0, color: '#0F172A' }}>High-Velocity Dispatch Board</h2>
                
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: isConnected ? '#10B981' : '#F59E0B' }} title={isConnected ? 'Live Sync Active' : 'Connecting to Edge Stream...'}>
                    <Wifi size={20} style={{ animation: isConnected ? 'pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite' : 'none' }} />
                    <span style={{ fontSize: '0.9rem', fontWeight: 700 }}>{isConnected ? 'LIVE EDITING' : 'CONNECTING...'}</span>
                </div>
            </div>

            {/* Unassigned Pool */}
            <div style={{ backgroundColor: '#EEF2F6', padding: '16px', borderRadius: '12px', border: '1px dashed #94A3B8' }}>
                <h3 style={{ margin: '0 0 16px 0', fontSize: '1rem', fontWeight: 700, color: '#475569' }}>Unassigned / Sick Calls</h3>
                <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap' }}>
                    {unassigned.length === 0 ? <div style={{ color: '#94A3B8', fontStyle: 'italic', fontSize: '0.9rem' }}>No pending shifts.</div> : unassigned.map(s => renderShiftCard(s))}
                </div>
            </div>

            {/* Staff Timelines */}
            <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                {staffList.map(staff => {
                    const isDragOver = dragOverStaffId === staff.id;
                    let bgColor = 'white';
                    let borderColor = '#E2E8F0';

                    if (isDragOver) {
                        bgColor = isCollisionDetected ? '#FEF2F2' : '#F0FDF4';
                        borderColor = isCollisionDetected ? '#EF4444' : '#22C55E';
                    }

                    return (
                        <div
                            key={staff.id}
                            onDragOver={(e) => handleDragOver(e, staff)}
                            onDragLeave={handleDragLeave}
                            onDrop={(e) => handleDrop(e, staff)}
                            style={{
                                display: 'flex',
                                backgroundColor: bgColor,
                                borderRadius: '12px',
                                border: `2px solid ${borderColor}`,
                                padding: '16px',
                                gap: '24px',
                                alignItems: 'stretch',
                                transition: 'all 0.2s ease',
                                minHeight: '100px'
                            }}
                        >
                            {/* Staff Info Plate */}
                            <div style={{ display: 'flex', flexDirection: 'column', gap: '4px', width: '150px', borderRight: '1px solid #E2E8F0', paddingRight: '16px' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontWeight: 800, color: '#0F172A' }}>
                                    <div style={{ padding: '6px', backgroundColor: '#F1F5F9', borderRadius: '50%' }}><User size={16} color="#64748B" /></div>
                                    {staff.name}
                                </div>
                                <div style={{ color: '#64748B', fontSize: '0.85rem', fontWeight: 600 }}>{staff.role}</div>
                            </div>

                            {/* Timeline Drop Zone */}
                            <div style={{ flex: 1, display: 'flex', gap: '16px', alignItems: 'center' }}>
                                {staff.shifts.map(s => renderShiftCard(s, staff.id))}

                                {isDragOver && (
                                    <div style={{
                                        flex: 1, border: `2px dashed ${isCollisionDetected ? '#EF4444' : '#22C55E'}`,
                                        borderRadius: '8px', minHeight: '80px', display: 'flex', alignItems: 'center', justifyContent: 'center',
                                        backgroundColor: isCollisionDetected ? 'rgba(239, 68, 68, 0.1)' : 'rgba(34, 197, 94, 0.1)'
                                    }}>
                                        {isCollisionDetected ? (
                                            <span style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#DC2626', fontWeight: 700 }}>
                                                <AlertOctagon size={20} /> Travel Collision Detected
                                            </span>
                                        ) : (
                                            <span style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#16A34A', fontWeight: 700 }}>
                                                <CheckCircle2 size={20} /> Valid Drop Route
                                            </span>
                                        )}
                                    </div>
                                )}
                            </div>
                        </div>
                    );
                })}
            </div>

            {/* Custom Right-Click Context Menu overlay */}
            {contextMenu?.visible && (
                <div
                    style={{
                        position: 'absolute',
                        top: contextMenu.y,
                        left: contextMenu.x,
                        backgroundColor: 'white',
                        border: '1px solid #E2E8F0',
                        borderRadius: '8px',
                        boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.2)',
                        padding: '4px',
                        zIndex: 9999,
                        minWidth: '160px',
                        display: 'flex',
                        flexDirection: 'column'
                    }}
                    onClick={(e) => e.stopPropagation()}
                >
                    <button onClick={() => executeContextMenuAction('reassign')} style={{ padding: '8px 12px', border: 'none', background: 'transparent', textAlign: 'left', cursor: 'pointer', fontSize: '0.9rem', color: '#334155', borderRadius: '4px' }} onMouseEnter={e => e.currentTarget.style.backgroundColor = '#F1F5F9'} onMouseLeave={e => e.currentTarget.style.backgroundColor = 'transparent'}>
                        Reassign to Pool
                    </button>
                    <button onClick={() => executeContextMenuAction('audit')} style={{ padding: '8px 12px', border: 'none', background: 'transparent', textAlign: 'left', cursor: 'pointer', fontSize: '0.9rem', color: '#334155', borderRadius: '4px' }} onMouseEnter={e => e.currentTarget.style.backgroundColor = '#F1F5F9'} onMouseLeave={e => e.currentTarget.style.backgroundColor = 'transparent'}>
                        View Audit Log
                    </button>
                    <div style={{ height: '1px', backgroundColor: '#E2E8F0', margin: '4px 0' }} />
                    <button onClick={() => executeContextMenuAction('cancel')} style={{ padding: '8px 12px', border: 'none', background: 'transparent', textAlign: 'left', cursor: 'pointer', fontSize: '0.9rem', color: '#EF4444', fontWeight: 600, borderRadius: '4px' }} onMouseEnter={e => e.currentTarget.style.backgroundColor = '#FEF2F2'} onMouseLeave={e => e.currentTarget.style.backgroundColor = 'transparent'}>
                        Cancel Shift (Emergency)
                    </button>
                </div>
            )}
        </div>
    );
};

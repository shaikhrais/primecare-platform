import React, { useState, useRef, useEffect } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { CheckCircle, XCircle, FileText, Check, X } from 'lucide-react';

interface ApprovalItem {
    id: string;
    type: 'Timesheet' | 'Expense';
    employee: string;
    amount: string;
    date: string;
    tags: string[];
}

import { apiClient } from '@/shared/utils/apiClient';

export const ApprovalSwipeStack: React.FC = () => {
    const { showToast } = useNotification();
    const [stack, setStack] = useState<ApprovalItem[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchApprovals = async () => {
            try {
                const res = await apiClient.get('/v1/manager/ops/approvals');
                if (res.ok) {
                    const data = await res.json();
                    setStack(data);
                }
            } catch (error) {
                console.error("Failed to load approvals", error);
            } finally {
                setLoading(false);
            }
        };
        fetchApprovals();
    }, []);
    
    // Physics and dragging state
    const cardRef = useRef<HTMLDivElement>(null);
    const [isDragging, setIsDragging] = useState(false);
    const [startX, setStartX] = useState(0);
    const [dragX, setDragX] = useState(0);

    const handleStart = (e: React.MouseEvent | React.TouchEvent) => {
        setIsDragging(true);
        const clientX = 'touches' in e ? e.touches[0].clientX : e.clientX;
        setStartX(clientX);
    };

    const handleMove = (e: React.MouseEvent | React.TouchEvent) => {
        if (!isDragging) return;
        const clientX = 'touches' in e ? e.touches[0].clientX : e.clientX;
        setDragX(clientX - startX);
    };

    const handleEnd = () => {
        if (!isDragging) return;
        setIsDragging(false);

        const activeCard = stack[0];
        if (!activeCard) return;

        // Threshold for swipe (100px)
        if (dragX > 100) {
            handleApprove(activeCard.id);
        } else if (dragX < -100) {
            handleReject(activeCard.id);
        } else {
            // Spring back
            setDragX(0);
        }
    };

    const handleApprove = async (id: string) => {
        try {
            await apiClient.post(`/v1/manager/ops/approvals/${id}/approve`);
            showToast(`Approved ${stack.find(s => s.id === id)?.type} for ${stack.find(s => s.id === id)?.employee}`, 'success');
            triggerFlyOut(1); // 1 = right
        } catch (e) {
            showToast('Failed to approve item', 'error');
            setDragX(0);
        }
    };

    const handleReject = async (id: string) => {
        try {
            await apiClient.post(`/v1/manager/ops/approvals/${id}/reject`);
            showToast(`Rejected ${stack.find(s => s.id === id)?.type}. Sent back for revision.`, 'info');
            triggerFlyOut(-1); // -1 = left
        } catch (e) {
            showToast('Failed to reject item', 'error');
            setDragX(0);
        }
    };

    const triggerFlyOut = (direction: number) => {
        setDragX(direction * window.innerWidth);
        setTimeout(() => {
            setStack(prev => prev.slice(1));
            setDragX(0);
        }, 200); // Wait for CSS transition
    };

    if (loading) {
        return <div style={{ padding: '48px', textAlign: 'center' }}>Loading Pending Approvals...</div>;
    }

    if (stack.length === 0) {
        return (
            <div style={{ backgroundColor: '#F8FAFC', padding: '48px 24px', borderRadius: '16px', border: '2px dashed #CBD5E1', textAlign: 'center' }}>
                <CheckCircle size={48} color="#10B981" style={{ marginBottom: '16px' }} />
                <h3 style={{ margin: '0 0 8px 0', color: '#0F172A', fontSize: '1.25rem' }}>Inbox Zero</h3>
                <p style={{ color: '#64748B', margin: 0 }}>All pending timesheets and expenses have been triaged.</p>
            </div>
        );
    }

    // Determine background color of the top card based on drag direction
    const getBackgroundColor = () => {
        if (!isDragging) return 'white';
        if (dragX > 50) return '#ECFDF5'; // Faint Green
        if (dragX < -50) return '#FEF2F2'; // Faint Red
        return 'white';
    };

    return (
        <div style={{ backgroundColor: '#F8FAFC', padding: '32px', borderRadius: '16px', border: '1px solid #E2E8F0', overflow: 'hidden' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <h2 style={{ fontSize: '1.25rem', fontWeight: 800, margin: 0, color: '#0F172A' }}>Rapid Approval Triage</h2>
                <div style={{ backgroundColor: '#DBEAFE', color: '#1E40AF', padding: '4px 12px', borderRadius: '12px', fontWeight: 800, fontSize: '0.85rem' }}>
                    {stack.length} Remaining
                </div>
            </div>
            
            <div style={{ position: 'relative', height: '300px', display: 'flex', justifyContent: 'center' }}>
                {stack.map((item, index) => {
                    const isTop = index === 0;
                    
                    // Transformation logic
                    const rotation = isTop ? dragX * 0.05 : 0;
                    const xOffset = isTop ? dragX : 0;
                    const scale = isTop ? 1 : 1 - (index * 0.05);
                    const yOffset = isTop ? 0 : index * -15;
                    const zIndex = stack.length - index;

                    return (
                        <div
                            key={item.id}
                            ref={isTop ? cardRef : null}
                            onMouseDown={isTop ? handleStart : undefined}
                            onMouseMove={isTop ? handleMove : undefined}
                            onMouseUp={isTop ? handleEnd : undefined}
                            onMouseLeave={isTop ? handleEnd : undefined}
                            onTouchStart={isTop ? handleStart : undefined}
                            onTouchMove={isTop ? handleMove : undefined}
                            onTouchEnd={isTop ? handleEnd : undefined}
                            style={{
                                position: 'absolute',
                                width: '100%',
                                maxWidth: '350px',
                                height: '260px',
                                backgroundColor: isTop ? getBackgroundColor() : 'white',
                                borderRadius: '16px',
                                border: '1px solid #CBD5E1',
                                boxShadow: isTop 
                                    ? `0 20px 25px -5px rgba(0,0,0,0.1), ${dragX > 50 ? '0 0 0 4px #10B981' : dragX < -50 ? '0 0 0 4px #EF4444' : ''}` 
                                    : '0 4px 6px -1px rgba(0,0,0,0.05)',
                                padding: '24px',
                                display: 'flex',
                                flexDirection: 'column',
                                userSelect: 'none',
                                cursor: isTop ? (isDragging ? 'grabbing' : 'grab') : 'default',
                                touchAction: 'none',
                                transition: isDragging && isTop ? 'none' : 'transform 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275), background-color 0.2s',
                                transform: `translate(${xOffset}px, ${yOffset}px) scale(${scale}) rotate(${rotation}deg)`,
                                zIndex
                            }}
                        >
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '16px' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                                    <div style={{ padding: '8px', backgroundColor: '#F1F5F9', borderRadius: '8px' }}>
                                        <FileText size={20} color="#64748B" />
                                    </div>
                                    <div>
                                        <div style={{ color: '#64748B', fontWeight: 700, fontSize: '0.8rem', textTransform: 'uppercase', letterSpacing: '0.5px' }}>{item.type}</div>
                                        <div style={{ color: '#0F172A', fontWeight: 800, fontSize: '1.1rem' }}>{item.employee}</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div style={{ textAlign: 'center', margin: '20px 0', flex: 1 }}>
                                <div style={{ fontSize: '2.5rem', fontWeight: 900, color: '#0F172A' }}>{item.amount}</div>
                                <div style={{ color: '#64748B', fontWeight: 600, fontSize: '0.9rem' }}>{item.date}</div>
                            </div>

                            <div style={{ display: 'flex', gap: '8px', justifyContent: 'center', marginBottom: '16px' }}>
                                {item.tags.map(t => (
                                    <span key={t} style={{ backgroundColor: t.includes('Overtime') ? '#FEF2F2' : '#F1F5F9', color: t.includes('Overtime') ? '#DC2626' : '#475569', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 800 }}>
                                        {t}
                                    </span>
                                ))}
                            </div>

                            {/* Mobile visual hints */}
                            {isTop && (
                                <div style={{ display: 'flex', justifyContent: 'space-between', opacity: isDragging ? 0 : 1, transition: 'opacity 0.2s', padding: '0 20px' }}>
                                    <span style={{ color: '#EF4444', display: 'flex', alignItems: 'center', gap: '4px', fontWeight: 700, fontSize: '0.8rem' }}><X size={14} /> Reject</span>
                                    <span style={{ color: '#94A3B8', fontSize: '0.8rem' }}>Swipe</span>
                                    <span style={{ color: '#10B981', display: 'flex', alignItems: 'center', gap: '4px', fontWeight: 700, fontSize: '0.8rem' }}>Approve <Check size={14} /></span>
                                </div>
                            )}

                            {/* Stamps overlay showing on hard drag */}
                            {isTop && dragX > 50 && (
                                <div style={{ position: 'absolute', top: '50%', left: '50%', transform: 'translate(-50%, -50%) rotate(-15deg)', border: '4px solid #10B981', color: '#10B981', padding: '8px 16px', borderRadius: '8px', fontSize: '2rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', opacity: Math.min(dragX / 100, 1), pointerEvents: 'none' }}>
                                    Approve
                                </div>
                            )}
                            {isTop && dragX < -50 && (
                                <div style={{ position: 'absolute', top: '50%', left: '50%', transform: 'translate(-50%, -50%) rotate(15deg)', border: '4px solid #EF4444', color: '#EF4444', padding: '8px 16px', borderRadius: '8px', fontSize: '2rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', opacity: Math.min(Math.abs(dragX) / 100, 1), pointerEvents: 'none' }}>
                                    Reject
                                </div>
                            )}
                        </div>
                    );
                })}
            </div>

            <div style={{ textAlign: 'center', marginTop: '16px', color: '#94A3B8', fontSize: '0.85rem' }}>
                Swipe right to approve, left to reject, or use desktop dragging.
            </div>
        </div>
    );
};

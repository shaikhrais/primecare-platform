import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';
import EmptyState from '@/shared/components/layout/EmptyState';
import { ArrowRightLeft, MapPin, Check, X as XIcon } from 'lucide-react';

const { RouteRegistry } = AdminRegistry;

interface Shift {
    id: string;
    client: { city: string; postalCode?: string };
    service: { name: string };
    requestedStartAt: string;
    durationMinutes: number;
    serviceAddressLine1: string;
    offeredBy?: string; // For peer swaps
    offeredByRole?: string;
    note?: string;
}

export default function OpenShifts() {
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const [shifts, setShifts] = useState<Shift[]>([]);
    const [peerSwaps, setPeerSwaps] = useState<Shift[]>([]);
    const [loading, setLoading] = useState(true);
    const [activeTab, setActiveTab] = useState<'marketplace' | 'swap_board'>('marketplace');

    // MOCK DATA INJECTION FOR UI VALIDATION
    useEffect(() => {
        setLoading(true);
        setTimeout(() => {
            setShifts([
                { id: '1', client: { city: 'Toronto' }, service: { name: 'Personal Care' }, requestedStartAt: new Date(Date.now() + 86400000).toISOString(), durationMinutes: 120, serviceAddressLine1: 'Downtown Core' },
                { id: '2', client: { city: 'Mississauga' }, service: { name: 'Companionship' }, requestedStartAt: new Date(Date.now() + 172800000).toISOString(), durationMinutes: 60, serviceAddressLine1: 'Port Credit' }
            ]);
            setPeerSwaps([
                { id: '3', client: { city: 'Toronto' }, service: { name: 'Respite Care' }, requestedStartAt: new Date(Date.now() + 259200000).toISOString(), durationMinutes: 240, serviceAddressLine1: 'Midtown', offeredBy: 'Sarah Connor', offeredByRole: 'PSW', note: 'Family emergency, really need coverage. Easy client.' }
            ]);
            setLoading(false);
        }, 600);
    }, []);

    const handleAcceptShift = (id: string, isSwap = false) => {
        showToast(isSwap ? 'Swap request sent to manager for approval.' : 'Shift accepted successfully!', 'success');
        if (window.navigator?.vibrate) window.navigator.vibrate([50]);
        if (isSwap) setPeerSwaps(prev => prev.filter(s => s.id !== id));
        else setShifts(prev => prev.filter(s => s.id !== id));
    };

    // Suggestion 46: Guilt-Free Rejection UI
    const handlePassShift = (id: string, isSwap = false) => {
        if (isSwap) setPeerSwaps(prev => prev.filter(s => s.id !== id));
        else setShifts(prev => prev.filter(s => s.id !== id));
    };

    const renderShiftCard = (shift: Shift, isSwap: boolean) => (
        <div key={shift.id} style={{
            backgroundColor: '#FFFFFF', padding: '1.5rem', borderRadius: '16px', border: '1px solid #E5E7EB',
            boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)', display: 'flex', flexDirection: 'column'
        }}>
            {isSwap && (
                <div style={{ backgroundColor: '#EEF2FF', color: '#4F46E5', padding: '8px 12px', borderRadius: '8px', marginBottom: '16px', fontSize: '0.85rem', fontWeight: 700, display: 'flex', gap: '8px', alignItems: 'center' }}>
                    <ArrowRightLeft size={16} />
                    <span>Offered by {shift.offeredBy}</span>
                </div>
            )}

            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1rem' }}>
                <span style={{ backgroundColor: '#F3F4F6', color: '#374151', padding: '4px 12px', borderRadius: '20px', fontWeight: 700, fontSize: '0.75rem' }}>
                    {shift.service?.name}
                </span>
                <span style={{ fontSize: '0.875rem', color: '#6B7280', fontWeight: 600 }}>{shift.durationMinutes / 60} hrs</span>
            </div>

            <h3 style={{ margin: '0 0 0.5rem 0', fontSize: '1.2rem', color: '#111827' }}>
                {new Date(shift.requestedStartAt).toLocaleDateString(undefined, { weekday: 'short', month: 'short', day: 'numeric' })}
            </h3>
            <p style={{ margin: '0 0 1rem 0', fontSize: '1.4rem', fontWeight: 800, color: '#3B82F6' }}>
                {new Date(shift.requestedStartAt).toLocaleTimeString(undefined, { hour: '2-digit', minute: '2-digit' })}
            </p>

            <div style={{ marginBottom: '1.5rem', color: '#4B5563', fontSize: '0.9rem', display: 'flex', alignItems: 'center', gap: '6px' }}>
                <MapPin size={16} /> {shift.client?.city} Area
            </div>

            {isSwap && shift.note && (
                <div style={{ padding: '12px', backgroundColor: '#F9FAFB', borderLeft: '3px solid #D1D5DB', marginBottom: '16px', fontSize: '0.85rem', color: '#6B7280', fontStyle: 'italic' }}>
                    "{shift.note}"
                </div>
            )}

            <div style={{ marginTop: 'auto', display: 'flex', gap: '12px' }}>
                {/* Frictionless, neutral 'Pass' button removes it immediately without guilt modals */}
                <button
                    onClick={() => handlePassShift(shift.id, isSwap)}
                    style={{
                        flex: 1, padding: '12px', backgroundColor: '#F3F4F6', color: '#4B5563', border: 'none', borderRadius: '12px', fontWeight: 700, cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px'
                    }}
                >
                    <XIcon size={18} /> Pass
                </button>
                <button
                    onClick={() => handleAcceptShift(shift.id, isSwap)}
                    style={{
                        flex: 2, padding: '12px', backgroundColor: '#0F172A', color: '#FFFFFF', border: 'none', borderRadius: '12px', fontWeight: 700, cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px'
                    }}
                >
                    <Check size={18} /> Accept
                </button>
            </div>
        </div>
    );

    return (
        <div data-cy="page.container" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{ marginBottom: '2rem' }}>
                <h1 style={{ fontSize: '2.5rem', fontWeight: 900, margin: '0 0 16px 0', color: '#111827' }}>Shift Marketplace</h1>

                <div style={{ display: 'flex', gap: '12px', borderBottom: '2px solid #E5E7EB', paddingBottom: '0' }}>
                    <button
                        onClick={() => setActiveTab('marketplace')}
                        style={{ padding: '12px 24px', background: 'none', border: 'none', borderBottom: activeTab === 'marketplace' ? '3px solid #3B82F6' : '3px solid transparent', color: activeTab === 'marketplace' ? '#3B82F6' : '#6B7280', fontWeight: 800, fontSize: '1rem', cursor: 'pointer' }}
                    >
                        Open Agency Shifts ({shifts.length})
                    </button>
                    <button
                        onClick={() => setActiveTab('swap_board')}
                        style={{ padding: '12px 24px', background: 'none', border: 'none', borderBottom: activeTab === 'swap_board' ? '3px solid #4F46E5' : '3px solid transparent', color: activeTab === 'swap_board' ? '#4F46E5' : '#6B7280', fontWeight: 800, fontSize: '1rem', cursor: 'pointer' }}
                    >
                        Peer Swap Board ({peerSwaps.length})
                    </button>
                </div>
            </div>

            {loading ? (
                <div style={{ padding: '3rem', textAlign: 'center', color: '#6B7280' }}>Loading available shifts...</div>
            ) : activeTab === 'marketplace' ? (
                shifts.length > 0 ? (
                    <div style={{ display: 'grid', gap: '1.5rem', gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))' }}>
                        {shifts.map(shift => renderShiftCard(shift, false))}
                    </div>
                ) : (
                    <EmptyState title="No Open Shifts Available" description="There are currently no unfilled shifts in your service area." />
                )
            ) : (
                peerSwaps.length > 0 ? (
                    <div style={{ display: 'grid', gap: '1.5rem', gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))' }}>
                        {peerSwaps.map(shift => renderShiftCard(shift, true))}
                    </div>
                ) : (
                    <EmptyState title="No Swaps Requested" description="None of your peers have posted shifts to the Swap Board recently." />
                )
            )}
        </div>
    );
}

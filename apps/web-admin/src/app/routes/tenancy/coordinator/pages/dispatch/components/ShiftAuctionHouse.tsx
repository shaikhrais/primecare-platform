import React, { useState, useEffect } from 'react';
import { Gavel, AlertCircle, TrendingUp, CheckCircle2, Clock } from 'lucide-react';

interface AuctionedShift {
    id: string;
    patientInitials: string;
    location: string;
    date: string;
    durationHz: number;
    hazardTag: string;
    currentWinningBid: number; // Hourly rate
    highestBidderId?: string;
    timeRemainingSeconds: number;
}

export const ShiftAuctionHouse: React.FC = () => {
    const [shift, setShift] = useState<AuctionedShift>({
        id: 'shift_auc_09',
        patientInitials: 'T. R.',
        location: 'Downtown Toronto (M5V)',
        date: 'Tonight, 11:00 PM',
        durationHz: 8,
        hazardTag: 'Active Bedbugs Reported',
        currentWinningBid: 45.00, // Starts at $45/hr base
        timeRemainingSeconds: 600 // 10 mins
    });

    const [auctionClosed, setAuctionClosed] = useState(false);

    useEffect(() => {
        if (shift.timeRemainingSeconds <= 0) {
            setAuctionClosed(true);
            return;
        }

        const timer = setInterval(() => {
            setShift(prev => ({
                ...prev,
                timeRemainingSeconds: prev.timeRemainingSeconds - 1
            }));
        }, 1000);

 // incoming bids from the network
        const networkBids = setInterval(() => {
            if (Math.random() > 0.7) {
                setShift(prev => ({
                    ...prev,
                    currentWinningBid: prev.currentWinningBid - 1.50, // Reverse auction, rate goes down
                    highestBidderId: `psw_${Math.floor(Math.random() * 100)}`
                }));
            }
        }, 3500);

        return () => {
            clearInterval(timer);
            clearInterval(networkBids);
        };
    }, [shift.timeRemainingSeconds]);

    const formatTime = (seconds: number) => {
        const m = Math.floor(seconds / 60);
        const s = seconds % 60;
        return `${m}:${s < 10 ? '0' : ''}${s}`;
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', position: 'relative', overflow: 'hidden' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                    <div style={{ backgroundColor: '#FEF2F2', padding: '8px', borderRadius: '8px' }}>
                        <Gavel size={20} color="#DC2626" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Live Reverse Auction</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.85rem' }}>Bidding drives rate down.</p>
                    </div>
                </div>
                
                {!auctionClosed ? (
                    <div style={{ backgroundColor: shift.timeRemainingSeconds < 60 ? '#FEF2F2' : '#F1F5F9', color: shift.timeRemainingSeconds < 60 ? '#DC2626' : '#334155', padding: '6px 12px', borderRadius: '20px', fontWeight: 800, fontSize: '1rem', display: 'flex', alignItems: 'center', gap: '6px', border: shift.timeRemainingSeconds < 60 ? '1px solid #FECACA' : '1px solid #CBD5E1' }}>
                        <Clock size={16} /> {formatTime(shift.timeRemainingSeconds)}
                    </div>
                ) : (
                    <div style={{ backgroundColor: '#F0FDF4', color: '#166534', padding: '6px 12px', borderRadius: '20px', fontWeight: 800, fontSize: '0.9rem', display: 'flex', alignItems: 'center', gap: '6px', border: '1px solid #BBF7D0' }}>
                        <CheckCircle2 size={16} /> Auction Closed
                    </div>
                )}
            </div>

            <div style={{ backgroundColor: '#F8FAFC', border: '1px dashed #CBD5E1', padding: '16px', borderRadius: '8px', marginBottom: '24px' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '12px' }}>
                    <span style={{ fontWeight: 700, color: '#0F172A' }}>{shift.patientInitials} • {shift.location}</span>
                    <span style={{ fontWeight: 600, color: '#334155' }}>{shift.durationHz} Hours</span>
                </div>
                <div style={{ display: 'inline-flex', alignItems: 'center', gap: '6px', backgroundColor: '#FEF2F2', color: '#DC2626', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 800 }}>
                    <AlertCircle size={12} /> {shift.hazardTag}
                </div>
            </div>

            <div style={{ textAlign: 'center', padding: '24px 0', borderTop: '1px solid #F1F5F9' }}>
                <div style={{ fontSize: '0.85rem', color: '#64748B', fontWeight: 600, textTransform: 'uppercase', marginBottom: '8px' }}>Current Winning Bid (Rate/Hr)</div>
                <div style={{ fontSize: '3rem', fontWeight: 900, color: auctionClosed ? '#10B981' : '#0F172A', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px' }}>
                    ${shift.currentWinningBid.toFixed(2)}
                    {!auctionClosed && <TrendingUp size={24} color="#10B981" style={{ transform: 'rotate(180deg)' }} />}
                </div>
                <div style={{ marginTop: '8px', color: '#64748B', fontSize: '0.9rem' }}>
                    Bidder: {shift.highestBidderId || 'Awaiting Bids...'}
                </div>
            </div>

            {auctionClosed && (
                <div style={{ backgroundColor: '#10B981', color: 'white', textAlign: 'center', padding: '12px', borderRadius: '8px', fontWeight: 700, marginTop: '20px' }}>
                    Shift Assigned to {shift.highestBidderId} at ${shift.currentWinningBid.toFixed(2)}/hr
                </div>
            )}
        </div>
    );
};

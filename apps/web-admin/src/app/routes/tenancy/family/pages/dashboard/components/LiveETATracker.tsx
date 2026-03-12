import React, { useState, useEffect } from 'react';
import { MapPin, Navigation, Car } from 'lucide-react';
import { useRealtimeSync, SyncMessage } from '@/app/hooks/useRealtimeSync';

export const LiveETATracker: React.FC = () => {
 // a live coordinate stream
    const [progress, setProgress] = useState(0); // 0 to 100
    const [etaMinutes, setEtaMinutes] = useState(12);

    // In a real app, this listens to the actual driver telemetry
    useRealtimeSync((msg: SyncMessage) => {
        if (msg.type === 'TELEMETRY') {
            setProgress(prev => Math.min(100, prev + 2)); // Or msg.progress
            setEtaMinutes(prev => Math.max(0, prev - 0.25)); // Or msg.etaMinutes
        }
    });

    const isArrived = progress >= 100;

    return (
        <section style={{ backgroundColor: 'white', borderRadius: '16px', overflow: 'hidden', border: '1px solid #E2E8F0', boxShadow: '0 4px 6px -1px rgba(0,0,0,0.05)' }}>
            
            {/* Map Area */}
            <div style={{ height: '300px', backgroundColor: '#E2E8F0', position: 'relative', overflow: 'hidden' }}>
                {/* SVG Route Path */}
                <svg style={{ position: 'absolute', inset: 0, width: '100%', height: '100%' }} viewBox="0 0 100 100" preserveAspectRatio="none">
                    <path d="M 10 90 Q 50 90 50 50 T 90 10" fill="none" stroke="#CBD5E1" strokeWidth="2" />
                    <path d="M 10 90 Q 50 90 50 50 T 90 10" fill="none" stroke="#3B82F6" strokeWidth="2" 
                          style={{
                              strokeDasharray: '200',
                              strokeDashoffset: isArrived ? '0' : `${200 - (progress * 2)}`,
                              transition: 'stroke-dashoffset 1s linear'
                          }} 
                    />
                </svg>

                {/* Destination Node (House) */}
                <div style={{ position: 'absolute', top: '10%', right: '10%', transform: 'translate(50%, -50%)', backgroundColor: '#10B981', padding: '8px', borderRadius: '50%', border: '2px solid white', zIndex: 2 }}>
                    <MapPin size={24} color="white" fill="#10B981" />
                </div>

                {/* Traveling Node (Car/Worker) */}
                <div style={{ 
                    position: 'absolute', 
                    // Manual math for demo positioning along the fake curve
                    left: `${10 + (progress * 0.8)}%`, 
                    bottom: `${10 + (progress * 0.8)}%`, 
                    transform: 'translate(-50%, 50%)',
                    transition: 'left 1s linear, bottom 1s linear',
                    zIndex: 3
                }}>
                    <div style={{ backgroundColor: '#3B82F6', color: 'white', padding: '8px', borderRadius: '50%', boxShadow: '0 4px 6px -1px rgba(0,0,0,0.3)', position: 'relative' }}>
                        <Car size={20} />
                        {/* Radar Pulse */}
                        {!isArrived && <div className="radar-pulse"></div>}
                    </div>
                </div>

                <style>{`
                    .radar-pulse {
                        position: absolute;
                        inset: -4px;
                        border-radius: 50%;
                        background-color: rgba(59, 130, 246, 0.4);
                        animation: r-pulse 1.5s infinite;
                        z-index: -1;
                    }
                    @keyframes r-pulse {
                        0% { transform: scale(1); opacity: 0.8; }
                        100% { transform: scale(3); opacity: 0; }
                    }
                `}</style>
            </div>

            {/* HUD / Details */}
            <div style={{ padding: '24px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', backgroundColor: isArrived ? '#F0FDF4' : 'white' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <img src="https://i.pravatar.cc/100?img=47" alt="Sarah J." style={{ width: '56px', height: '56px', borderRadius: '50%', objectFit: 'cover', border: '2px solid #E2E8F0' }} />
                    <div>
                        <h3 style={{ margin: '0 0 4px 0', fontSize: '1.25rem', fontWeight: 900, color: '#0F172A' }}>Sarah Jenkins</h3>
                        <div style={{ color: '#64748B', fontSize: '0.9rem', display: 'flex', alignItems: 'center', gap: '4px' }}>
                            <Car size={14} /> License: AB-1234
                        </div>
                    </div>
                </div>

                <div style={{ textAlign: 'right' }}>
                    <div style={{ fontSize: '0.85rem', fontWeight: 800, color: '#64748B', textTransform: 'uppercase', letterSpacing: '1px' }}>
                        {isArrived ? 'Status' : 'Arriving In'}
                    </div>
                    <div style={{ fontSize: '2rem', fontWeight: 900, color: isArrived ? '#10B981' : '#0F172A', lineHeight: 1, marginTop: '4px' }}>
                        {isArrived ? 'ARRIVED' : `${Math.ceil(etaMinutes)} min`}
                    </div>
                </div>
            </div>
            
        </section>
    );
};

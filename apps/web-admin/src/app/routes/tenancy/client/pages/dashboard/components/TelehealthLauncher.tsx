import React, { useState } from 'react';
import { Video, Phone, X } from 'lucide-react';

export const TelehealthLauncher: React.FC = () => {
    const [isInCall, setIsInCall] = useState(false);

    if (isInCall) {
        return (
            <section style={{ backgroundColor: '#1E293B', borderRadius: '24px', padding: '32px', color: 'white', position: 'relative', overflow: 'hidden', height: '400px', display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center', border: '4px solid #6366F1', boxShadow: '0 25px 50px -12px rgba(99, 102, 241, 0.5)' }}>
                {/* the Daily.co / WebRTC iFrame injection point */}
                <div style={{ position: 'absolute', inset: 0, backgroundColor: 'black', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ textAlign: 'center' }}>
                        <div style={{ width: '120px', height: '120px', borderRadius: '50%', backgroundColor: '#334155', margin: '0 auto 24px auto', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                             <UserPlaceholder />
                        </div>
                        <h2 data-cy="h2-client.telehealth-launcher-0" style={{ fontSize: '2rem', fontWeight: 900, margin: 0 }}>Dr. Emily Chen</h2>
                        <div style={{ color: '#10B981', fontSize: '1.25rem', marginTop: '8px' }}>Connected - 00:14</div>
                    </div>
                </div>

                {/* Overlaid Controls */}
                <div style={{ position: 'absolute', bottom: '32px', left: 0, right: 0, display: 'flex', justifyContent: 'center' }}>
                    <button data-cy="btn-client.telehealth-launcher-0" 
                        onClick={() => setIsInCall(false)}
                        style={{ backgroundColor: '#EF4444', color: 'white', border: 'none', borderRadius: '50%', width: '80px', height: '80px', display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer', boxShadow: '0 10px 15px -3px rgba(239, 68, 68, 0.5)' }}
                    >
                        <Phone size={36} style={{ transform: 'rotate(135deg)' }} />
                    </button>
                </div>
            </section>
        );
    }

    return (
        <section style={{ backgroundColor: 'white', borderRadius: '24px', border: '4px solid #E2E8F0', padding: '32px', display: 'flex', flexDirection: 'column', gap: '24px' }}>
            <div>
                <h2 data-cy="h2-client.telehealth-launcher-1" style={{ fontSize: '2rem', fontWeight: 900, color: '#0F172A', margin: '0 0 8px 0' }}>Doctor Notified</h2>
                <p style={{ fontSize: '1.25rem', color: '#64748B', margin: 0 }}>Dr. Chen is ready to see you now. Press the button below to join the secure video room.</p>
            </div>

            <button data-cy="btn-client.telehealth-launcher-1" 
                onClick={() => setIsInCall(true)}
                style={{ 
                    backgroundColor: '#6366F1', 
                    color: 'white', 
                    border: 'none', 
                    borderRadius: '24px', 
                    padding: '32px', 
                    cursor: 'pointer',
                    display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '24px',
                    width: '100%',
                    position: 'relative',
                    overflow: 'hidden',
                    boxShadow: '0 20px 25px -5px rgba(99, 102, 241, 0.4)'
                }}
            >
                {/* CSS Pulse Ring */}
                <span className="telehealth-pulse-ring"></span>
                
                <div style={{ backgroundColor: 'white', borderRadius: '50%', padding: '24px', zIndex: 1 }}>
                    <Video size={48} color="#6366F1" />
                </div>
                <div style={{ zIndex: 1, textAlign: 'left' }}>
                    <div style={{ fontSize: '2.5rem', fontWeight: 900, lineHeight: 1 }}>JOIN NURSE CALL</div>
                    <div style={{ fontSize: '1.25rem', fontWeight: 700, opacity: 0.9, marginTop: '8px' }}>Tap here to start video</div>
                </div>

                <style>{`
                    .telehealth-pulse-ring {
                        position: absolute;
                        top: 50%;
                        left: 50%;
                        transform: translate(-50%, -50%);
                        width: 100%;
                        height: 100%;
                        border-radius: 24px;
                        background-color: rgba(255, 255, 255, 0.2);
                        z-index: 0;
                        animation: video-pulse 2s infinite;
                    }

                    @keyframes video-pulse {
                        0% { transform: translate(-50%, -50%) scale(1); opacity: 1; }
                        100% { transform: translate(-50%, -50%) scale(1.5); opacity: 0; }
                    }
                `}</style>
            </button>
        </section>
    );
};

const UserPlaceholder = () => (
    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#94A3B8" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
        <circle cx="12" cy="7" r="4"></circle>
    </svg>
);

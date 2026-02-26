import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface WelcomeCardProps {
    userName: string;
    shiftCount: number;
}

export const WelcomeCard: React.FC<WelcomeCardProps> = ({ userName, shiftCount }) => {
    return (
        <div
            className="welcome-card-container"
            data-cy="welcome-card"
            style={{
                position: 'relative',
                overflow: 'hidden',
                background: 'linear-gradient(225deg, #000000 0%, #064E3B 100%)',
                color: '#FFFFFF',
                borderRadius: '24px',
                display: 'flex',
                flexDirection: 'column',
                gap: '16px',
                boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.5)',
                border: '1px solid rgba(255, 255, 255, 0.1)'
            }}
        >
            {/* Immersive Background Effects */}
            <div className="bg-blob-1" style={{
                position: 'absolute',
                top: '-10%',
                right: '-5%',
                width: '400px',
                height: '400px',
                background: 'radial-gradient(circle, rgba(0, 135, 90, 0.15) 0%, transparent 70%)',
                borderRadius: '50%',
                filter: 'blur(40px)',
                pointerEvents: 'none'
            }} />
            <div className="bg-blob-2" style={{
                position: 'absolute',
                bottom: '-20%',
                left: '10%',
                width: '300px',
                height: '300px',
                background: 'radial-gradient(circle, rgba(255, 255, 255, 0.05) 0%, transparent 70%)',
                borderRadius: '50%',
                filter: 'blur(30px)',
                pointerEvents: 'none'
            }} />

            <div style={{ position: 'relative', zIndex: 1 }}>
                <h2 className="welcome-title" style={{ margin: 0, fontWeight: 900, letterSpacing: '-1.5px', lineHeight: 1.1 }}>
                    {ContentRegistry.PSW_DASHBOARD.TITLE}, <br />
                    <span className="welcome-name" style={{
                        background: 'linear-gradient(to right, #00C985, #FFFFFF)',
                        WebkitBackgroundClip: 'text',
                        WebkitTextFillColor: 'transparent',
                    }}>{userName}</span>! 👋
                </h2>
                <p className="welcome-text" style={{ margin: '16px 0 0 0', opacity: 0.9, fontWeight: 500, maxWidth: '600px', lineHeight: 1.5 }}>
                    Your enterprise service provider command center is ready. You have <strong style={{ color: '#00C985' }}>{shiftCount} visits</strong> scheduled for your shift today.
                </p>

                <div style={{ marginTop: '32px', display: 'flex', gap: '16px', alignItems: 'center' }}>
                    <div style={{
                        padding: '10px 20px',
                        background: 'rgba(255, 255, 255, 0.1)',
                        border: '1px solid rgba(255, 255, 255, 0.15)',
                        borderRadius: '16px',
                        fontSize: '0.95rem',
                        fontWeight: 700,
                        color: '#FFFFFF',
                        backdropFilter: 'blur(8px)',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '8px'
                    }}>
                        <span style={{ color: '#00C985' }}>●</span> Ready for Check-in
                    </div>
                </div>
            </div>

            <style>{`
                .welcome-card-container {
                    padding: 32px;
                }
                .welcome-title {
                    font-size: 2.5rem;
                }
                .welcome-name {
                    font-size: 3rem;
                }
                .welcome-text {
                    font-size: 1.25rem;
                }
                
                @media (max-width: 768px) {
                    .welcome-card-container {
                        padding: 24px !important;
                    }
                    .welcome-title {
                        font-size: 1.75rem !important;
                    }
                    .welcome-name {
                        font-size: 2rem !important;
                    }
                    .welcome-text {
                        font-size: 1rem !important;
                    }
                    /* Tame the blobs on mobile so they don't look weird */
                    .bg-blob-1 {
                        width: 200px !important;
                        height: 200px !important;
                        top: -5% !important;
                        right: -10% !important;
                    }
                    .bg-blob-2 {
                        width: 150px !important;
                        height: 150px !important;
                        bottom: -10% !important;
                        left: -5% !important;
                    }
                }
            `}</style>
        </div>
    );
};

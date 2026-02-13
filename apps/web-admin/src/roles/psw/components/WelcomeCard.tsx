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
            data-cy="welcome-card"
            style={{
                padding: '32px',
                background: 'linear-gradient(135deg, #000000 0%, #111827 100%)',
                color: '#FFFFFF',
                borderRadius: '24px',
                display: 'flex',
                flexDirection: 'column',
                gap: '12px',
                boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)',
                position: 'relative',
                overflow: 'hidden'
            }}
        >
            {/* Abstract Background Pattern */}
            <div style={{
                position: 'absolute',
                top: '-50px',
                right: '-50px',
                width: '200px',
                height: '200px',
                background: 'radial-gradient(circle, rgba(0, 135, 90, 0.2) 0%, transparent 70%)',
                borderRadius: '50%',
                pointerEvents: 'none'
            }} />

            <h2 style={{ margin: 0, fontSize: '2rem', fontWeight: 900, letterSpacing: '-0.5px' }}>
                {ContentRegistry.PSW_DASHBOARD.TITLE}, <span style={{ color: '#00875A' }}>{userName}</span>! 👋
            </h2>
            <p style={{ margin: 0, opacity: 0.8, fontSize: '1.25rem', fontWeight: 500 }}>
                You have <strong style={{ color: '#FFFFFF' }}>{shiftCount} visits</strong> scheduled for today.
            </p>
            <div style={{ marginTop: '20px', display: 'flex', gap: '12px', alignItems: 'center' }}>
                <div style={{
                    padding: '6px 16px',
                    background: 'rgba(0, 135, 90, 0.15)',
                    border: '1px solid rgba(0, 135, 90, 0.3)',
                    borderRadius: '20px',
                    fontSize: '0.9rem',
                    fontWeight: 700,
                    color: '#00C985',
                    backdropFilter: 'blur(4px)'
                }}>
                    Next: 10:30 AM
                </div>
                <div style={{ fontSize: '0.9rem', color: '#9CA3AF', fontWeight: 600 }}>
                    Client: Margaret W.
                </div>
            </div>
        </div>
    );
};

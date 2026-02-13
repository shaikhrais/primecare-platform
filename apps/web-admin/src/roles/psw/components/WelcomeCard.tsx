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
                padding: '24px',
                backgroundColor: '#000000',
                color: '#FFFFFF',
                borderRadius: '16px',
                display: 'flex',
                flexDirection: 'column',
                gap: '8px',
                boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)'
            }}
        >
            <h2 style={{ margin: 0, fontSize: '1.5rem', fontWeight: 800 }}>
                {ContentRegistry.PSW_DASHBOARD.TITLE}, {userName}! 👋
            </h2>
            <p style={{ margin: 0, opacity: 0.9, fontSize: '1.1rem' }}>
                You have <strong>{shiftCount} visits</strong> scheduled for today.
            </p>
            <div style={{ marginTop: '16px', display: 'flex', gap: '8px', alignItems: 'center' }}>
                <span style={{
                    padding: '4px 12px',
                    backgroundColor: '#00875A',
                    borderRadius: '20px',
                    fontSize: '0.85rem',
                    fontWeight: 700
                }}>
                    Next Visit: 10:30 AM
                </span>
            </div>
        </div>
    );
};

import React from 'react';
import { useNavigate } from 'react-router-dom';

interface QuickActionCardProps {
    label: string;
    icon: string;
    onClick: () => void;
    dataCy: string;
}

const QuickActionCard = ({ label, icon, onClick, dataCy }: QuickActionCardProps) => (
    <div
        className="pc-card"
        data-cy={dataCy}
        onClick={onClick}
        style={{
            padding: '24px',
            display: 'flex',
            alignItems: 'center',
            gap: '16px',
            cursor: 'pointer'
        }}
    >
        <div style={{ fontSize: '2.5rem' }}>{icon}</div>
        <div style={{ fontWeight: 900, fontSize: '1.2rem', color: 'var(--brand-500)', letterSpacing: '.2px' }}>{label}</div>
    </div>
);

export const QuickActions: React.FC = () => {
    const navigate = useNavigate();

    return (
        <>
            <h2 data-cy="section.quick-actions" style={{ fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', marginBottom: '1.5rem', color: 'var(--text-300)' }}>Quick Actions</h2>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', gap: '20px', marginBottom: '40px' }}>
                <QuickActionCard label="Daily Care Entry" icon="📝" onClick={() => navigate('/manager/daily-entry')} dataCy="qa-daily-entry" />
                <QuickActionCard label="Staff Evaluations" icon="📋" onClick={() => navigate('/manager/evaluations')} dataCy="qa-evaluations" />
                <QuickActionCard label="Service Reviews" icon="⭐" onClick={() => navigate('/manager/service-reviews')} dataCy="qa-service-reviews" />
                <QuickActionCard label="Log Incident" icon="⚠️" onClick={() => navigate('/incidents')} dataCy="qa-log-incident" />
                <QuickActionCard label="View Clients" icon="👥" onClick={() => navigate('/customers')} dataCy="qa-view-clients" />
            </div>
        </>
    );
};

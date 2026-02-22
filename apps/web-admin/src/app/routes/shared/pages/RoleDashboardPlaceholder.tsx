import React from 'react';

interface RoleDashboardPlaceholderProps {
    role: string;
}

const RoleDashboardPlaceholder: React.FC<RoleDashboardPlaceholderProps> = ({ role }) => {
    return (
        <div style={{ padding: '2rem', textAlign: 'center', color: '#6B7280' }}>
            <h1 style={{ fontSize: '2rem', fontWeight: 700, marginBottom: '1rem', color: '#111827' }}>
                {role.charAt(0).toUpperCase() + role.slice(1)} Dashboard
            </h1>
            <div style={{ fontSize: '1.2rem', marginBottom: '2rem' }}>
                🚧 Under Construction
            </div>
            <p>
                The {role} portal is currently being set up.
                <br />
                Please check back later for full functionality.
            </p>
        </div>
    );
};

export default RoleDashboardPlaceholder;

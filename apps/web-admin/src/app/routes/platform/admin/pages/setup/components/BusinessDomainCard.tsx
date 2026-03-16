import React from 'react';
import { useNavigate, Link } from 'react-router';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

interface DomainCardProps {
    domain: {
        id: string;
        name: string;
        status: string;
        count: string;
        icon: string;
        color: string;
        action: string;
        route: string;
    };
}

export const BusinessDomainCard: React.FC<DomainCardProps> = ({ domain }) => {
    const navigate = useNavigate();

    return (
        <div style={{
            background: 'white',
            borderRadius: '1.5rem',
            padding: '2rem',
            border: '1px solid #e5e7eb',
            display: 'flex',
            flexDirection: 'column',
            gap: '1.5rem',
            transition: 'transform 0.2s, box-shadow 0.2s',
            cursor: 'default'
        }}
            onMouseOver={e => {
                e.currentTarget.style.transform = 'translateY(-4px)';
                e.currentTarget.style.boxShadow = '0 10px 15px -3px rgba(0, 0, 0, 0.1)';
            }}
            onMouseOut={e => {
                e.currentTarget.style.transform = 'translateY(0)';
                e.currentTarget.style.boxShadow = 'none';
            }}
        >
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                <div style={{
                    width: '56px',
                    height: '56px',
                    borderRadius: '1rem',
                    background: `${domain.color}15`,
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    fontSize: '2rem'
                }}>
                    {domain.icon}
                </div>
                <div style={{
                    padding: '0.375rem 0.75rem',
                    borderRadius: '9999px',
                    background: ['Active', 'Staffed', 'Operational', 'Ready'].includes(domain.status)
                        ? '#ecfdf5' : '#fff7ed',
                    color: ['Active', 'Staffed', 'Operational', 'Ready'].includes(domain.status)
                        ? '#059669' : '#d97706',
                    fontSize: '0.75rem',
                    fontWeight: '700'
                }}>
                    {domain.status}
                </div>
            </div>

            <div>
                <h3 data-cy="h3-admin.business-domain-card-0" style={{ fontSize: '1.25rem', fontWeight: '800', color: '#111827', margin: 0 }}>{domain.name}</h3>
                <p style={{ fontSize: '1rem', color: '#6b7280', margin: '0.25rem 0 0 0' }}>{domain.count}</p>
            </div>

            <div style={{ marginTop: 'auto', display: 'flex', gap: '0.75rem' }}>
                <button data-cy="btn-admin.business-domain-card-0"
                    onClick={() => navigate(domain.route)}
                    style={{
                        flex: 1,
                        padding: '0.75rem',
                        background: domain.color,
                        color: 'white',
                        border: 'none',
                        borderRadius: '0.75rem',
                        fontWeight: '700',
                        fontSize: '0.875rem',
                        cursor: 'pointer'
                    }}
                >
                    {domain.action}
                </button>
                <Link to={RouteRegistry.ADMIN.WIZARD_HUB} style={{ flex: 1 }}>
                    <button data-cy="btn-admin.business-domain-card-1" style={{
                        width: '100%',
                        padding: '0.75rem',
                        background: 'white',
                        color: '#374151',
                        border: '1px solid #d1d5db',
                        borderRadius: '0.75rem',
                        fontWeight: '600',
                        fontSize: '0.875rem',
                        cursor: 'pointer'
                    }}>
                        Wizards
                    </button>
                </Link>
            </div>
        </div>
    );
};

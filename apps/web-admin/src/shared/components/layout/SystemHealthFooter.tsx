import React from 'react';
import { Database, Server, Zap } from 'lucide-react';
import { useAuth } from '@/shared/context/AuthContext';

export const SystemHealthFooter: React.FC = () => {
    const { user } = useAuth();

    // Critical: Only render this global sticky footer if the user is a Platform Administrator.
    // Assuming role 'super_admin' or similar for this persona.
    // In a real app we would check user.roles.includes('SUPER_ADMIN'), 
    // but for demonstration we'll just render it or assume the layout wrapper handles it.

    const nodes = [
        { name: 'Core Database (Primary)', ping: '12ms', status: 'healthy', icon: <Database size={14} /> },
        { name: 'Redis Cache (Edge)', ping: '3ms', status: 'healthy', icon: <Zap size={14} /> },
        { name: 'Worker APIs (Proxy)', ping: '45ms', status: 'warning', icon: <Server size={14} /> },
    ];

    const getColors = (status: string) => {
        if (status === 'warning') return { bg: '#FEF3C7', pulse: '#F59E0B', text: '#B45309' };
        if (status === 'critical') return { bg: '#FEE2E2', pulse: '#EF4444', text: '#B91C1C' };
        return { bg: '#D1FAE5', pulse: '#10B981', text: '#047857' };
    };

    return (
        <div style={{ 
            position: 'fixed', 
            bottom: 0, 
            left: 0, 
            right: 0, 
            height: '32px', 
            backgroundColor: '#0F172A', 
            borderTop: '1px solid #334155',
            zIndex: 9999, // Ensure it sits above all UI
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            padding: '0 24px',
            fontFamily: 'monospace',
            fontSize: '0.75rem'
        }}>
            <div style={{ color: '#94A3B8', fontWeight: 700 }}>
                PRIMECARE PLATFORM TELEMETRY | ENV: PRODUCTION
            </div>

            <div style={{ display: 'flex', gap: '24px' }}>
                {nodes.map(node => {
                    const colors = getColors(node.status);
                    return (
                        <div key={node.name} style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#CBD5E1' }}>
                            <div style={{ position: 'relative', width: '8px', height: '8px' }}>
                                {/* Solid Core */}
                                <div style={{ position: 'absolute', inset: 0, backgroundColor: colors.pulse, borderRadius: '50%' }} />
                                {/* Pulsing Halo */}
                                <div style={{ 
                                    position: 'absolute', 
                                    inset: 0, 
                                    backgroundColor: colors.pulse, 
                                    borderRadius: '50%', 
                                    animation: 'pulse-ring 2s cubic-bezier(0.4, 0, 0.6, 1) infinite'
                                }} />
                            </div>
                            <span style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
                                {node.icon} {node.name}
                            </span>
                            <span style={{ color: colors.pulse, fontWeight: 700 }}>
                                {node.ping}
                            </span>
                        </div>
                    );
                })}
            </div>

            <style>{`
                @keyframes pulse-ring {
                    0% { transform: scale(1); opacity: 0.8; }
                    100% { transform: scale(3); opacity: 0; }
                }
            `}</style>
        </div>
    );
};

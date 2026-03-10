import React, { useState, useEffect } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { Maximize, ExternalLink, Activity, Users, MapPin } from 'lucide-react';

interface FleetRadarMapProps {
    isStandalone?: boolean;
}

// Mock up 10 random field workers in a CSS grid mimicking a city zone
const MOCK_WORKERS = Array.from({ length: 15 }).map((_, i) => ({
    id: i,
    x: Math.random() * 90 + 5, // 5% to 95%
    y: Math.random() * 90 + 5,
    status: Math.random() > 0.8 ? 'delayed' : 'on-time',
    name: `Worker ${i + 1}`
}));

export const FleetRadarMap: React.FC<FleetRadarMapProps> = ({ isStandalone = false }) => {
    const { showToast } = useNotification();
    const [workers, setWorkers] = useState(MOCK_WORKERS);

    // Simulate real-time movement
    useEffect(() => {
        const interval = setInterval(() => {
            setWorkers(prev => prev.map(w => ({
                ...w,
                x: Math.max(5, Math.min(95, w.x + (Math.random() - 0.5) * 2)),
                y: Math.max(5, Math.min(95, w.y + (Math.random() - 0.5) * 2)),
            })));
        }, 3000);
        return () => clearInterval(interval);
    }, []);

    // Suggestion 22: Dual Monitor Pop-out (Tear Off) Feature
    const handleTearOff = () => {
        // In a real app, this would route to a specific `/standalone/radar` path that only renders this component.
        // We will mock the `window.open` feature and show a toast since we don't have a standalone route registered currently.
        const standaloneUrl = window.location.origin + '/?radar_standalone=true'; // Mock standalone flag
        window.open(standaloneUrl, '_blank', 'width=1000,height=800,menubar=no,toolbar=no,location=no');
        showToast('Fleet Radar detached to secondary monitor.', 'success');
    };

    return (
        <div style={{
            display: 'flex', flexDirection: 'column', height: isStandalone ? '100vh' : '600px',
            backgroundColor: '#0F172A', borderRadius: isStandalone ? '0' : '16px', overflow: 'hidden',
            boxShadow: isStandalone ? 'none' : '0 20px 25px -5px rgba(0,0,0,0.2)', fontFamily: 'system-ui, sans-serif'
        }}>
            {/* Header / Telemetry Bar */}
            <div style={{ padding: '16px 24px', backgroundColor: '#1E293B', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: '1px solid #334155' }}>
                <div style={{ display: 'flex', gap: '24px', color: 'white' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                        <MapPin size={20} color="#38BDF8" />
                        <span style={{ fontWeight: 800, letterSpacing: '1px' }}>GTA SECTOR A-4</span>
                    </div>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#94A3B8' }}>
                        <Users size={16} /> 15 Active Units
                    </div>
                </div>

                {!isStandalone && (
                    <button
                        onClick={handleTearOff}
                        style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '8px 16px', backgroundColor: '#38BDF8', color: '#0F172A', border: 'none', borderRadius: '6px', fontWeight: 800, cursor: 'pointer' }}
                    >
                        <ExternalLink size={16} /> Tear Off View
                    </button>
                )}
            </div>

            {/* Simulated Radar Map Space */}
            <div style={{ position: 'relative', flex: 1, backgroundColor: '#020617', margin: '2px', borderRadius: '12px', overflow: 'hidden' }}>
                {/* Radar Grid Overlay */}
                <div style={{
                    position: 'absolute', inset: 0,
                    backgroundImage: 'linear-gradient(rgba(51, 65, 85, 0.4) 1px, transparent 1px), linear-gradient(90deg, rgba(51, 65, 85, 0.4) 1px, transparent 1px)',
                    backgroundSize: '50px 50px'
                }} />

                {/* Radar Sweep Animation (pure CSS approximation) */}
                <div style={{
                    position: 'absolute', top: '50%', left: '50%', width: '100vw', height: '100vw',
                    background: 'conic-gradient(from 0deg, transparent 70%, rgba(56, 189, 248, 0.1) 100%)',
                    transformOrigin: '0 0',
                    animation: 'spin 4s linear infinite',
                    pointerEvents: 'none',
                }} />
                <style>
                    {`@keyframes spin { 100% { transform: rotate(360deg); } }`}
                </style>

                {/* Worker Blips */}
                {workers.map(worker => (
                    <div
                        key={worker.id}
                        style={{
                            position: 'absolute',
                            left: `${worker.x}%`,
                            top: `${worker.y}%`,
                            transform: 'translate(-50%, -50%)',
                            display: 'flex',
                            flexDirection: 'column',
                            alignItems: 'center',
                            transition: 'left 3s linear, top 3s linear'
                        }}
                        title={worker.name}
                    >
                        {/* Blip Dot */}
                        <div style={{
                            width: '12px', height: '12px',
                            backgroundColor: worker.status === 'delayed' ? '#EF4444' : '#10B981',
                            borderRadius: '50%',
                            boxShadow: `0 0 10px ${worker.status === 'delayed' ? '#EF4444' : '#10B981'}`,
                            position: 'relative'
                        }}>
                            {/* Ping Animation */}
                            <div style={{
                                position: 'absolute', inset: '-6px', borderRadius: '50%',
                                border: `2px solid ${worker.status === 'delayed' ? '#EF4444' : '#10B981'}`,
                                opacity: 0,
                                animation: 'ping 2s cubic-bezier(0, 0, 0.2, 1) infinite',
                            }} />
                        </div>
                        {/* Label */}
                        <div style={{
                            marginTop: '8px', fontSize: '0.75rem', fontWeight: 700,
                            backgroundColor: 'rgba(15, 23, 42, 0.8)', padding: '2px 6px', borderRadius: '4px',
                            color: worker.status === 'delayed' ? '#FCA5A5' : '#D1FAE5',
                            border: `1px solid ${worker.status === 'delayed' ? '#7F1D1D' : '#064E3B'}`
                        }}>
                            {worker.name}
                        </div>
                    </div>
                ))}

                <style>
                    {`@keyframes ping { 75%, 100% { transform: scale(2); opacity: 0; } 0% { opacity: 1; transform: scale(1); } }`}
                </style>
            </div>
        </div>
    );
};

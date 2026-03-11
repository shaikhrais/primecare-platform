import React, { useState } from 'react';
import { AlertTriangle, Eye, CheckCircle2 } from 'lucide-react';

interface Hazard {
    id: string;
    description: string;
    found: boolean;
    x: number;
    y: number; // Percentages for positioning on the Viewport
}

export const VrHoardingSimulator: React.FC = () => {
    const [hazards, setHazards] = useState<Hazard[]>([
        { id: 'h1', description: 'Exposed extension cord across walkway', found: false, x: 35, y: 75 },
        { id: 'h2', description: 'Stack of newspapers near space heater', found: false, x: 70, y: 40 },
        { id: 'h3', description: 'Expired medication on counter', found: false, x: 20, y: 55 }
    ]);
    
    const [viewPan, setViewPan] = useState({ x: 0, y: 0 }); // looking around
    const foundCount = hazards.filter(h => h.found).length;
    const isComplete = foundCount === hazards.length;

    const handleIdentifyHazard = (id: string) => {
        setHazards(prev => prev.map(h => h.id === id ? { ...h, found: true } : h));
    };

    return (
        <div style={{ backgroundColor: '#0F172A', borderRadius: '16px', overflow: 'hidden', border: '2px solid #334155', marginTop: '16px', color: 'white' }}>
            
            {/* Header HUD */}
            <div style={{ padding: '16px 20px', backgroundColor: '#1E293B', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: '1px solid #334155' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                    <div style={{ backgroundColor: '#2563EB', padding: '6px', borderRadius: '6px' }}>
                        <Eye size={18} color="white" />
                    </div>
                    <span style={{ fontWeight: 800, fontSize: '1rem', letterSpacing: '1px' }}>XR TRAINING MODULE</span>
                </div>
                
                <div style={{ display: 'flex', gap: '16px', alignItems: 'center' }}>
                    <div style={{ fontSize: '0.85rem', color: '#94A3B8' }}>Scenario: Hoarding Risk Level 3</div>
                    <div style={{ backgroundColor: isComplete ? '#10B981' : '#334155', color: 'white', padding: '4px 12px', borderRadius: '20px', fontSize: '0.85rem', fontWeight: 700 }}>
                        Hazards Found: {foundCount} / {hazards.length}
                    </div>
                </div>
            </div>

            {/* the XR Viewport */}
            <div 
                style={{ 
                    height: '400px', width: '100%', position: 'relative', 
 // a blurred living room background
                    backgroundImage: 'radial-gradient(circle at center, #334155 0%, #0F172A 100%)',
                    cursor: 'crosshair',
                    overflow: 'hidden'
                }}
                onMouseMove={(e) => {
 // Simple parallax effect to looking around
                    const rx = (e.clientX / window.innerWidth) * 20 - 10;
                    const ry = (e.clientY / window.innerHeight) * 20 - 10;
                    setViewPan({ x: rx, y: ry });
                }}
            >
                {/* Crosshairs overlay */}
                <div style={{ position: 'absolute', top: '50%', left: '50%', transform: 'translate(-50%, -50%)', width: '40px', height: '40px', border: '2px dashed rgba(255,255,255,0.3)', borderRadius: '50%', pointerEvents: 'none' }}>
                    <div style={{ position: 'absolute', top: '50%', left: '50%', transform: 'translate(-50%, -50%)', width: '4px', height: '4px', backgroundColor: 'rgba(255,255,255,0.8)', borderRadius: '50%' }} />
                </div>

                {/* Hazards */}
                <div style={{ width: '100%', height: '100%', transform: `translate(${viewPan.x}px, ${viewPan.y}px)`, transition: 'transform 0.1s ease-out' }}>
                    {hazards.map(hazard => (
                        <div 
                            key={hazard.id}
                            onClick={() => !hazard.found ? handleIdentifyHazard(hazard.id) : null}
                            style={{ 
                                position: 'absolute', left: `${hazard.x}%`, top: `${hazard.y}%`,
                                transform: 'translate(-50%, -50%)',
                                width: '40px', height: '40px',
                                border: hazard.found ? '2px solid #10B981' : '2px solid transparent',
                                backgroundColor: hazard.found ? 'rgba(16, 185, 129, 0.2)' : 'rgba(255,255,255,0.05)',
                                borderRadius: '50%',
                                cursor: hazard.found ? 'default' : 'pointer',
                                display: 'flex', alignItems: 'center', justifyContent: 'center'
                            }}
                        >
                            {hazard.found && <CheckCircle2 size={24} color="#10B981" />}
                            {!hazard.found && (
                                <div className="pulse-ring" style={{ width: '100%', height: '100%', borderRadius: '50%', border: '2px solid rgba(239, 68, 68, 0.5)' }}></div>
                            )}
                        </div>
                    ))}
                </div>

                {isComplete && (
                    <div style={{ position: 'absolute', top: 0, left: 0, right: 0, bottom: 0, backgroundColor: 'rgba(15, 23, 42, 0.8)', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', animation: 'fadeIn 0.5s' }}>
                        <CheckCircle2 size={64} color="#10B981" style={{ marginBottom: '16px' }} />
                        <h2 style={{ margin: 0, fontSize: '2rem', fontWeight: 900 }}>Module Passed!</h2>
                        <p style={{ color: '#94A3B8', marginTop: '8px' }}>You successfully identified all physical hazards.</p>
                        <button style={{ marginTop: '24px', backgroundColor: '#2563EB', color: 'white', border: 'none', padding: '12px 24px', borderRadius: '8px', fontWeight: 700, cursor: 'pointer' }}>
                            Continue to Final Exam
                        </button>
                    </div>
                )}
            </div>
            <style>{`
                @keyframes pulse {
                    0% { transform: scale(0.8); opacity: 0.8; }
                    100% { transform: scale(1.5); opacity: 0; }
                }
                .pulse-ring { animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite; }
                @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
            `}</style>
        </div>
    );
};

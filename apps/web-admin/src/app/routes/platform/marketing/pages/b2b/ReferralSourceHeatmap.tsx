import React, { useState } from 'react';
import { Map, MapPin, Search, PlusCircle, Activity } from 'lucide-react';

interface ClinicLocation {
    id: string;
    name: string;
    type: 'HOSPITAL' | 'REHAB_CENTER' | 'PRIVATE_PRACTICE';
    referralVolume: number; // 0-100 scale for map bubble size
    coordinates: { x: number, y: number };
    address: string;
}

export const ReferralSourceHeatmap: React.FC = () => {
    const [locations] = useState<ClinicLocation[]>([
        { id: '1', name: 'St. Jude Regional Hospital', type: 'HOSPITAL', referralVolume: 95, coordinates: { x: 300, y: 150 }, address: '1442 West Blvd.' },
        { id: '2', name: 'Downtown Rehab Center', type: 'REHAB_CENTER', referralVolume: 65, coordinates: { x: 450, y: 280 }, address: '400 Main St.' },
        { id: '3', name: 'Dr. Emily Chen (Cardiology)', type: 'PRIVATE_PRACTICE', referralVolume: 40, coordinates: { x: 200, y: 320 }, address: '88 Valley View Rd.' },
        { id: '4', name: 'Memorial Hospice', type: 'HOSPITAL', referralVolume: 20, coordinates: { x: 600, y: 120 }, address: '100 North Ave.' }
    ]);

    const [hoveredNode, setHoveredNode] = useState<ClinicLocation | null>(null);

    const getBubbleColor = (type: string) => {
        switch(type) {
            case 'HOSPITAL': return 'rgba(99, 102, 241, 0.6)'; // Indigo
            case 'REHAB_CENTER': return 'rgba(16, 185, 129, 0.6)'; // Emerald
            case 'PRIVATE_PRACTICE': return 'rgba(245, 158, 11, 0.6)'; // Amber
            default: return 'rgba(100, 116, 139, 0.6)';
        }
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
             <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F8FAFC', padding: '12px', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                        <Map size={28} color="#475569" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Referral Source Heatmap</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Visualizing the geographic density of incoming institutional leads.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '16px', fontSize: '0.8rem', fontWeight: 700, color: '#475569', backgroundColor: '#F8FAFC', padding: '12px 16px', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                        <div style={{ width: '12px', height: '12px', borderRadius: '50%', backgroundColor: 'rgba(99, 102, 241, 0.8)' }}></div> Hospitals
                    </div>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                        <div style={{ width: '12px', height: '12px', borderRadius: '50%', backgroundColor: 'rgba(16, 185, 129, 0.8)' }}></div> Rehab
                    </div>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                        <div style={{ width: '12px', height: '12px', borderRadius: '50%', backgroundColor: 'rgba(245, 158, 11, 0.8)' }}></div> Physicians
                    </div>
                </div>
            </div>

            <div style={{ height: '500px', backgroundColor: '#F1F5F9', borderRadius: '12px', border: '1px solid #CBD5E1', position: 'relative', overflow: 'hidden' }}>
                {/* Simulated Street Map Background */}
                <div style={{ position: 'absolute', top: 0, left: 0, right: 0, bottom: 0, opacity: 0.15, backgroundImage: 'linear-gradient(#94A3B8 1px, transparent 1px), linear-gradient(90deg, #94A3B8 1px, transparent 1px)', backgroundSize: '40px 40px' }} />

                {/* Heatmap Bubbles Layer */}
                <svg width="100%" height="100%" style={{ position: 'absolute', top: 0, left: 0, zIndex: 10 }}>
                    {locations.map(loc => (
                        <g 
                            key={loc.id} 
                            transform={`translate(${loc.coordinates.x}, ${loc.coordinates.y})`}
                            onMouseEnter={() => setHoveredNode(loc)}
                            onMouseLeave={() => setHoveredNode(null)}
                            style={{ cursor: 'pointer' }}
                        >
                            {/* Outer Glow (Volume Indicator) */}
                            <circle 
                                r={Math.max(20, loc.referralVolume * 0.8)} 
                                fill={getBubbleColor(loc.type)} 
                                style={{ transition: 'all 0.3s ease-out' }}
                            />
                            {/* Inner Core */}
                            <circle r="6" fill="white" stroke="#334155" strokeWidth="2" />
                            {hoveredNode?.id === loc.id && (
                                <circle r={Math.max(20, loc.referralVolume * 0.8) + 5} fill="none" stroke="#0F172A" strokeWidth="2" strokeDasharray="4 4" className="animate-spin-slow" />
                            )}
                        </g>
                    ))}
                </svg>

                {/* Hover Tooltip Overlay */}
                {hoveredNode && (
                    <div style={{ 
                        position: 'absolute', 
                        left: hoveredNode.coordinates.x + 20, 
                        top: hoveredNode.coordinates.y - 40,
                        backgroundColor: 'white',
                        padding: '16px',
                        borderRadius: '12px',
                        border: '1px solid #E2E8F0',
                        boxShadow: '0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05)',
                        zIndex: 20,
                        width: '240px',
                        pointerEvents: 'none'
                    }}>
                        <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '1rem', marginBottom: '8px' }}>{hoveredNode.name}</div>
                        <div style={{ fontSize: '0.8rem', color: '#64748B', display: 'flex', alignItems: 'center', gap: '6px', marginBottom: '12px' }}>
                            <MapPin size={14} /> {hoveredNode.address}
                        </div>
                        <div style={{ backgroundColor: '#F8FAFC', padding: '12px', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                             <div style={{ fontSize: '0.75rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Annual Lead Volume</div>
                             <div style={{ fontSize: '1.4rem', fontWeight: 900, color: '#0369A1', display: 'flex', alignItems: 'center', gap: '6px' }}>
                                 <Activity size={18} /> {hoveredNode.referralVolume * 3} Leads
                             </div>
                        </div>
                    </div>
                )}
            </div>
            
            <div style={{ display: 'flex', justifyContent: 'flex-end', marginTop: '16px' }}>
                <button style={{ backgroundColor: 'white', border: '1px solid #CBD5E1', padding: '10px 16px', borderRadius: '8px', fontWeight: 600, color: '#334155', display: 'flex', alignItems: 'center', gap: '8px', cursor: 'pointer' }}>
                    <Search size={16} /> Load Expansion Markets
                </button>
            </div>
        </div>
    );
};

import React, { useState } from 'react';
import { Map, MapPin, Users, Target, Activity, Search, ShieldAlert } from 'lucide-react';

interface Territory {
    id: string;
    name: string;
    repName: string;
    activeLeads: number;
    closingRate: number;
    color: string;
    hospitals: string[];
}

export const SalesTerritoryMap: React.FC = () => {
    const [territories] = useState<Territory[]>([
        { id: 'T1', name: 'Downtown Medical District', repName: 'Sarah Jenkins', activeLeads: 42, closingRate: 28.5, color: '#3B82F6', hospitals: ['General Hospital', 'St. Jude Childrens'] },
        { id: 'T2', name: 'Westside Suburbs', repName: 'Marcus Cole', activeLeads: 85, closingRate: 15.2, color: '#10B981', hospitals: ['Westside Regional', 'Canyon Creek Rehab'] },
        { id: 'T3', name: 'North Hills Retirement Hub', repName: 'Elena Rostova', activeLeads: 112, closingRate: 41.0, color: '#8B5CF6', hospitals: ['North Hills Seniors', 'Valley View Hospice'] }
    ]);

    const [selectedTerritory, setSelectedTerritory] = useState<string>('T1');

    const activeT = territories.find(t => t.id === selectedTerritory);

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F8FAFC', padding: '12px', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                        <Map size={28} color="#475569" />
                    </div>
                    <div>
                        <h3 data-cy="h3-sales-territory-map-0" style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Sales Territory Alignment</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Prevent internal cannibalization by assigning explicit ZIP codes and hospital networks.</p>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '24px', height: '400px' }}>
                {/* Geofence Map Area */}
                <div style={{ flex: 2, backgroundColor: '#F1F5F9', borderRadius: '12px', border: '1px solid #CBD5E1', position: 'relative', overflow: 'hidden', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    {/* Map Background */}
                    <div style={{ position: 'absolute', top: 0, left: 0, right: 0, bottom: 0, opacity: 0.1, backgroundImage: 'radial-gradient(#475569 1px, transparent 1px)', backgroundSize: '20px 20px' }} />
                    
                    {/* SVG Territory Polygons */}
                    <svg width="100%" height="100%" style={{ position: 'relative', zIndex: 1 }}>
                        <polygon 
                            points="50,50 250,80 280,200 100,280" 
                            fill={territories[0].color} fillOpacity={selectedTerritory === 'T1' ? 0.6 : 0.2} stroke={territories[0].color} strokeWidth="3" 
                            onClick={() => setSelectedTerritory('T1')}
                            style={{ cursor: 'pointer', transition: 'all 0.3s' }}
                        />
                        <polygon 
                            points="280,200 450,150 550,300 400,380 200,350" 
                            fill={territories[1].color} fillOpacity={selectedTerritory === 'T2' ? 0.6 : 0.2} stroke={territories[1].color} strokeWidth="3"
                            onClick={() => setSelectedTerritory('T2')}
                            style={{ cursor: 'pointer', transition: 'all 0.3s' }}
                        />
                        <polygon 
                            points="250,80 500,20 650,120 450,150" 
                            fill={territories[2].color} fillOpacity={selectedTerritory === 'T3' ? 0.6 : 0.2} stroke={territories[2].color} strokeWidth="3"
                            onClick={() => setSelectedTerritory('T3')}
                            style={{ cursor: 'pointer', transition: 'all 0.3s' }}
                        />

                        {/* Hospital Pins */}
                        {activeT && <MapPin fill="white" color={activeT.color} size={32} x="300" y="200" style={{ pointerEvents: 'none' }}/>}
                    </svg>

                    <div style={{ position: 'absolute', bottom: '16px', right: '16px', backgroundColor: 'rgba(255,255,255,0.9)', padding: '8px 16px', borderRadius: '24px', fontSize: '0.8rem', fontWeight: 700, display: 'flex', alignItems: 'center', gap: '8px', boxShadow: '0 2px 4px rgba(0,0,0,0.1)' }}>
                        <Search size={14} /> ZIP boundaries enforced natively.
                    </div>
                </div>

                {/* Territory Inspector */}
                <div style={{ flex: 1, backgroundColor: 'white', borderRadius: '12px', border: '1px solid #E2E8F0', padding: '24px', display: 'flex', flexDirection: 'column' }}>
                    {activeT ? (
                        <>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '8px' }}>
                                <div style={{ width: '16px', height: '16px', borderRadius: '4px', backgroundColor: activeT.color }}></div>
                                <h4 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>{activeT.name}</h4>
                            </div>
                            
                            <div style={{ fontSize: '0.9rem', color: '#64748B', display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '24px', fontWeight: 600 }}>
                                <Users size={16} /> Regional Director: {activeT.repName}
                            </div>

                            <div style={{ display: 'flex', gap: '16px', marginBottom: '24px' }}>
                                <div style={{ flex: 1, backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                                    <div style={{ fontSize: '0.75rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase', marginBottom: '4px' }}>Active Leads</div>
                                    <div style={{ fontSize: '1.4rem', fontWeight: 900, color: '#0F172A' }}>{activeT.activeLeads}</div>
                                </div>
                                <div style={{ flex: 1, backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                                    <div style={{ fontSize: '0.75rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase', marginBottom: '4px' }}>Closing Rate</div>
                                    <div style={{ fontSize: '1.4rem', fontWeight: 900, color: activeT.closingRate > 30 ? '#10B981' : '#F59E0B' }}>{activeT.closingRate}%</div>
                                </div>
                            </div>

                            <div style={{ fontWeight: 700, color: '#334155', marginBottom: '12px', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                <Target size={16} /> Anchored Hospitals
                            </div>
                            <div style={{ display: 'flex', flexDirection: 'column', gap: '8px', flex: 1 }}>
                                {activeT.hospitals.map(h => (
                                    <div key={h} style={{ backgroundColor: '#F1F5F9', padding: '10px 16px', borderRadius: '6px', fontSize: '0.9rem', color: '#475569', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                        <Activity size={14} color={activeT.color} /> {h}
                                    </div>
                                ))}
                            </div>
                            
                            <button data-cy="btn-sales-territory-map-0" style={{ backgroundColor: 'white', color: '#0F172A', border: '1px solid #CBD5E1', borderRadius: '8px', padding: '12px', fontWeight: 600, cursor: 'pointer', marginTop: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px' }}>
                                Reassign Territory Boundaries
                            </button>
                        </>
                    ) : (
                        <div style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#94A3B8' }}>
                            Select a region.
                        </div>
                    )}
                </div>
            </div>

            <div style={{ marginTop: '24px', backgroundColor: '#FFFBEB', padding: '16px', borderRadius: '8px', border: '1px solid #FDE68A', fontSize: '0.85rem', color: '#92400E', display: 'flex', alignItems: 'flex-start', gap: '12px' }}>
                <ShieldAlert size={20} color="#D97706" style={{ flexShrink: 0 }} />
                <div style={{ lineHeight: 1.5 }}>
                    <strong>Territory Conflict Prevention:</strong> If a lead inquiry arrives from ZIP Code <code>90210</code>, they are automatically hard-routed into Elena Rostova's Hubspot pipeline. This strictly prevents commission theft and guarantees hospital networks only interface with their single designated Account Executive.
                </div>
            </div>
        </div>
    );
};

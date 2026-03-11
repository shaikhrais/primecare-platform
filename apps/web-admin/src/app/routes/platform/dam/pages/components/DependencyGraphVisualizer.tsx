import React, { useState } from 'react';
import { GitMerge, Hexagon, Component, Link, Circle } from 'lucide-react';

export const DependencyGraphVisualizer: React.FC = () => {
    const [selectedNode, setSelectedNode] = useState<string | null>('PrimaryButton');

    // Mocks D3 interaction data
    const activeDependencies = [
        { id: '1', name: 'LoginForm.tsx', type: 'page', impact: 'critical' },
        { id: '2', name: 'WaitlistSignup.tsx', type: 'page', impact: 'high' },
        { id: '3', name: 'StandardModal.tsx', type: 'component', impact: 'medium' },
        { id: '4', name: 'ShiftScheduler.tsx', type: 'page', impact: 'critical' }
    ];

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#F0FDF4', padding: '10px', borderRadius: '8px' }}>
                        <GitMerge size={24} color="#16A34A" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Dependency Impact Graph</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Visualize which top-level routes break if an Atom is altered.</p>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '24px', height: '400px' }}>
                
                {/* Mocked D3 Force Graph Canvas */}
                <div style={{ flex: 2, backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', position: 'relative', overflow: 'hidden', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    {/* Simplified SVG representation of a D3 node network */}
                    <svg width="100%" height="100%" style={{ position: 'absolute' }}>
                        {/* Edges */}
                        <line x1="50%" y1="50%" x2="20%" y2="20%" stroke="#CBD5E1" strokeWidth="2" strokeDasharray="4" />
                        <line x1="50%" y1="50%" x2="80%" y2="20%" stroke="#CBD5E1" strokeWidth="2" />
                        <line x1="50%" y1="50%" x2="20%" y2="80%" stroke="#CBD5E1" strokeWidth="2" strokeDasharray="4" />
                        <line x1="50%" y1="50%" x2="80%" y2="80%" stroke="#CBD5E1" strokeWidth="2" />
                        
                        {/* Parent Pages (Nodes) */}
                        <circle cx="20%" cy="20%" r="24" fill="#EFF6FF" stroke="#2563EB" strokeWidth="3" />
                        <circle cx="80%" cy="20%" r="24" fill="#EFF6FF" stroke="#2563EB" strokeWidth="3" />
                        <circle cx="20%" cy="80%" r="24" fill="#FAF5FF" stroke="#9333EA" strokeWidth="3" />
                        <circle cx="80%" cy="80%" r="24" fill="#EFF6FF" stroke="#2563EB" strokeWidth="3" />
                        
                        {/* Center Target Node */}
                        <circle cx="50%" cy="50%" r="32" fill="#F0FDF4" stroke="#16A34A" strokeWidth="4" />
                        <text x="50%" y="50%" dominantBaseline="middle" textAnchor="middle" fill="#14532D" fontSize="12" fontWeight="bold">PrimaryBtn</text>
                    </svg>

                    <div style={{ position: 'absolute', bottom: '16px', left: '16px', display: 'flex', gap: '12px', fontSize: '0.75rem', fontWeight: 700, color: '#64748B' }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '4px' }}><Circle size={12} color="#16A34A" /> Selected Target</div>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '4px' }}><Circle size={12} color="#2563EB" /> Page Route</div>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '4px' }}><Circle size={12} color="#9333EA" /> Composite Node</div>
                    </div>
                </div>

                {/* Impact Inspector Panel */}
                <div style={{ flex: 1, backgroundColor: 'white', borderRadius: '8px', border: '1px solid #E2E8F0', padding: '20px', display: 'flex', flexDirection: 'column' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px', paddingBottom: '16px', borderBottom: '1px solid #E2E8F0' }}>
                        <Hexagon size={20} color="#10B981" />
                        <div>
                            <div style={{ fontWeight: 800, color: '#0F172A' }}>{selectedNode}</div>
                            <div style={{ fontSize: '0.8rem', color: '#64748B' }}>Inherited by {activeDependencies.length} parents</div>
                        </div>
                    </div>

                    <h4 style={{ margin: '0 0 12px 0', fontSize: '0.8rem', color: '#475569', textTransform: 'uppercase', letterSpacing: '0.5px' }}>Blast Radius</h4>
                    
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '12px', overflowY: 'auto' }}>
                        {activeDependencies.map(dep => (
                            <div key={dep.id} style={{ display: 'flex', alignItems: 'center', gap: '12px', padding: '10px', backgroundColor: '#F8FAFC', borderRadius: '6px', border: '1px solid #E2E8F0' }}>
                                {dep.type === 'page' ? <Link size={16} color="#3B82F6" /> : <Component size={16} color="#8B5CF6" />}
                                <div style={{ flex: 1 }}>
                                    <div style={{ fontSize: '0.85rem', fontWeight: 700, color: '#0F172A' }}>{dep.name}</div>
                                </div>
                                {dep.impact === 'critical' && <span style={{ backgroundColor: '#FEF2F2', color: '#DC2626', padding: '2px 6px', borderRadius: '4px', fontSize: '0.65rem', fontWeight: 800 }}>CRITICAL</span>}
                            </div>
                        ))}
                    </div>
                </div>

            </div>
        </div>
    );
};

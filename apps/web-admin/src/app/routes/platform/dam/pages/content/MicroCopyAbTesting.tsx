import React, { useState } from 'react';
import { SplitSquareHorizontal, MoveRight, Users, Play, Pause, BarChart3, GripHorizontal } from 'lucide-react';

interface CopyTest {
    id: string;
    targetComponentSpan: string;
    variantA: string;
    variantB: string;
    status: 'RUNNING' | 'PAUSED' | 'CONCLUDED';
    trafficSplit: number; // Percentage sent to A
    conversionsA: number;
    conversionsB: number;
    impressionsA: number;
    impressionsB: number;
}

export const MicroCopyAbTesting: React.FC = () => {
    const [tests, setTests] = useState<CopyTest[]>([
        { id: '1', targetComponentSpan: 'CheckoutButton.Label', variantA: 'Submit Payment', variantB: 'Secure Checkout', status: 'RUNNING', trafficSplit: 50, conversionsA: 420, impressionsA: 5000, conversionsB: 610, impressionsB: 5000 },
        { id: '2', targetComponentSpan: 'IntakeForm.ZipHelper', variantA: 'Enter your Zip Code', variantB: 'What is your 5-digit ZIP?', status: 'RUNNING', trafficSplit: 50, conversionsA: 112, impressionsA: 800, conversionsB: 89, impressionsB: 800 },
        { id: '3', targetComponentSpan: 'HeroBanner.SubHeadline', variantA: 'Premium elderly care at home.', variantB: 'Compassionate care, wherever you are.', status: 'CONCLUDED', trafficSplit: 10, conversionsA: 1500, impressionsA: 20000, conversionsB: 4200, impressionsB: 20000 }
    ]);

    const toggleTest = (id: string, current: string) => {
        if (current === 'CONCLUDED') return;
        setTests(prev => prev.map(t => t.id === id ? { ...t, status: current === 'RUNNING' ? 'PAUSED' : 'RUNNING' } : t));
    };

    const calculateConvRate = (conv: number, imp: number) => {
        if (imp === 0) return 0;
        return ((conv / imp) * 100).toFixed(1);
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#F0FDF4', padding: '10px', borderRadius: '8px' }}>
                        <SplitSquareHorizontal size={24} color="#16A34A" />
                    </div>
                    <div>
                        <h3 data-cy="h3-micro-copy-ab-testing-0" style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Micro-copy A/B Testing</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Scientifically test UI string variants to maximize user conversion.</p>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
                {tests.map(test => {
                    const rateA = parseFloat(String(calculateConvRate(test.conversionsA, test.impressionsA)));
                    const rateB = parseFloat(String(calculateConvRate(test.conversionsB, test.impressionsB)));
                    const winner = rateA > rateB ? 'A' : (rateB > rateA ? 'B' : 'TIE');

                    return (
                        <div key={test.id} style={{ border: '1px solid #E2E8F0', borderRadius: '8px', overflow: 'hidden' }}>
                            <div style={{ backgroundColor: '#F8FAFC', padding: '12px 16px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: '1px solid #E2E8F0' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                                    <div style={{ fontFamily: 'monospace', fontWeight: 700, color: '#0F172A', backgroundColor: '#E2E8F0', padding: '4px 8px', borderRadius: '6px', fontSize: '0.8rem' }}>
                                        {test.targetComponentSpan}
                                    </div>
                                    <span style={{ fontSize: '0.8rem', color: '#64748B', display: 'flex', alignItems: 'center', gap: '6px' }}><Users size={14} /> {(test.impressionsA + test.impressionsB).toLocaleString()} views</span>
                                </div>
                                
                                <button 
                                    data-cy={`btn-toggle-ab-test-${test.id}`}
                                    onClick={() => toggleTest(test.id, test.status)}
                                    disabled={test.status === 'CONCLUDED'}
                                    style={{ 
                                        background: 'transparent', border: 'none', cursor: test.status === 'CONCLUDED' ? 'not-allowed' : 'pointer', 
                                        display: 'flex', alignItems: 'center', gap: '6px', fontSize: '0.8rem', fontWeight: 700,
                                        color: test.status === 'RUNNING' ? '#10B981' : test.status === 'PAUSED' ? '#F59E0B' : '#64748B'
                                    }}
                                >
                                    {test.status === 'RUNNING' && <><Pause size={16} /> PAUSE TEST</>}
                                    {test.status === 'PAUSED' && <><Play size={16} /> RESUME TEST</>}
                                    {test.status === 'CONCLUDED' && <><BarChart3 size={16} /> TEST CONCLUDED</>}
                                </button>
                            </div>

                            <div style={{ display: 'flex', padding: '24px', gap: '48px', alignItems: 'center', position: 'relative' }}>
                                {/* Variant A */}
                                <div style={{ flex: 1, border: `2px solid ${winner === 'A' && test.status !== 'PAUSED' ? '#10B981' : '#E2E8F0'}`, borderRadius: '8px', padding: '16px', backgroundColor: winner === 'A' && test.status !== 'PAUSED' ? '#ECFDF5' : 'white', position: 'relative' }}>
                                    {winner === 'A' && test.status !== 'PAUSED' && <div style={{ position: 'absolute', top: '-12px', left: '16px', backgroundColor: '#10B981', color: 'white', fontSize: '0.7rem', fontWeight: 800, padding: '2px 8px', borderRadius: '12px' }}>WINNING</div>}
                                    <h4 style={{ margin: '0 0 12px 0', fontSize: '0.85rem', color: '#64748B', display: 'flex', justifyContent: 'space-between' }}>
                                        <span>Variant A (Control)</span>
                                        <span style={{ color: '#0F172A' }}>{test.trafficSplit}% Traffic</span>
                                    </h4>
                                    <div style={{ fontSize: '1.1rem', fontWeight: 600, color: '#0F172A', marginBottom: '16px' }}>"{test.variantA}"</div>
                                    
                                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'baseline' }}>
                                        <span style={{ fontSize: '2rem', fontWeight: 800, color: winner === 'A' ? '#10B981' : '#0F172A' }}>{calculateConvRate(test.conversionsA, test.impressionsA)}%</span>
                                        <span style={{ fontSize: '0.8rem', color: '#64748B' }}>{test.conversionsA} conversions</span>
                                    </div>
                                </div>

                                {/* VS Divider */}
                                <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', color: '#CBD5E1' }}>
                                    <GripHorizontal size={24} />
                                    <span style={{ fontSize: '0.8rem', fontWeight: 800 }}>VS</span>
                                </div>

                                {/* Variant B */}
                                <div style={{ flex: 1, border: `2px solid ${winner === 'B' && test.status !== 'PAUSED' ? '#10B981' : '#E2E8F0'}`, borderRadius: '8px', padding: '16px', backgroundColor: winner === 'B' && test.status !== 'PAUSED' ? '#ECFDF5' : 'white', position: 'relative' }}>
                                    {winner === 'B' && test.status !== 'PAUSED' && <div style={{ position: 'absolute', top: '-12px', left: '16px', backgroundColor: '#10B981', color: 'white', fontSize: '0.7rem', fontWeight: 800, padding: '2px 8px', borderRadius: '12px' }}>WINNING</div>}
                                    <h4 style={{ margin: '0 0 12px 0', fontSize: '0.85rem', color: '#64748B', display: 'flex', justifyContent: 'space-between' }}>
                                        <span>Variant B (Challenger)</span>
                                        <span style={{ color: '#0F172A' }}>{100 - test.trafficSplit}% Traffic</span>
                                    </h4>
                                    <div style={{ fontSize: '1.1rem', fontWeight: 600, color: '#0F172A', marginBottom: '16px' }}>"{test.variantB}"</div>
                                    
                                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'baseline' }}>
                                        <span style={{ fontSize: '2rem', fontWeight: 800, color: winner === 'B' ? '#10B981' : '#0F172A' }}>{calculateConvRate(test.conversionsB, test.impressionsB)}%</span>
                                        <span style={{ fontSize: '0.8rem', color: '#64748B' }}>{test.conversionsB} conversions</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    );
                })}
            </div>
        </div>
    );
};

import React from 'react';
import { WoundCanvas } from './components/WoundCanvas';
import { Camera } from 'lucide-react';

export default function WoundCareDashboard() {
    return (
        <div style={{ padding: '0 24px 100px 24px', maxWidth: '1200px', margin: '0 auto' }}>
            
            <header style={{ marginBottom: '32px', borderBottom: '1px solid #E2E8F0', paddingBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#FEE2E2', padding: '16px', borderRadius: '16px' }}>
                        <Camera size={32} color="#EF4444" />
                    </div>
                    <div>
                        <h1 style={{ fontSize: '2rem', fontWeight: 900, color: '#0F172A', margin: '0 0 8px 0' }}>Wound Analysis</h1>
                        <p style={{ fontSize: '1.1rem', color: '#64748B', margin: 0 }}>Patient: Beatrice Morrison (pat_123)</p>
                    </div>
                </div>
            </header>

            <div style={{ display: 'grid', gridTemplateColumns: 'minmax(0, 1fr) 350px', gap: '32px' }}>
                
                {/* Canvas Area */}
                <div>
                     <WoundCanvas />
                </div>

                {/* Sider (Mock Context) */}
                <div style={{ display: 'flex', flexDirection: 'column', gap: '24px' }}>
                    
                    <div style={{ backgroundColor: '#F8FAFC', padding: '24px', borderRadius: '16px', border: '1px solid #E2E8F0' }}>
                        <h3 style={{ margin: '0 0 16px 0', fontSize: '1.25rem', color: '#0F172A', fontWeight: 800 }}>Clinical Directive</h3>
                        <p style={{ color: '#475569', lineHeight: '1.5', margin: 0 }}>
                            Assess sacral ulcer. Trace boundaries of necrotic tissue using the red draw tool. Drop pins at deepest points for measurement documentation.
                        </p>
                    </div>

                    <div style={{ backgroundColor: '#FEF2F2', padding: '24px', borderRadius: '16px', border: '1px solid #FECACA' }}>
                        <h3 style={{ margin: '0 0 16px 0', fontSize: '1.1rem', color: '#991B1B', fontWeight: 800 }}>Previous Reading (7 days ago)</h3>
                        <ul style={{ margin: 0, paddingLeft: '20px', color: '#B91C1C' }}>
                            <li>Size: 4cm x 3cm</li>
                            <li>Depth: 0.5cm</li>
                            <li>Exudate: Moderate, serosanguinous</li>
                        </ul>
                    </div>
                    
                </div>
            </div>

        </div>
    );
}

import React, { useState, useEffect } from 'react';
import { Camera, RefreshCw, Zap } from 'lucide-react';

interface TrackerProps {
    patientId: string;
}

export const WoundVisionTracker: React.FC<TrackerProps> = ({ patientId }) => {
    const [analyzing, setAnalyzing] = useState(false);
    const [result, setResult] = useState<{ area: number; improvement: number } | null>(null);

    const triggerMockVisionAnalysis = () => {
        setAnalyzing(true);
        // Simulate sending base64 canvas image to Python OpenCV worker
        setTimeout(() => {
            setResult({
                area: 4.2, // cm squared
                improvement: 15.5 // percent smaller than last week
            });
            setAnalyzing(false);
        }, 2000);
    };

    return (
        <div style={{ padding: '16px', backgroundColor: '#F8FAFC', borderRadius: '12px', border: '1px solid #E2E8F0', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
                <h3 style={{ margin: 0, fontSize: '1rem', color: '#1E293B', display: 'flex', alignItems: 'center', gap: '8px' }}>
                    <Zap size={18} color="#8B5CF6" />
                    AI Vision Analysis
                </h3>
                <button 
                    onClick={triggerMockVisionAnalysis}
                    disabled={analyzing}
                    style={{ 
                        display: 'flex', alignItems: 'center', gap: '6px', backgroundColor: '#8B5CF6', 
                        color: 'white', border: 'none', padding: '6px 12px', borderRadius: '6px', 
                        cursor: analyzing ? 'not-allowed' : 'pointer', opacity: analyzing ? 0.7 : 1, fontWeight: 600, fontSize: '0.85rem'
                    }}
                >
                    {analyzing ? <RefreshCw size={14} className="spin" /> : <Camera size={14} />}
                    {analyzing ? 'Scanning...' : 'Analyze Surface Area'}
                </button>
                <style>{`.spin { animation: spin 1s linear infinite; } @keyframes spin { 100% { transform: rotate(360deg); } }`}</style>
            </div>

            {result && (
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '12px' }}>
                    <div style={{ backgroundColor: 'white', padding: '12px', borderRadius: '8px', border: '1px solid #E2E8F0' }}>
                        <div style={{ fontSize: '0.75rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase', marginBottom: '4px' }}>Estimated Area</div>
                        <div style={{ fontSize: '1.5rem', fontWeight: 800, color: '#0F172A' }}>{result.area} <span style={{ fontSize: '1rem', color: '#64748B' }}>cm²</span></div>
                    </div>
                    <div style={{ backgroundColor: '#F0FDF4', padding: '12px', borderRadius: '8px', border: '1px solid #BBF7D0' }}>
                        <div style={{ fontSize: '0.75rem', color: '#166534', fontWeight: 700, textTransform: 'uppercase', marginBottom: '4px' }}>Healing Trajectory</div>
                        <div style={{ fontSize: '1.5rem', fontWeight: 800, color: '#15803D' }}>-{result.improvement}% <span style={{ fontSize: '0.85rem', fontWeight: 600 }}>since last week</span></div>
                    </div>
                </div>
            )}
        </div>
    );
};

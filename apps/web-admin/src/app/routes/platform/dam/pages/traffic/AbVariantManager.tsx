import React, { useState } from 'react';
import { Route, Save, Users, AlertTriangle, ArrowRight } from 'lucide-react';

interface Variant {
    id: string;
    componentAlias: string;
    trafficWeight: number; // Percentage
    status: 'ACTIVE' | 'DRAFT' | 'PAUSED';
    clicks: number;
}

export const AbVariantManager: React.FC = () => {
    const [variants, setVariants] = useState<Variant[]>([
        { id: 'v1', componentAlias: 'HomePageHeroV1 (Control)', trafficWeight: 80, status: 'ACTIVE', clicks: 1420 },
        { id: 'v2', componentAlias: 'HomePageHeroV2 (Test)', trafficWeight: 20, status: 'ACTIVE', clicks: 312 },
        { id: 'v3', componentAlias: 'HomePageHeroV3 (Aggressive)', trafficWeight: 0, status: 'DRAFT', clicks: 0 }
    ]);
    
    const [isDeploying, setIsDeploying] = useState(false);

    const handleWeightChange = (id: string, newWeight: number) => {
        setVariants(prev => prev.map(v => v.id === id ? { ...v, trafficWeight: newWeight } : v));
    };

    const validateWeights = (): boolean => {
        const total = variants.filter(v => ['ACTIVE', 'PAUSED'].includes(v.status)).reduce((sum, v) => sum + v.trafficWeight, 0);
        return total === 100;
    };

    const handleDeploy = () => {
        if (!validateWeights()) return;
        setIsDeploying(true);
        setTimeout(() => {
            setIsDeploying(false);
            alert("Traffic routing rules persisted to Edge CDN.");
        }, 1200);
    };

    const totalWeight = variants.filter(v => ['ACTIVE', 'PAUSED'].includes(v.status)).reduce((sum, v) => sum + v.trafficWeight, 0);
    const weightIsValid = totalWeight === 100;

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#FFF7ED', padding: '10px', borderRadius: '8px' }}>
                        <Route size={24} color="#F97316" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>A/B Traffic Routing</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Dynamically split user traffic between component variations.</p>
                    </div>
                </div>
                
                <button 
                    onClick={handleDeploy}
                    disabled={isDeploying || !weightIsValid}
                    style={{ 
                        backgroundColor: '#F97316', color: 'white', border: 'none', borderRadius: '8px', padding: '10px 16px', 
                        fontWeight: 700, cursor: (isDeploying || !weightIsValid) ? 'not-allowed' : 'pointer', 
                        opacity: (isDeploying || !weightIsValid) ? 0.6 : 1, display: 'flex', alignItems: 'center', gap: '8px' 
                    }}
                >
                    <Save size={16} /> Deploy Routing Rules
                </button>
            </div>

            {!weightIsValid && (
                <div style={{ backgroundColor: '#FEF2F2', padding: '12px', borderRadius: '8px', border: '1px solid #FECACA', display: 'flex', alignItems: 'center', gap: '8px', color: '#991B1B', marginBottom: '20px', fontSize: '0.9rem' }}>
                    <AlertTriangle size={18} />
                    <strong>Validation Error:</strong> Traffic weights must exactly equal 100%. Current total: {totalWeight}%.
                </div>
            )}

            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                {variants.map(v => (
                    <div key={v.id} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '16px', backgroundColor: v.status === 'DRAFT' ? '#F8FAFC' : 'white', border: '1px solid #E2E8F0', borderRadius: '8px' }}>
                        <div style={{ flex: 1 }}>
                            <div style={{ fontWeight: 700, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                {v.componentAlias}
                                {v.status === 'DRAFT' && <span style={{ backgroundColor: '#E2E8F0', color: '#475569', fontSize: '0.7rem', padding: '2px 6px', borderRadius: '12px' }}>DRAFT</span>}
                            </div>
                            <div style={{ fontSize: '0.8rem', color: '#64748B', marginTop: '4px', display: 'flex', alignItems: 'center', gap: '4px' }}>
                                <Users size={12} /> {v.clicks} unique engagements
                            </div>
                        </div>
                        
                        <div style={{ display: 'flex', alignItems: 'center', gap: '16px', width: '300px' }}>
                            <input 
                                type="range" 
                                min="0" max="100" 
                                value={v.trafficWeight} 
                                disabled={v.status === 'DRAFT'}
                                onChange={(e) => handleWeightChange(v.id, parseInt(e.target.value))}
                                style={{ flex: 1, accentColor: '#F97316', opacity: v.status === 'DRAFT' ? 0.3 : 1 }}
                            />
                            <div style={{ width: '60px', textAlign: 'right', fontWeight: 800, color: v.trafficWeight > 0 ? '#F97316' : '#94A3B8' }}>
                                {v.trafficWeight}%
                            </div>
                        </div>
                    </div>
                ))}
            </div>
            
            <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px dashed #CBD5E1', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                <span style={{ fontSize: '0.85rem', color: '#475569', fontWeight: 600 }}>Active Test Target: `/platform/client/portal`</span>
                <span style={{ fontSize: '0.85rem', color: '#6366F1', fontWeight: 700, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '4px' }}>
                    View Conversion Metrics <ArrowRight size={14} />
                </span>
            </div>
        </div>
    );
};

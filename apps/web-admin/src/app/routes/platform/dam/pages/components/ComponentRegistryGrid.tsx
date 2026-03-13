import React, { useState } from 'react';
import { PackageSearch, Component, Box, Search, Layers, AlertCircle } from 'lucide-react';

interface ComponentData {
    id: string;
    alias: string;
    type: 'ATOM' | 'MOLECULE' | 'ORGANISM';
    status: 'ACTIVE' | 'DEPRECATED' | 'EXPERIMENTAL';
    usageCount: number;
    lastUpdated: string;
}

export const ComponentRegistryGrid: React.FC = () => {
    const [components, setComponents] = useState<ComponentData[]>([
        { id: 'c_btn', alias: 'PrimaryActionBtn', type: 'ATOM', status: 'ACTIVE', usageCount: 412, lastUpdated: '2 weeks ago' },
        { id: 'c_card', alias: 'MetricDataCard', type: 'MOLECULE', status: 'ACTIVE', usageCount: 89, lastUpdated: '1 month ago' },
        { id: 'c_form', alias: 'StandardIntakeForm', type: 'ORGANISM', status: 'ACTIVE', usageCount: 14, lastUpdated: '3 days ago' },
        { id: 'c_oldbtn', alias: 'LegacyRoundedButton', type: 'ATOM', status: 'DEPRECATED', usageCount: 3, lastUpdated: '2 years ago' },
        { id: 'c_ai', alias: 'AiPromptInput', type: 'MOLECULE', status: 'EXPERIMENTAL', usageCount: 2, lastUpdated: '1 hour ago' }
    ]);
    
    const [searchTerm, setSearchTerm] = useState('');

    const getTypeColor = (type: string) => {
        if (type === 'ATOM') return { bg: '#F0FDF4', text: '#16A34A' };
        if (type === 'MOLECULE') return { bg: '#EFF6FF', text: '#2563EB' };
        return { bg: '#FAF5FF', text: '#9333EA' }; // Organism
    };

    const filtered = components.filter(c => c.alias.toLowerCase().includes(searchTerm.toLowerCase()));

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#EEF2FF', padding: '10px', borderRadius: '8px' }}>
                        <PackageSearch size={24} color="#6366F1" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Component Registry</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Global directory of all active React UI digital assets.</p>
                    </div>
                </div>
                <div style={{ display: 'flex', gap: '8px' }}>
                    <div style={{ backgroundColor: '#F8FAFC', padding: '8px 12px', borderRadius: '6px', fontSize: '0.8rem', color: '#475569', fontWeight: 700, border: '1px solid #E2E8F0' }}>
                        Total Assets: {components.length}
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '16px', marginBottom: '20px' }}>
                <div style={{ flex: 1, position: 'relative' }}>
                    <Search size={18} color="#94A3B8" style={{ position: 'absolute', left: '12px', top: '12px' }} />
                    <input 
                        data-cy="component-registry-search"
                        type="text" 
                        placeholder="Search components by export name..." 
                        value={searchTerm}
                        onChange={e => setSearchTerm(e.target.value)}
                        style={{ width: '100%', padding: '10px 10px 10px 36px', borderRadius: '8px', border: '1px solid #CBD5E1', outline: 'none' }} 
                    />
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', gap: '16px' }}>
                {filtered.map(comp => {
                    const typeStyle = getTypeColor(comp.type);
                    return (
                        <div key={comp.id} style={{ border: '1px solid #E2E8F0', borderRadius: '8px', padding: '16px', display: 'flex', flexDirection: 'column', gap: '12px', transition: 'box-shadow 0.2s', cursor: 'pointer', backgroundColor: comp.status === 'DEPRECATED' ? '#FEF2F2' : 'white' }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#0F172A', fontWeight: 700, fontSize: '1.05rem' }}>
                                    <Component size={16} color="#64748B" /> {comp.alias}
                                </div>
                                <span style={{ backgroundColor: typeStyle.bg, color: typeStyle.text, padding: '2px 8px', borderRadius: '12px', fontSize: '0.7rem', fontWeight: 800, letterSpacing: '0.5px' }}>
                                    {comp.type}
                                </span>
                            </div>
                            
                            {comp.status === 'DEPRECATED' && (
                                <div style={{ backgroundColor: '#FEE2E2', padding: '6px 8px', borderRadius: '4px', fontSize: '0.75rem', color: '#991B1B', display: 'flex', alignItems: 'center', gap: '6px', fontWeight: 600 }}>
                                    <AlertCircle size={14} /> Sunset Warning
                                </div>
                            )}
                            
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: 'auto', paddingTop: '12px', borderTop: '1px dashed #E2E8F0' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '6px', fontSize: '0.8rem', color: '#64748B', fontWeight: 600 }}>
                                    <Layers size={14} /> {comp.usageCount} Instances
                                </div>
                                <div style={{ fontSize: '0.75rem', color: '#94A3B8' }}>
                                    Updated {comp.lastUpdated}
                                </div>
                            </div>
                        </div>
                    );
                })}
            </div>
            {filtered.length === 0 && (
                <div style={{ textAlign: 'center', padding: '48px', color: '#64748B' }}>
                    <Box size={40} color="#CBD5E1" style={{ margin: '0 auto 12px auto' }} />
                    <p style={{ margin: 0 }}>No components match your search.</p>
                </div>
            )}
        </div>
    );
};

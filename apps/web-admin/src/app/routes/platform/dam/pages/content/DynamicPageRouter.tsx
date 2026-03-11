import React, { useState } from 'react';
import { Route, Link2, Search, CheckCircle2, AlertTriangle, PlusCircle, Save } from 'lucide-react';

interface RouteAlias {
    id: string;
    internalComponentPath: string;
    publicUrlSlug: string;
    status: 'ACTIVE' | 'DRAFT' | 'REDIRECT';
}

export const DynamicPageRouter: React.FC = () => {
    const [aliases, setAliases] = useState<RouteAlias[]>([
        { id: '1', internalComponentPath: 'pages/users/family/CareFeed.tsx', publicUrlSlug: '/family-feed', status: 'ACTIVE' },
        { id: '2', internalComponentPath: 'pages/clinics/ContactUs.tsx', publicUrlSlug: '/get-in-touch', status: 'ACTIVE' },
        { id: '3', internalComponentPath: 'pages/legal/PrivacyPolicy.tsx', publicUrlSlug: '/privacy', status: 'REDIRECT' },
        { id: '4', internalComponentPath: 'pages/marketing/Pricing.tsx', publicUrlSlug: '/pricing-plans', status: 'DRAFT' }
    ]);
    const [isSaving, setIsSaving] = useState(false);

    const handleSave = () => {
        setIsSaving(true);
        setTimeout(() => {
            setIsSaving(false);
            alert("Edge proxy rules updated. New URL slugs will route to internal components globally within 60 seconds.");
        }, 1200);
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#EEF2FF', padding: '10px', borderRadius: '8px' }}>
                        <Route size={24} color="#4F46E5" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Dynamic Page Router</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Remap public URL slugs to internal React components dynamically.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <button style={{ backgroundColor: 'white', color: '#0F172A', border: '1px solid #CBD5E1', borderRadius: '8px', padding: '8px 16px', fontWeight: 600, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '6px' }}>
                        <PlusCircle size={16} color="#4F46E5" /> Map New Route
                    </button>
                    <button 
                        onClick={handleSave}
                        disabled={isSaving}
                        style={{ backgroundColor: '#4F46E5', color: 'white', border: 'none', borderRadius: '8px', padding: '8px 16px', fontWeight: 700, cursor: isSaving ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}
                    >
                        <Save size={16} /> {isSaving ? 'Syncing...' : 'Publish Route Map'}
                    </button>
                </div>
            </div>

            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.85rem' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, width: '40%' }}>Internal Component Path</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, width: '40%' }}>Public Display URL (Slug)</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Routing State</th>
                    </tr>
                </thead>
                <tbody>
                    {aliases.map(alias => (
                        <tr key={alias.id} style={{ borderBottom: '1px solid #E2E8F0' }}>
                            <td style={{ padding: '12px' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontFamily: 'monospace', color: '#64748B' }}>
                                    {alias.internalComponentPath}
                                </div>
                            </td>
                            <td style={{ padding: '12px' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                                    <Link2 size={16} color="#4F46E5" />
                                    <input 
                                        type="text" 
                                        value={alias.publicUrlSlug} 
                                        readOnly
                                        style={{ border: '1px solid #CBD5E1', padding: '6px 12px', borderRadius: '6px', width: '250px', outline: 'none', color: '#0F172A', fontWeight: 700, backgroundColor: '#F8FAFC' }}
                                    />
                                </div>
                            </td>
                            <td style={{ padding: '12px' }}>
                                {alias.status === 'ACTIVE' && <span style={{ backgroundColor: '#D1FAE5', color: '#065F46', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 700, display: 'inline-flex', alignItems: 'center', gap: '4px' }}><CheckCircle2 size={12}/> ACTIVE</span>}
                                {alias.status === 'DRAFT' && <span style={{ backgroundColor: '#F1F5F9', color: '#475569', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 700, display: 'inline-flex', alignItems: 'center', gap: '4px' }}>DRAFT</span>}
                                {alias.status === 'REDIRECT' && <span style={{ backgroundColor: '#FEF3C7', color: '#B45309', padding: '4px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 700, display: 'inline-flex', alignItems: 'center', gap: '4px' }}><AlertTriangle size={12}/> 301 REDIRECT</span>}
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
            
        </div>
    );
};

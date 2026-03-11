import React, { useState } from 'react';
import { Image as ImageIcon, Download, Lock, FileType, CheckCircle2, ShieldAlert } from 'lucide-react';

interface BrandAsset {
    id: string;
    filename: string;
    type: 'VECTOR' | 'IMAGE' | 'DOCUMENT';
    description: string;
    size: string;
    legalApproved: boolean;
}

export const BrandAssetLibrary: React.FC = () => {
    const [assets] = useState<BrandAsset[]>([
        { id: '1', filename: 'PrimeCare_Logo_Primary_CMYK.eps', type: 'VECTOR', description: 'Primary logo for print media (Billboards, Brochures).', size: '2.4 MB', legalApproved: true },
        { id: '2', filename: 'PrimeCare_Logo_White_RGB.svg', type: 'VECTOR', description: 'White knockout logo for dark website backgrounds.', size: '45 KB', legalApproved: true },
        { id: '3', filename: 'CEO_Headshot_Official_2023.jpg', type: 'IMAGE', description: 'Approved headshot for press releases and journalist inquiries.', size: '5.1 MB', legalApproved: true },
        { id: '4', filename: 'Brand_Guidelines_V4.pdf', type: 'DOCUMENT', description: 'Strict rules on logo clear-space, typography, and color hex codes.', size: '12.8 MB', legalApproved: true },
        { id: '5', filename: 'Old_Logo_DO_NOT_USE.png', type: 'IMAGE', description: 'Legacy logo from 2015. Outdated font.', size: '1.2 MB', legalApproved: false }
    ]);

    const getIcon = (type: string) => {
        switch(type) {
            case 'VECTOR': return <FileType size={20} color="#0284C7" />;
            case 'DOCUMENT': return <FileType size={20} color="#DC2626" />;
            case 'IMAGE': return <ImageIcon size={20} color="#10B981" />;
            default: return <FileType size={20} />;
        }
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F1F5F9', padding: '12px', borderRadius: '8px' }}>
                        <Lock size={28} color="#475569" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Locked Brand Asset Library</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>The single source of truth for Legal-approved logos, typography, and PR headshots.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', backgroundColor: '#DCFCE7', padding: '8px 16px', borderRadius: '8px', border: '1px solid #86EFAC', color: '#166534', fontWeight: 700, fontSize: '0.85rem' }}>
                    <CheckCircle2 size={16} /> Legal Review Passed: Nov 2023
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '20px' }}>
                {assets.map(asset => (
                    <div key={asset.id} style={{ border: `1px solid ${asset.legalApproved ? '#E2E8F0' : '#FECACA'}`, borderRadius: '12px', overflow: 'hidden', backgroundColor: asset.legalApproved ? 'white' : '#FEF2F2', display: 'flex', flexDirection: 'column' }}>
                        <div style={{ height: '140px', backgroundColor: asset.legalApproved ? '#F8FAFC' : '#FEE2E2', display: 'flex', alignItems: 'center', justifyContent: 'center', borderBottom: `1px solid ${asset.legalApproved ? '#E2E8F0' : '#FECACA'}` }}>
                            {getIcon(asset.type)}
                            <span style={{ marginLeft: '8px', fontWeight: 800, color: asset.legalApproved ? '#64748B' : '#DC2626', fontSize: '1.2rem' }}>.{asset.filename.split('.').pop()}</span>
                        </div>
                        
                        <div style={{ padding: '16px', flex: 1, display: 'flex', flexDirection: 'column' }}>
                            <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '1rem', wordBreak: 'break-all', marginBottom: '8px' }}>
                                {asset.filename}
                            </div>
                            <div style={{ fontSize: '0.85rem', color: '#475569', flex: 1, marginBottom: '16px' }}>
                                {asset.description}
                            </div>
                            
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: 'auto' }}>
                                <div style={{ fontSize: '0.75rem', color: '#94A3B8', fontWeight: 700 }}>{asset.size}</div>
                                
                                {asset.legalApproved ? (
                                    <button style={{ backgroundColor: '#0F172A', color: 'white', border: 'none', borderRadius: '6px', padding: '8px 16px', fontWeight: 700, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '6px', fontSize: '0.8rem' }}>
                                        <Download size={14} /> Download File
                                    </button>
                                ) : (
                                    <span style={{ color: '#DC2626', fontWeight: 800, fontSize: '0.75rem', display: 'flex', alignItems: 'center', gap: '4px', backgroundColor: '#FECACA', padding: '4px 8px', borderRadius: '4px' }}>
                                        <ShieldAlert size={12}/> RESTRICTED
                                    </span>
                                )}
                            </div>
                        </div>
                    </div>
                ))}
            </div>

            <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', fontSize: '0.85rem', color: '#475569' }}>
                <strong>Strict Governance:</strong> This library prevents local branch managers from using pixelated Google Image searches of the logo on their local print flyers. Only files explicitly flagged as `legalApproved: true` are accessible to lower-level employees.
            </div>
        </div>
    );
};

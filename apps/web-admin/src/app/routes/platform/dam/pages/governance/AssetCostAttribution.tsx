import React, { useState } from 'react';
import { DollarSign, Server, DownloadCloud, AlertOctagon, RefreshCw, HardDrive, BarChart3 } from 'lucide-react';

interface AssetCostRecord {
    id: string;
    assetName: string;
    mediaType: 'VIDEO (MP4/HLS)' | 'PDF' | 'IMAGE (WEBP)';
    fileSizeMb: number;
    monthlyDownloads: number;
    totalBandwidthGb: number;
    estimatedCostUsd: number;
}

export const AssetCostAttribution: React.FC = () => {
    const [assets, setAssets] = useState<AssetCostRecord[]>([
        { id: '1', assetName: 'v2_Onboarding_Training.mp4', mediaType: 'VIDEO (MP4/HLS)', fileSizeMb: 450, monthlyDownloads: 12000, totalBandwidthGb: 5273.4, estimatedCostUsd: 421.87 },
        { id: '2', assetName: 'Q3_Compliance_Audit_Form.pdf', mediaType: 'PDF', fileSizeMb: 12, monthlyDownloads: 45000, totalBandwidthGb: 527.3, estimatedCostUsd: 42.18 },
        { id: '3', assetName: 'NY_Hero_Banner_Background.webp', mediaType: 'IMAGE (WEBP)', fileSizeMb: 2.4, monthlyDownloads: 1800000, totalBandwidthGb: 4218.7, estimatedCostUsd: 337.50 },
        { id: '4', assetName: 'CEO_Townhall_July.mp4', mediaType: 'VIDEO (MP4/HLS)', fileSizeMb: 1250, monthlyDownloads: 250, totalBandwidthGb: 305.1, estimatedCostUsd: 24.40 }
    ]);

    const [isRefreshing, setIsRefreshing] = useState(false);

    const handleRefresh = () => {
        setIsRefreshing(true);
        setTimeout(() => {
            setIsRefreshing(false);
        }, 800);
    };

    const totalBandwidth = assets.reduce((sum, a) => sum + a.totalBandwidthGb, 0);
    const totalCost = assets.reduce((sum, a) => sum + a.estimatedCostUsd, 0);

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#F0FDF4', padding: '10px', borderRadius: '8px' }}>
                        <DollarSign size={24} color="#16A34A" />
                    </div>
                    <div>
                        <h3 data-cy="h3-asset-cost-attribution-0" style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Digital Asset Cost Attribution</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Trace AWS/Cloudflare CDN egress bills back to the specific offending files.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '12px' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '8px 16px', backgroundColor: '#F0F9FF', border: '1px solid #BAE6FD', borderRadius: '8px', color: '#0369A1', fontWeight: 800, fontSize: '0.9rem' }}>
                        <Server size={18} /> {totalBandwidth.toLocaleString()} GB Total Egress
                    </div>
                    <button 
                        data-cy="btn-sync-billing"
                        onClick={handleRefresh}
                        style={{ backgroundColor: 'white', color: '#0F172A', border: '1px solid #CBD5E1', borderRadius: '8px', padding: '8px 16px', fontWeight: 600, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}
                    >
                        <RefreshCw size={16} className={isRefreshing ? "animate-spin" : ""} /> Sync Billing DB
                    </button>
                </div>
            </div>

            <table data-cy="table-asset-cost-attribution" style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.9rem' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Registered Asset</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>Total Transferred</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>Estimated Cost (AWS S3)</th>
                    </tr>
                </thead>
                <tbody>
                    {assets.map(asset => (
                        <tr key={asset.id} style={{ borderBottom: '1px solid #E2E8F0' }}>
                            <td style={{ padding: '12px', verticalAlign: 'top' }}>
                                <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontWeight: 800, color: '#0F172A', fontFamily: 'monospace' }}>
                                        <HardDrive size={16} color="#64748B" /> {asset.assetName}
                                    </div>
                                    <div style={{ fontSize: '0.75rem', color: '#475569', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                        <span style={{ backgroundColor: '#F1F5F9', padding: '2px 6px', borderRadius: '4px' }}>{asset.mediaType}</span>
                                        <span>•</span>
                                        <span>{asset.fileSizeMb} MB Base Size</span>
                                    </div>
                                </div>
                            </td>
                            <td style={{ padding: '12px', verticalAlign: 'top', textAlign: 'right' }}>
                                <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-end', gap: '4px' }}>
                                    <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '1.1rem', display: 'flex', alignItems: 'center', gap: '6px' }}>
                                        {asset.totalBandwidthGb.toLocaleString()} <span style={{ fontSize: '0.8rem', color: '#64748B' }}>GB</span>
                                    </div>
                                    <div style={{ fontSize: '0.75rem', color: '#64748B' }}>
                                        From {(asset.monthlyDownloads / 1000).toFixed(1)}k distinct hits
                                    </div>
                                </div>
                            </td>
                            <td style={{ padding: '12px', verticalAlign: 'top', textAlign: 'right' }}>
                                <div style={{ fontWeight: 800, color: asset.estimatedCostUsd > 300 ? '#DC2626' : '#16A34A', fontSize: '1.1rem' }}>
                                    ${asset.estimatedCostUsd.toFixed(2)}
                                </div>
                            </td>
                        </tr>
                    ))}
                    
                    {/* Totals Row */}
                    <tr style={{ backgroundColor: '#F8FAFC' }}>
                        <td style={{ padding: '16px 12px', fontWeight: 800, color: '#0F172A' }}>TOTAL ATTRIBUTED COST (30 DAYS)</td>
                        <td style={{ padding: '16px 12px', textAlign: 'right', fontWeight: 800, color: '#0F172A' }}>{totalBandwidth.toLocaleString()} GB</td>
                        <td style={{ padding: '16px 12px', textAlign: 'right', fontWeight: 900, color: '#16A34A', fontSize: '1.2rem' }}>${totalCost.toFixed(2)}</td>
                    </tr>
                </tbody>
            </table>

            <div style={{ marginTop: '24px', backgroundColor: '#FFFBEB', padding: '16px', borderRadius: '8px', border: '1px solid #FDE68A', fontSize: '0.85rem', color: '#92400E', display: 'flex', alignItems: 'flex-start', gap: '12px' }}>
                <AlertOctagon size={20} color="#D97706" style={{ flexShrink: 0 }} />
                <div style={{ lineHeight: 1.5 }}>
                    <strong>Cost Optimization Context:</strong> The cloud bill isn't an abstract black box. By assigning exact bandwidth metrics to specific digital assets, the DAM team knows exactly where to apply heavy compression or move assets behind authentication walls to save the agency thousands of dollars per quarter.
                </div>
            </div>
        </div>
    );
};

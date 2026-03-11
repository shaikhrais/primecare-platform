import React, { useState } from 'react';
import { Activity, Zap, HardDrive, BarChart3, Server } from 'lucide-react';

interface MetricNode {
    id: string;
    label: string;
    bytesTransferred: number;
    requestCount: number;
    colorCode: string; // Red = hot, Blue = cold
}

export const MediaUsageHeatmap: React.FC = () => {
    const [viewMetric, setViewMetric] = useState<'bandwidth' | 'requests'>('bandwidth');

    const nodes: MetricNode[] = [
        { id: '1', label: 'orientation-module-1.mp4', bytesTransferred: 45000000000, requestCount: 320, colorCode: '#EF4444' }, // 45 GB
        { id: '2', label: 'hero-banner-spring.webp', bytesTransferred: 2500000000, requestCount: 14200, colorCode: '#F97316' }, // 2.5 GB
        { id: '3', label: 'w9-contractor-form.pdf', bytesTransferred: 84000000, requestCount: 1000, colorCode: '#3B82F6' }, // 84 MB
        { id: '4', label: 'logo-primary.svg', bytesTransferred: 15000000, requestCount: 45000, colorCode: '#10B981' } // 15 MB
    ];

    const formatBytes = (bytes: number) => {
        if (bytes === 0) return '0 B';
        const k = 1024;
        const sizes = ['B', 'KB', 'MB', 'GB', 'TB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#FFF7ED', padding: '10px', borderRadius: '8px' }}>
                        <Zap size={24} color="#F97316" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>CDN Usage Heatmap</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Visualize bandwidth spikes across global edge servers.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', backgroundColor: '#F1F5F9', borderRadius: '8px', padding: '4px' }}>
                    <button 
                        onClick={() => setViewMetric('bandwidth')}
                        style={{ padding: '8px 16px', borderRadius: '6px', border: 'none', cursor: 'pointer', backgroundColor: viewMetric === 'bandwidth' ? 'white' : 'transparent', color: viewMetric === 'bandwidth' ? '#0F172A' : '#64748B', fontWeight: viewMetric === 'bandwidth' ? 700 : 500, boxShadow: viewMetric === 'bandwidth' ? '0 1px 3px rgba(0,0,0,0.1)' : 'none', display: 'flex', alignItems: 'center', gap: '6px' }}
                    >
                        <HardDrive size={16} /> Bandwidth Volume
                    </button>
                    <button 
                        onClick={() => setViewMetric('requests')}
                        style={{ padding: '8px 16px', borderRadius: '6px', border: 'none', cursor: 'pointer', backgroundColor: viewMetric === 'requests' ? 'white' : 'transparent', color: viewMetric === 'requests' ? '#0F172A' : '#64748B', fontWeight: viewMetric === 'requests' ? 700 : 500, boxShadow: viewMetric === 'requests' ? '0 1px 3px rgba(0,0,0,0.1)' : 'none', display: 'flex', alignItems: 'center', gap: '6px' }}
                    >
                        <Activity size={16} /> Total HTTP Requests
                    </button>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '24px', height: '350px' }}>
                {/* D3 Heatmap Area */}
                <div style={{ flex: 2, backgroundColor: '#0F172A', borderRadius: '8px', position: 'relative', overflow: 'hidden', display: 'flex', padding: '24px', flexWrap: 'wrap', alignContent: 'flex-start', gap: '12px' }}>
                    
                    {/* Render visual blocks sizing based on the selected metric relative weight */}
                    {nodes.sort((a, b) => viewMetric === 'bandwidth' ? b.bytesTransferred - a.bytesTransferred : b.requestCount - a.requestCount).map((node, i) => {
                        const maxVal = viewMetric === 'bandwidth' ? nodes[0].bytesTransferred : nodes.sort((x, y) => y.requestCount - x.requestCount)[0].requestCount;
                        const currentVal = viewMetric === 'bandwidth' ? node.bytesTransferred : node.requestCount;
                        const pct = Math.max(15, (currentVal / maxVal) * 100);
                        
                        return (
                            <div key={node.id} style={{ 
                                width: `${pct}%`, height: `${Math.max(30, pct)}%`, 
                                backgroundColor: node.colorCode, borderRadius: '4px', opacity: 0.85,
                                display: 'flex', flexDirection: 'column', padding: '12px', color: 'white',
                                boxShadow: 'inset 0 0 0 1px rgba(255,255,255,0.2)', transition: 'all 0.3s ease'
                            }}>
                                <span style={{ fontWeight: 800, fontSize: '0.8rem', whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{node.label}</span>
                                <span style={{ fontWeight: 600, fontSize: '1rem', marginTop: 'auto' }}>
                                    {viewMetric === 'bandwidth' ? formatBytes(node.bytesTransferred) : `${node.requestCount.toLocaleString()} reqs`}
                                </span>
                            </div>
                        );
                    })}
                </div>

                {/* Sidebar Stats */}
                <div style={{ flex: 1, backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', padding: '20px', display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#0F172A', fontWeight: 800 }}>
                        <Server size={18} color="#3B82F6" /> Regional Caching (US-East)
                    </div>
                    
                    <div style={{ backgroundColor: 'white', padding: '16px', borderRadius: '6px', border: '1px solid #E2E8F0' }}>
                        <div style={{ color: '#64748B', fontSize: '0.8rem', textTransform: 'uppercase', marginBottom: '4px' }}>Total Outbound (30d)</div>
                        <div style={{ color: '#0F172A', fontSize: '1.5rem', fontWeight: 800 }}>47.6 GB</div>
                    </div>

                    <div style={{ backgroundColor: 'white', padding: '16px', borderRadius: '6px', border: '1px solid #E2E8F0' }}>
                        <div style={{ color: '#64748B', fontSize: '0.8rem', textTransform: 'uppercase', marginBottom: '4px' }}>Cache Hit Ratio</div>
                        <div style={{ color: '#10B981', fontSize: '1.5rem', fontWeight: 800 }}>96.4%</div>
                        <p style={{ margin: '4px 0 0 0', fontSize: '0.75rem', color: '#64748B' }}>Excellent. Assets are hitting the edge.</p>
                    </div>
                </div>
            </div>
        </div>
    );
};

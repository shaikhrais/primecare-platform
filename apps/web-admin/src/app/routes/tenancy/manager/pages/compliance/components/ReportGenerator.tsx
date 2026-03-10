import React, { useState } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { FileUp, FileDown, Loader2, DatabaseZap } from 'lucide-react';

interface QueuedReport {
    id: string;
    name: string;
    status: 'queueing' | 'processing' | 'ready';
    requestedAt: Date;
}

export const ReportGenerator: React.FC = () => {
    const { showToast } = useNotification();
    const [queue, setQueue] = useState<QueuedReport[]>([]);

    const generateReport = (reportName: string) => {
        const id = Math.random().toString(36).substr(2, 9);
        const newReport: QueuedReport = {
            id,
            name: reportName,
            status: 'queueing',
            requestedAt: new Date()
        };

        setQueue(prev => [...prev, newReport]);
        
        // Suggestion 27: Background Report Generation Mock
        // Step 1: Tell user it's offloaded
        showToast(`Request for '${reportName}' sent to background worker queue. You can safely leave this page.`, 'info');

        // Step 2: Transition to processing
        setTimeout(() => {
            setQueue(prev => prev.map(r => r.id === id ? { ...r, status: 'processing' } : r));
        }, 1500);

        // Step 3: Complete and notify everywhere
        setTimeout(() => {
            setQueue(prev => prev.map(r => r.id === id ? { ...r, status: 'ready' } : r));
            showToast(`Report Ready: ${reportName}. Click to download from the Hub.`, 'success');
        }, 6000);
    };

    const handleDownload = (id: string, name: string) => {
        showToast(`Downloading '${name}' encrypted payload...`, 'success');
        setQueue(prev => prev.filter(r => r.id !== id));
    };

    return (
        <div style={{ backgroundColor: '#F8FAFC', padding: '32px', borderRadius: '16px', border: '1px solid #E2E8F0', height: '100%', display: 'flex', flexDirection: 'column', gap: '24px' }}>
            <div>
                <h2 style={{ fontSize: '1.25rem', fontWeight: 800, margin: '0 0 8px 0', color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px' }}>
                    <DatabaseZap color="#6366F1" /> Async Compliance Engine
                </h2>
                <p style={{ color: '#64748B', margin: 0, fontSize: '0.9rem' }}>Massive ledger queries (500k+ rows) are automatically offloaded to Cloudflare Workers to prevent UI thrashing.</p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '12px' }}>
                <button 
                    onClick={() => generateReport('Q3 Financial Forensics')}
                    style={{ padding: '16px', backgroundColor: 'white', border: '1px solid #CBD5E1', borderRadius: '12px', display: 'flex', flexDirection: 'column', alignItems: 'flex-start', gap: '8px', cursor: 'pointer', transition: 'all 0.2s' }}
                    onMouseEnter={e => e.currentTarget.style.borderColor = '#6366F1'}
                    onMouseLeave={e => e.currentTarget.style.borderColor = '#CBD5E1'}
                >
                    <div style={{ fontWeight: 800, color: '#0F172A' }}>Q3 Financial Forensics</div>
                    <div style={{ fontSize: '0.8rem', color: '#64748B' }}>1.2M Ledger Entries • ~4s</div>
                </button>
                <button 
                    onClick={() => generateReport('State Compliance (Full)')}
                    style={{ padding: '16px', backgroundColor: 'white', border: '1px solid #CBD5E1', borderRadius: '12px', display: 'flex', flexDirection: 'column', alignItems: 'flex-start', gap: '8px', cursor: 'pointer', transition: 'all 0.2s' }}
                    onMouseEnter={e => e.currentTarget.style.borderColor = '#6366F1'}
                    onMouseLeave={e => e.currentTarget.style.borderColor = '#CBD5E1'}
                >
                    <div style={{ fontWeight: 800, color: '#0F172A' }}>State Compliance (Full)</div>
                    <div style={{ fontSize: '0.8rem', color: '#64748B' }}>945 Active Care Plans • ~6s</div>
                </button>
            </div>

            <div style={{ flex: 1, backgroundColor: 'white', borderRadius: '12px', border: '1px solid #E2E8F0', padding: '16px' }}>
                <h3 style={{ margin: '0 0 16px 0', fontSize: '0.9rem', fontWeight: 800, color: '#475569', textTransform: 'uppercase', letterSpacing: '1px' }}>Background Queue</h3>
                
                {queue.length === 0 ? (
                    <div style={{ color: '#94A3B8', fontSize: '0.9rem', fontStyle: 'italic', textAlign: 'center', padding: '24px 0' }}>Queue is empty.</div>
                ) : (
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                        {queue.map(report => (
                            <div key={report.id} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '12px', backgroundColor: report.status === 'ready' ? '#F0FDF4' : '#F8FAFC', border: `1px solid ${report.status === 'ready' ? '#86EFAC' : '#E2E8F0'}`, borderRadius: '8px', transition: 'all 0.5s' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                                    {report.status === 'queueing' && <FileUp size={18} color="#94A3B8" />}
                                    {report.status === 'processing' && <Loader2 size={18} color="#6366F1" className="animate-spin" />}
                                    {report.status === 'ready' && <FileDown size={18} color="#16A34A" />}
                                    
                                    <div>
                                        <div style={{ fontWeight: 700, color: '#0F172A', fontSize: '0.95rem' }}>{report.name}</div>
                                        <div style={{ color: '#64748B', fontSize: '0.75rem' }}>
                                            Requested {report.requestedAt.toLocaleTimeString()}
                                        </div>
                                    </div>
                                </div>

                                <div>
                                    {report.status === 'processing' && <span style={{ color: '#6366F1', fontWeight: 700, fontSize: '0.85rem' }}>Crunching Data...</span>}
                                    {report.status === 'ready' && (
                                        <button 
                                            onClick={() => handleDownload(report.id, report.name)}
                                            style={{ backgroundColor: '#10B981', color: 'white', border: 'none', padding: '6px 16px', borderRadius: '6px', fontWeight: 700, cursor: 'pointer' }}
                                        >
                                            Download CCSV
                                        </button>
                                    )}
                                </div>
                            </div>
                        ))}
                    </div>
                )}
            </div>
        </div>
    );
};

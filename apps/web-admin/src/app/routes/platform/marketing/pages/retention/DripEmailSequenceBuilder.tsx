import React, { useState } from 'react';
import { Mail, Clock, ArrowRight, Play, CheckCircle2, AlertTriangle, Workflow } from 'lucide-react';

interface SequenceNode {
    id: string;
    type: 'TRIGGER' | 'EMAIL' | 'DELAY' | 'CONDITION';
    title: string;
    description: string;
    metrics?: { sent: number; openRate: number; clickRate: number };
}

export const DripEmailSequenceBuilder: React.FC = () => {
    const [nodes] = useState<SequenceNode[]>([
        { id: '1', type: 'TRIGGER', title: 'Lead Capture Form', description: 'User downloads "Dementia Pricing Guide PDF"' },
        { id: '2', type: 'EMAIL', title: 'Email 1: Guide Delivery', description: 'Subject: Here is your Pricing Guide', metrics: { sent: 450, openRate: 68, clickRate: 42 } },
        { id: '3', type: 'DELAY', title: 'Wait 3 Days', description: 'Give them time to read the PDF.' },
        { id: '4', type: 'EMAIL', title: 'Email 2: Trust Building', description: 'Subject: How we screen our caregivers', metrics: { sent: 390, openRate: 45, clickRate: 15 } },
        { id: '5', type: 'CONDITION', title: 'Did they click?', description: 'Branch based on engagement.' },
        { id: '6', type: 'EMAIL', title: 'Email 3 (High Intent)', description: 'Subject: Book a free RN assessment', metrics: { sent: 58, openRate: 80, clickRate: 35 } },
    ]);

    const renderNode = (node: SequenceNode, index: number) => {
        let bgColor, borderColor, icon;
        
        switch(node.type) {
            case 'TRIGGER':
                bgColor = '#F3E8FF'; borderColor = '#D8B4FE'; icon = <Play size={20} color="#9333EA" />; break;
            case 'EMAIL':
                bgColor = '#E0F2FE'; borderColor = '#BAE6FD'; icon = <Mail size={20} color="#0284C7" />; break;
            case 'DELAY':
                bgColor = '#F1F5F9'; borderColor = '#CBD5E1'; icon = <Clock size={20} color="#475569" />; break;
            case 'CONDITION':
                bgColor = '#FEF9C3'; borderColor = '#FDE047'; icon = <Workflow size={20} color="#CA8A04" />; break;
        }

        return (
            <div key={node.id} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                <div style={{ width: '400px', backgroundColor: 'white', border: `2px solid ${borderColor}`, borderRadius: '12px', padding: '0', overflow: 'hidden', boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)' }}>
                    
                    <div style={{ backgroundColor: bgColor, padding: '12px 16px', display: 'flex', alignItems: 'center', gap: '12px', borderBottom: `1px solid ${borderColor}` }}>
                        <div style={{ backgroundColor: 'white', padding: '6px', borderRadius: '50%', display: 'flex' }}>{icon}</div>
                        <h4 style={{ margin: 0, fontSize: '1rem', color: '#0F172A', fontWeight: 800 }}>{node.title}</h4>
                    </div>
                    
                    <div style={{ padding: '16px' }}>
                        <p style={{ margin: '0 0 12px 0', fontSize: '0.9rem', color: '#475569', lineHeight: 1.4 }}>{node.description}</p>
                        
                        {node.metrics && (
                            <div style={{ display: 'flex', gap: '12px', marginTop: '16px', paddingTop: '16px', borderTop: '1px solid #E2E8F0' }}>
                                <div style={{ flex: 1 }}>
                                    <div style={{ fontSize: '0.7rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Sent</div>
                                    <div style={{ fontSize: '1.1rem', fontWeight: 900, color: '#0F172A' }}>{node.metrics.sent}</div>
                                </div>
                                <div style={{ flex: 1 }}>
                                    <div style={{ fontSize: '0.7rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Open Rate</div>
                                    <div style={{ fontSize: '1.1rem', fontWeight: 900, color: node.metrics.openRate > 40 ? '#10B981' : '#F59E0B' }}>{node.metrics.openRate}%</div>
                                </div>
                                <div style={{ flex: 1 }}>
                                    <div style={{ fontSize: '0.7rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Click Rate</div>
                                    <div style={{ fontSize: '1.1rem', fontWeight: 900, color: '#0284C7' }}>{node.metrics.clickRate}%</div>
                                </div>
                            </div>
                        )}
                    </div>
                </div>
                
                {/* Arrow connecting to next node */}
                {index < nodes.length - 1 && index !== 4 && (
                    <div style={{ height: '30px', width: '2px', backgroundColor: '#CBD5E1', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                         <div style={{ marginTop: '30px', color: '#CBD5E1' }}>▼</div>
                    </div>
                )}

                 {/* Simulated Branching for Condition Node */}
                 {index === 4 && (
                    <div style={{ display: 'flex', width: '400px', justifyContent: 'space-between', marginTop: '10px', position: 'relative' }}>
                        
                        <div style={{ position: 'absolute', top: '-10px', left: '50%', transform: 'translateX(-50%)', width: '2px', height: '10px', backgroundColor: '#CBD5E1' }}></div>
                        <div style={{ position: 'absolute', top: 0, left: '25%', right: '25%', height: '2px', backgroundColor: '#CBD5E1' }}></div>

                        <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', width: '50%' }}>
                            <div style={{ width: '2px', height: '20px', backgroundColor: '#CBD5E1' }}></div>
                            <div style={{ backgroundColor: '#DCFCE7', color: '#166534', padding: '2px 8px', borderRadius: '12px', fontSize: '0.75rem', fontWeight: 800, marginBottom: '10px', border: '1px solid #86EFAC' }}>Yes (15%)</div>
                        </div>
                        <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', width: '50%' }}>
                            <div style={{ width: '2px', height: '20px', backgroundColor: '#CBD5E1' }}></div>
                             <div style={{ backgroundColor: '#FEF2F2', color: '#991B1B', padding: '2px 8px', borderRadius: '12px', fontSize: '0.75rem', fontWeight: 800, marginBottom: '10px', border: '1px solid #FECACA' }}>No (85%)</div>
                        </div>
                    </div>
                 )}
            </div>
        );
    };

    return (
        <div style={{ backgroundColor: '#F8FAFC', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '32px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '40px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: 'white', padding: '16px', borderRadius: '12px', border: '1px solid #E2E8F0', boxShadow: '0 4px 6px -1px rgba(0,0,0,0.05)' }}>
                        <Workflow size={32} color="#0284C7" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.8rem', color: '#0F172A', fontWeight: 900 }}>Drip Email Nurture Sequence</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '1rem' }}>Automatically nurture cold leads over 14 days to keep PrimeCare top-of-mind.</p>
                    </div>
                </div>

                <div style={{ backgroundColor: 'white', padding: '12px 24px', borderRadius: '12px', border: '1px solid #E2E8F0', display: 'flex', alignItems: 'center', gap: '16px', boxShadow: '0 2px 4px rgba(0,0,0,0.02)' }}>
                    <div>
                        <div style={{ fontSize: '0.75rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Campaign Status</div>
                        <div style={{ color: '#16A34A', display: 'flex', alignItems: 'center', gap: '6px', fontWeight: 900, fontSize: '1rem' }}><CheckCircle2 size={18}/> ACTIVE RUNNING</div>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', padding: '24px 0' }}>
                {nodes.map((node, index) => renderNode(node, index))}
                
                {/* Visual anchor for the "No" branch dropoff */}
                <div style={{ width: '400px', display: 'flex', justifyContent: 'flex-end', marginTop: '-120px', paddingRight: '40px' }}>
                     <div style={{ backgroundColor: '#F1F5F9', border: '1px dashed #CBD5E1', padding: '12px', borderRadius: '8px', color: '#64748B', fontSize: '0.8rem', fontWeight: 700, textAlign: 'center', width: '120px' }}>
                        End Sequence<br/>(Move to Cold List)
                    </div>
                </div>
            </div>

             <div style={{ marginTop: '60px', padding: '20px', backgroundColor: '#EFF6FF', borderRadius: '12px', border: '1px solid #BFDBFE', fontSize: '0.95rem', color: '#1E3A8A' }}>
                <strong>Sales Automation:</strong> When families first search for home care, they are usually just gathering prices and aren't ready to buy today. Instead of losing them, this node-based drip sequence automatically sends a 5-part educational email series over two weeks. This establishes PrimeCare as the authoritative expert so that when the family *is* finally ready to hire an agency, PrimeCare is the only one they call.
            </div>
        </div>
    );
};

import React, { useState } from 'react';
import { Eye, MousePointerClick, TrendingDown, Clock, MousePointer2 } from 'lucide-react';

interface ContentHeatmap {
    id: string;
    section: string;
    viewPercentage: number;
    avgTimeSpent: string;
    description: string;
    clicks: number;
}

export const ContentEngagementHeatmap: React.FC = () => {
    const [heatmapData] = useState<ContentHeatmap[]>([
        { id: '1', section: 'Hero Header & Headline', viewPercentage: 100, avgTimeSpent: '0m 14s', description: 'Visually identifies the agency and primary value prop.', clicks: 0 },
        { id: '2', section: 'Service Core Differentiators', viewPercentage: 82, avgTimeSpent: '1m 20s', description: 'Bullet points explaining 24/7 care models.', clicks: 12 },
        { id: '3', section: 'Pricing & Insurance Estimator', viewPercentage: 65, avgTimeSpent: '2m 45s', description: 'Deep engagement. Users are reading complex financial details.', clicks: 85 },
        { id: '4', section: 'Primary "Call To Action" Form', viewPercentage: 22, avgTimeSpent: '0m 40s', description: 'The actual lead capture form to request an assessment.', clicks: 4 },
        { id: '5', section: 'Staff Credentials & Footer', viewPercentage: 8, avgTimeSpent: '0m 10s', description: 'Regulatory links and standard footer boilerplate.', clicks: 1 }
    ]);

    const getGradient = (percentage: number) => {
        if (percentage >= 80) return '#FEF2F2'; // Hot (Red)
        if (percentage >= 40) return '#FFFBEB'; // Warm (Yellow)
        if (percentage >= 15) return '#F0FDF4'; // Cool (Green)
        return '#F8FAFC'; // Cold (Gray)
    };

    const getBorderColor = (percentage: number) => {
        if (percentage >= 80) return '#FECACA';
        if (percentage >= 40) return '#FDE68A';
        if (percentage >= 15) return '#BBF7D0';
        return '#E2E8F0';
    };

    const getTextColor = (percentage: number) => {
        if (percentage >= 80) return '#DC2626';
        if (percentage >= 40) return '#D97706';
        if (percentage >= 15) return '#16A34A';
        return '#64748B';
    };

    return (
        <div style={{ backgroundColor: '#1E293B', border: '1px solid #334155', borderRadius: '12px', padding: '24px', marginTop: '16px', color: 'white' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#334155', padding: '12px', borderRadius: '8px', border: '1px solid #475569' }}>
                        <MousePointer2 size={28} color="#94A3B8" />
                    </div>
                    <div>
                        <h3 data-cy="h3-content-engagement-heatmap-0" style={{ margin: 0, fontSize: '1.4rem', color: '#F8FAFC', fontWeight: 800 }}>Content Scrolling Heatmap: /services/dementia</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#94A3B8', fontSize: '0.9rem' }}>Visualizes user scroll depth and click interaction to identify UX friction points.</p>
                    </div>
                </div>

                <div style={{ padding: '8px 16px', backgroundColor: '#FEF2F2', borderRadius: '8px', border: '1px solid #FECACA', display: 'flex', alignItems: 'center', gap: '12px' }}>
                     <TrendingDown size={20} color="#DC2626" />
                     <div>
                        <div style={{ fontSize: '0.75rem', color: '#991B1B', fontWeight: 700, textTransform: 'uppercase' }}>Critical Drop-off Detected</div>
                        <div style={{ fontSize: '0.9rem', fontWeight: 800, color: '#DC2626' }}>78% abandon before Lead Form</div>
                     </div>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '32px' }}>
                 {/* Visual Heatmap Device Column */}
                <div style={{ flex: '0 0 300px', backgroundColor: 'black', borderRadius: '24px', padding: '12px', border: '4px solid #475569', display: 'flex', flexDirection: 'column', gap: '2px', position: 'relative' }}>
                    
                    <div style={{ position: 'absolute', top: '10px', left: '50%', transform: 'translateX(-50%)', width: '60px', height: '6px', backgroundColor: '#334155', borderRadius: '10px', zIndex: 10 }}></div>

                    {heatmapData.map((section, idx) => (
                        <div key={idx} style={{ 
                            height: '110px', 
                            backgroundColor: getGradient(section.viewPercentage),
                            border: `2px solid ${getBorderColor(section.viewPercentage)}`,
                            borderRadius: idx === 0 ? '16px 16px 4px 4px' : idx === heatmapData.length -1 ? '4px 4px 16px 16px' : '4px',
                            display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center',
                            position: 'relative', overflow: 'hidden'
                        }}>
                             <div style={{ fontWeight: 900, fontSize: '1.4rem', color: getTextColor(section.viewPercentage), zIndex: 2 }}>
                                {section.viewPercentage}%
                            </div>
                            <div style={{ fontSize: '0.7rem', color: '#475569', fontWeight: 700, zIndex: 2 }}>Saw this section</div>
                        </div>
                    ))}
                </div>

                {/* Analytical Data Column */}
                <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    {heatmapData.map(data => (
                        <div key={data.id} style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', padding: '16px', backgroundColor: '#0F172A', borderRadius: '12px', border: '1px solid #334155' }}>
                            <div>
                                <h4 style={{ margin: '0 0 4px 0', fontSize: '1.05rem', color: '#F1F5F9', fontWeight: 800 }}>{data.section}</h4>
                                <div style={{ fontSize: '0.85rem', color: '#94A3B8' }}>{data.description}</div>
                            </div>

                            <div style={{ display: 'flex', gap: '24px', backgroundColor: '#1E293B', padding: '12px 24px', borderRadius: '8px', border: '1px solid #475569' }}>
                                <div>
                                    <div style={{ fontSize: '0.75rem', color: '#94A3B8', fontWeight: 700, display: 'flex', alignItems: 'center', gap: '4px', marginBottom: '4px' }}><Clock size={12}/> Avg Time</div>
                                    <div style={{ fontWeight: 800, color: '#E2E8F0' }}>{data.avgTimeSpent}</div>
                                </div>
                                <div>
                                    <div style={{ fontSize: '0.75rem', color: '#94A3B8', fontWeight: 700, display: 'flex', alignItems: 'center', gap: '4px', marginBottom: '4px' }}><MousePointerClick size={12}/> Clicks</div>
                                    <div style={{ fontWeight: 800, color: '#E2E8F0' }}>{data.clicks}</div>
                                </div>
                                <div>
                                    <div style={{ fontSize: '0.75rem', color: '#94A3B8', fontWeight: 700, display: 'flex', alignItems: 'center', gap: '4px', marginBottom: '4px' }}><Eye size={12}/> Views</div>
                                    <div style={{ fontWeight: 800, color: getTextColor(data.viewPercentage) }}>{data.viewPercentage}%</div>
                                </div>
                            </div>
                        </div>
                    ))}
                    
                    <div style={{ marginTop: 'auto', padding: '16px', backgroundColor: '#374151', borderRadius: '8px', border: '1px solid #4B5563', fontSize: '0.9rem', color: '#D1D5DB' }}>
                        <strong>Diagnostic Insight:</strong> People are highly engaged with the "Pricing section" (65% visibility, 2m 45s dwell time), but the Lead Generation Form is buried below it (only 22% visibility). Suggestion: Pin the Lead Form globally to the sidebar so it's visible during the pricing read.
                    </div>
                </div>
            </div>
        </div>
    );
};

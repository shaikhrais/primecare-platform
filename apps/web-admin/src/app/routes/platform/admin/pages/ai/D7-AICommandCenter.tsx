// ================================================================
// PAGE IDENTITY: D7 · AI Command Center — Unified Intelligence
// Type: Dashboard | Owner: admin
// Models: AIRecommendation, AIInference, SentimentAnalysis
// ================================================================
import React, { useState } from 'react';

const recommendations = [
    { id: 'rec-001', type: 'Scheduling', title: 'Optimize Tuesday afternoon coverage', confidence: 92, impact: 'high', description: 'Based on 3 months of visit data, Tuesdays 2-5 PM have 23% higher cancellation rates. Recommend shifting 2 PSWs from morning to afternoon blocks.', status: 'new' },
    { id: 'rec-002', type: 'Retention', title: 'At-risk PSW: Kevin O\'Brien', confidence: 87, impact: 'critical', description: 'Engagement score dropped 40% over 6 weeks. Overtime hours up 15%. Similar patterns preceded 3 resignations last quarter. Suggest 1-on-1 check-in.', status: 'new' },
    { id: 'rec-003', type: 'Clinical', title: 'Client Helen Kowalski needs care plan review', confidence: 78, impact: 'high', description: 'Glucose readings trending upward (avg 195→210 over 2 weeks). IoT data suggests medication adherence issues. Recommend RN assessment.', status: 'accepted' },
    { id: 'rec-004', type: 'Financial', title: 'Invoice #INV-2847 may have billing error', confidence: 95, impact: 'medium', description: 'Service hours billed (8h) exceed scheduled visit time (6h) by 33%. Pattern matches 4 similar discrepancies this month.', status: 'new' },
    { id: 'rec-005', type: 'Compliance', title: 'EVV gap detected for 3 visits', confidence: 99, impact: 'critical', description: '3 visits on March 14 lack check-out GPS verification. This creates OHIP compliance risk. Affected PSWs: Sharma, Chen, Wright.', status: 'resolved' },
];

const sentiments = [
    { source: 'Client Surveys', score: 4.6, trend: '+0.2', samples: 156, sentiment: 'positive' },
    { source: 'PSW Feedback', score: 3.8, trend: '-0.3', samples: 48, sentiment: 'neutral' },
    { source: 'Family Portal', score: 4.2, trend: '+0.1', samples: 89, sentiment: 'positive' },
    { source: 'Incident Notes', score: 2.1, trend: '+0.5', samples: 23, sentiment: 'negative' },
];

const inferences = [
    { model: 'Churn Predictor', accuracy: '91.3%', lastRun: '2 hrs ago', predictions: 12, status: 'active' },
    { model: 'Visit Duration Estimator', accuracy: '87.8%', lastRun: '1 hr ago', predictions: 230, status: 'active' },
    { model: 'Schedule Optimizer', accuracy: '89.2%', lastRun: '30 min ago', predictions: 45, status: 'active' },
    { model: 'Billing Anomaly Detector', accuracy: '94.1%', lastRun: '4 hrs ago', predictions: 8, status: 'active' },
    { model: 'Client Risk Assessment', accuracy: '85.5%', lastRun: '6 hrs ago', predictions: 34, status: 'training' },
];

export default function AICommandCenter() {
    const [tab, setTab] = useState<'recommendations' | 'sentiment' | 'models' | 'insights'>('recommendations');
    const impactColor = (i: string) => i === 'critical' ? 'var(--pc-error)' : i === 'high' ? 'var(--pc-warning)' : 'var(--pc-info, #2563EB)';
    const statusIcon = (s: string) => s === 'new' ? '🆕' : s === 'accepted' ? '✅' : s === 'resolved' ? '🔒' : '⏳';

    return (
        <div data-cy="page.container" role="main" aria-label="AI Command Center" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            {/* Header */}
            <div style={{ marginBottom: '24px' }}>
                <h1 data-cy="page.title" style={{ fontSize: '1.75rem', fontWeight: 800, color: 'var(--pc-text-primary)', margin: 0 }}>
                    🧠 AI Command Center
                </h1>
                <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.85rem', margin: '4px 0 0' }}>
                    Unified intelligence — recommendations, sentiment analysis, predictive models & insights
                </p>
            </div>

            {/* KPI Row */}
            <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap', marginBottom: '24px' }}>
                {[
                    { label: 'AI Recommendations', value: '5', subtext: '2 critical', icon: '🎯', color: 'var(--pc-primary)' },
                    { label: 'Models Active', value: '4/5', subtext: '1 training', icon: '🤖', color: 'var(--pc-success)' },
                    { label: 'Avg Confidence', value: '90.2%', subtext: '↗ +2.1%', icon: '📊', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Predictions Today', value: '329', subtext: '↗ +14%', icon: '🔮', color: '#7C3AED' },
                    { label: 'Sentiment Score', value: '3.7/5', subtext: 'Neutral-Positive', icon: '💭', color: 'var(--pc-warning)' },
                ].map((s, i) => (
                    <div key={i} style={{
                        flex: '1 1 160px', padding: '20px', borderRadius: '14px',
                        background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                    }}>
                        <div style={{ fontSize: '0.7rem', fontWeight: 600, color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', marginBottom: '6px' }}>
                            {s.icon} {s.label}
                        </div>
                        <div style={{ fontSize: '1.8rem', fontWeight: 800, color: s.color }}>{s.value}</div>
                        <div style={{ fontSize: '0.7rem', color: 'var(--pc-text-tertiary)', marginTop: '2px' }}>{s.subtext}</div>
                    </div>
                ))}
            </div>

            {/* Tabs */}
            <div style={{ display: 'flex', gap: '4px', marginBottom: '24px' }}>
                {[
                    { id: 'recommendations' as const, label: '🎯 Recommendations' },
                    { id: 'sentiment' as const, label: '💭 Sentiment' },
                    { id: 'models' as const, label: '🤖 AI Models' },
                    { id: 'insights' as const, label: '💡 Insights' },
                ].map(t => (
                    <button key={t.id} onClick={() => setTab(t.id)} data-cy={`tab-ai-${t.id}`}
                        style={{
                            padding: '10px 20px', borderRadius: '10px', border: 'none',
                            background: tab === t.id ? 'var(--pc-primary)' : 'var(--pc-bg-secondary)',
                            color: tab === t.id ? 'white' : 'var(--pc-text-secondary)',
                            fontWeight: 700, fontSize: '0.85rem', cursor: 'pointer',
                        }}>{t.label}</button>
                ))}
            </div>

            {/* Recommendations */}
            {tab === 'recommendations' && (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                    {recommendations.map(rec => (
                        <div key={rec.id} style={{
                            padding: '20px', borderRadius: '14px',
                            background: 'var(--pc-surface-card)',
                            border: `1px solid ${rec.impact === 'critical' ? 'var(--pc-error)' : 'var(--pc-border-primary)'}`,
                        }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '8px', flexWrap: 'wrap', gap: '8px' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                                    <span style={{ fontSize: '1.2rem' }}>{statusIcon(rec.status)}</span>
                                    <span style={{
                                        padding: '3px 10px', borderRadius: '8px', fontSize: '0.65rem', fontWeight: 700,
                                        background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-secondary)',
                                    }}>{rec.type}</span>
                                    <span style={{
                                        padding: '3px 10px', borderRadius: '8px', fontSize: '0.65rem', fontWeight: 700,
                                        color: impactColor(rec.impact), background: `${impactColor(rec.impact)}15`,
                                    }}>{rec.impact.toUpperCase()}</span>
                                </div>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                                    <div style={{ width: '40px', height: '4px', background: 'var(--pc-bg-secondary)', borderRadius: '2px', overflow: 'hidden' }}>
                                        <div style={{ width: `${rec.confidence}%`, height: '100%', background: rec.confidence > 90 ? 'var(--pc-success)' : 'var(--pc-warning)', borderRadius: '2px' }} />
                                    </div>
                                    <span style={{ fontSize: '0.7rem', fontWeight: 700, color: 'var(--pc-text-secondary)' }}>{rec.confidence}%</span>
                                </div>
                            </div>
                            <div style={{ fontWeight: 700, fontSize: '0.95rem', color: 'var(--pc-text-primary)', marginBottom: '6px' }}>
                                {rec.title}
                            </div>
                            <div style={{ fontSize: '0.8rem', color: 'var(--pc-text-tertiary)', lineHeight: 1.6 }}>
                                {rec.description}
                            </div>
                            {rec.status === 'new' && (
                                <div style={{ display: 'flex', gap: '8px', marginTop: '12px' }}>
                                    <button style={{ padding: '6px 16px', borderRadius: '8px', border: 'none', background: 'var(--pc-success)', color: 'white', fontWeight: 700, fontSize: '0.75rem', cursor: 'pointer' }}>
                                        ✅ Accept
                                    </button>
                                    <button style={{ padding: '6px 16px', borderRadius: '8px', border: '1px solid var(--pc-border-primary)', background: 'transparent', color: 'var(--pc-text-secondary)', fontWeight: 700, fontSize: '0.75rem', cursor: 'pointer' }}>
                                        ❌ Dismiss
                                    </button>
                                </div>
                            )}
                        </div>
                    ))}
                </div>
            )}

            {/* Sentiment */}
            {tab === 'sentiment' && (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(250px, 1fr))', gap: '16px' }}>
                    {sentiments.map((s, i) => {
                        const color = s.sentiment === 'positive' ? 'var(--pc-success)' : s.sentiment === 'negative' ? 'var(--pc-error)' : 'var(--pc-warning)';
                        return (
                            <div key={i} style={{
                                padding: '24px', borderRadius: '14px',
                                background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                            }}>
                                <div style={{ fontSize: '0.7rem', fontWeight: 600, color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', marginBottom: '12px' }}>
                                    {s.source}
                                </div>
                                <div style={{ fontSize: '2.5rem', fontWeight: 800, color, marginBottom: '4px' }}>
                                    {s.score}
                                </div>
                                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                    <span style={{ fontSize: '0.75rem', fontWeight: 700, color: s.trend.startsWith('+') ? 'var(--pc-success)' : 'var(--pc-error)' }}>
                                        {s.trend}
                                    </span>
                                    <span style={{ fontSize: '0.7rem', color: 'var(--pc-text-tertiary)' }}>
                                        {s.samples} responses
                                    </span>
                                </div>
                                <div style={{ height: '4px', background: 'var(--pc-bg-secondary)', borderRadius: '2px', marginTop: '12px', overflow: 'hidden' }}>
                                    <div style={{ width: `${(s.score / 5) * 100}%`, height: '100%', background: color, borderRadius: '2px' }} />
                                </div>
                            </div>
                        );
                    })}
                </div>
            )}

            {/* AI Models */}
            {tab === 'models' && (
                <div style={{ borderRadius: '14px', border: '1px solid var(--pc-border-primary)', overflow: 'hidden' }}>
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead>
                            <tr>
                                {['Model', 'Accuracy', 'Last Run', 'Predictions', 'Status'].map(h => (
                                    <th key={h} style={{
                                        padding: '12px 16px', textAlign: 'left',
                                        background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-tertiary)',
                                        fontSize: '0.7rem', fontWeight: 700, textTransform: 'uppercase',
                                        borderBottom: '2px solid var(--pc-border-primary)',
                                    }}>{h}</th>
                                ))}
                            </tr>
                        </thead>
                        <tbody>
                            {inferences.map((m, i) => (
                                <tr key={i} style={{ background: 'var(--pc-surface-card)' }}
                                    onMouseEnter={e => e.currentTarget.style.background = 'var(--pc-bg-secondary)'}
                                    onMouseLeave={e => e.currentTarget.style.background = 'var(--pc-surface-card)'}>
                                    <td style={{ padding: '14px 16px', fontWeight: 700, color: 'var(--pc-text-primary)', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        🤖 {m.model}
                                    </td>
                                    <td style={{ padding: '14px 16px', fontWeight: 700, color: 'var(--pc-success)', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        {m.accuracy}
                                    </td>
                                    <td style={{ padding: '14px 16px', color: 'var(--pc-text-secondary)', fontSize: '0.85rem', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        {m.lastRun}
                                    </td>
                                    <td style={{ padding: '14px 16px', fontWeight: 700, color: 'var(--pc-text-primary)', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        {m.predictions}
                                    </td>
                                    <td style={{ padding: '14px 16px', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        <span style={{
                                            padding: '3px 10px', borderRadius: '10px', fontSize: '0.65rem', fontWeight: 700,
                                            color: m.status === 'active' ? 'var(--pc-success)' : 'var(--pc-warning)',
                                            background: m.status === 'active' ? 'rgba(5,150,105,0.1)' : 'rgba(245,158,11,0.1)',
                                        }}>{m.status.toUpperCase()}</span>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            )}

            {/* Insights */}
            {tab === 'insights' && (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', gap: '16px' }}>
                    {[
                        { icon: '📈', title: 'Visit Volume Forecast', body: 'Next week: estimated 1,247 visits (+8% vs this week). Tuesday and Thursday will peak. Consider adding 2 float PSWs.', type: 'Forecasting' },
                        { icon: '⚠️', title: 'Staff Turnover Risk', body: '3 PSWs show burnout indicators (overtime >30%, declining engagement). Consider wellness check-ins before month-end.', type: 'Retention' },
                        { icon: '💰', title: 'Revenue Optimization', body: 'Billing recovery rate is 94.2%. Automating follow-up for 47 outstanding invoices could recover $12,400.', type: 'Financial' },
                        { icon: '🏥', title: 'Care Quality Index', body: 'Overall quality score: 4.3/5. Top performer: Priya Sharma (4.9). Area needing improvement: documentation timeliness.', type: 'Clinical' },
                    ].map((insight, i) => (
                        <div key={i} style={{
                            padding: '24px', borderRadius: '14px',
                            background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                        }}>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '12px' }}>
                                <span style={{ fontSize: '1.5rem' }}>{insight.icon}</span>
                                <span style={{
                                    padding: '2px 8px', borderRadius: '8px', fontSize: '0.6rem', fontWeight: 700,
                                    background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-tertiary)',
                                }}>{insight.type}</span>
                            </div>
                            <div style={{ fontWeight: 700, fontSize: '0.95rem', color: 'var(--pc-text-primary)', marginBottom: '8px' }}>
                                {insight.title}
                            </div>
                            <div style={{ fontSize: '0.8rem', color: 'var(--pc-text-secondary)', lineHeight: 1.6 }}>
                                {insight.body}
                            </div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
}

import type { TableColumn } from '@/shared/components/sections';
import React, { useState } from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from D5-AiDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D5 · AI Dashboard
// Type: Dashboard | Owner: admin | Registry: D5
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

const aiModules = [
    { icon: '🔮', title: 'Predictive Analytics', subtitle: 'Visit trends, churn, demand forecasting' },
    { icon: '💬', title: 'Sentiment Analysis', subtitle: 'Client & PSW satisfaction tracking' },
    { icon: '🎯', title: 'Visit Optimization', subtitle: 'Route & schedule optimization' },
    { icon: '⚠️', title: 'Churn Risk', subtitle: 'At-risk client identification' },
];

export function AiDashboard() {
    return (
        <PageTemplate
            pageId="D5"
            title="🤖 AI Dashboard"
            subtitle="Real-time overview and key performance indicators"
            actionPageId="admin.ai-dashboard"
            sectionData={{
                'D5.model-stats': { kpiCards: [
                    { label: 'Models Active', value: '1,247', color: '#8B5CF6' },
                    { label: 'Predictions Today', value: '3,829', color: 'var(--pc-primary)' },
                    { label: 'Accuracy', value: '94.2%', color: 'var(--pc-success)' },
                    { label: 'Alerts', value: 856, color: 'var(--pc-warning)' },
                ]},
                'D5.inference-chart': { chart: {
                    title: 'Inference Volume (Last 7 Days)',
                    type: 'bar',
                    data: [
                        { label: 'Mon', value: 520, color: '#8B5CF6' },
                        { label: 'Tue', value: 680, color: '#8B5CF6' },
                        { label: 'Wed', value: 590, color: '#8B5CF6' },
                        { label: 'Thu', value: 720, color: '#8B5CF6' },
                        { label: 'Fri', value: 830, color: '#8B5CF6' },
                        { label: 'Sat', value: 410, color: '#8B5CF6' },
                        { label: 'Sun', value: 280, color: '#8B5CF6' },
                    ],
                }},
                'D5.nav-cards': { cardGrid: { items: aiModules, columns: 4 } },
            }}
        />
    );
}

// --- Merged from D7-AICommandCenter.tsx ---
// ================================================================
// PAGE IDENTITY: D7 · AI Command Center — Unified Intelligence
// Type: Dashboard | Owner: admin | Registry: D20
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================


const aiModels = [
    { model: '🤖 Churn Predictor', accuracy: '91.3%', lastRun: '2 hrs ago', predictions: 12, status: 'ACTIVE' },
    { model: '🤖 Visit Duration Estimator', accuracy: '87.8%', lastRun: '1 hr ago', predictions: 230, status: 'ACTIVE' },
    { model: '🤖 Schedule Optimizer', accuracy: '89.2%', lastRun: '30 min ago', predictions: 45, status: 'ACTIVE' },
    { model: '🤖 Billing Anomaly Detector', accuracy: '94.1%', lastRun: '4 hrs ago', predictions: 8, status: 'ACTIVE' },
    { model: '🤖 Client Risk Assessment', accuracy: '85.5%', lastRun: '6 hrs ago', predictions: 34, status: 'TRAINING' },
];

const modelCols: TableColumn[] = [
    { key: 'model', label: 'Model' }, { key: 'accuracy', label: 'Accuracy' },
    { key: 'lastRun', label: 'Last Run' }, { key: 'predictions', label: 'Predictions' },
    { key: 'status', label: 'Status' },
];

const insights = [
    { icon: '📈', title: 'Visit Volume Forecast', subtitle: 'Next week: +8% visits. Tue/Thu peak.', badge: 'Forecasting' },
    { icon: '⚠️', title: 'Staff Turnover Risk', subtitle: '3 PSWs show burnout indicators.', badge: 'Retention' },
    { icon: '💰', title: 'Revenue Optimization', subtitle: '47 outstanding invoices → $12,400 recovery.', badge: 'Financial' },
    { icon: '🏥', title: 'Care Quality Index', subtitle: 'Overall: 4.3/5. Top: Priya Sharma (4.9).', badge: 'Clinical' },
];

export function AICommandCenter() {
    const [tab, setTab] = useState('recommendations');

    const tabContent: Record<string, Record<string, any>> = {
        recommendations: { 'D20.recommendations': { alerts: [
            { level: 'danger' as const, message: 'At-risk PSW: Kevin O\'Brien — engagement dropped 40% (87% confidence)', time: 'Critical' },
            { level: 'danger' as const, message: 'EVV gap: 3 visits on March 14 lack GPS verification — OHIP risk (99%)', time: 'Critical' },
            { level: 'warning' as const, message: 'Optimize Tuesday afternoon coverage — 23% higher cancellations (92%)', time: 'High' },
            { level: 'warning' as const, message: 'Invoice #INV-2847 may have billing error — 33% over-billed (95%)', time: 'Medium' },
            { level: 'info' as const, message: 'Client Helen Kowalski needs care plan review — glucose trending up (78%)', time: 'Accepted' },
        ]}},
        models: { 'D20.model-table': { table: { columns: modelCols, rows: aiModels } } },
        insights: { 'D20.insights-panel': { cardGrid: { items: insights, columns: 2 } } },
    };

    return (
        <PageTemplate
            pageId="D20"
            title="🧠 AI Command Center"
            subtitle="Unified intelligence — recommendations, sentiment, predictive models & insights"
            actionPageId="admin.ai-command"
            sectionData={{
                'D20.ai-stats': { kpiCards: [
                    { label: 'AI Recommendations', value: 5, icon: '🎯', color: 'var(--pc-primary)' },
                    { label: 'Models Active', value: '4/5', icon: '🤖', color: 'var(--pc-success)' },
                    { label: 'Avg Confidence', value: '90.2%', icon: '📊', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Predictions Today', value: 329, icon: '🔮', color: '#7C3AED' },
                    { label: 'Sentiment Score', value: '3.7/5', icon: '💭', color: 'var(--pc-warning)' },
                ]},
                'D20.recommendations': { tabs: {
                    tabs: [
                        { id: 'recommendations', label: '🎯 Recommendations', count: 5 },
                        { id: 'models', label: '🤖 AI Models', count: 5 },
                        { id: 'insights', label: '💡 Insights', count: 4 },
                    ],
                    activeTab: tab, onTabChange: setTab,
                }},
                ...tabContent[tab],
            }}
        />
    );
}

// --- Merged from T52-PredictiveAnalytics.tsx ---
// ================================================================
// PAGE IDENTITY: T52 · Predictive Analytics
// Type: Tool | Owner: admin | Registry: T52
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import type { TabItem } from '@/shared/components/sections';

export function PredictiveAnalytics() {
    const [tab, setTab] = useState('risk');
    const tabs: TabItem[] = [
        { id: 'risk', label: '🎯 Risk Scoring', count: 12 },
        { id: 'trends', label: '📈 Trend Forecast' },
        { id: 'anomaly', label: '⚠️ Anomaly Detection', count: 3 },
        { id: 'correlation', label: '🔗 Correlation Matrix' },
    ];

    const tabContent: Record<string, Record<string, any>> = {
        risk: { 'T52.content': { chart: { title: 'Client Risk Scores', type: 'horizontal-bar', data: [
            { label: 'Low Risk', value: 67, color: '#10B981' },
            { label: 'Medium Risk', value: 23, color: '#F59E0B' },
            { label: 'High Risk', value: 8, color: '#EF4444' },
            { label: 'Critical', value: 2, color: '#DC2626' },
        ]}}},
        trends: { 'T52.content': { chart: { title: 'Visit Demand Forecast (Next 30 Days)', type: 'bar', data: [
            { label: 'W1', value: 340 }, { label: 'W2', value: 380 },
            { label: 'W3', value: 365 }, { label: 'W4', value: 410 },
        ]}}},
        anomaly: { 'T52.content': { feed: { title: 'Detected Anomalies', items: [
            { icon: '🔴', title: 'PSW-032: Clock-in outside service area 3x this week', time: '1 hr ago', level: 'danger' as const },
            { icon: '🟡', title: 'Client Chen: Visit duration 3.2σ above mean', time: '3 hrs ago', level: 'warning' as const },
            { icon: '🟡', title: 'PSW-018: 12 consecutive missed signatures', time: '1 day ago', level: 'warning' as const },
        ]}}},
        correlation: { 'T52.content': { chart: { title: 'Factor Correlation Strength', type: 'donut', data: [
            { label: 'Visit Length ↔ Satisfaction', value: 34 },
            { label: 'Training ↔ Compliance', value: 28 },
            { label: 'Workload ↔ Burnout', value: 22 },
            { label: 'Distance ↔ Punctuality', value: 16 },
        ]}}},
    };

    return (
        <PageTemplate
            pageId="T52"
            title="📈 Predictive Analytics"
            subtitle="AI-powered risk scoring, trend forecasting, anomaly detection & correlation analysis"
            actionPageId="admin.predictive-analytics"
            sectionData={{
                'T52.stats': { kpiCards: [
                    { label: 'Models Running', value: 4, color: '#8B5CF6' },
                    { label: 'Predictions /Day', value: '3.8K', color: 'var(--pc-primary)' },
                    { label: 'Accuracy', value: '94.2%', color: 'var(--pc-success)' },
                    { label: 'Anomalies Found', value: 3, color: 'var(--pc-warning)' },
                ]},
                'T52.tabs': { tabs: { tabs, activeTab: tab, onTabChange: setTab } },
                ...tabContent[tab],
            }}
        />
    );
}

// --- Merged from T53-ChurnRisk.tsx ---
// ================================================================
// PAGE IDENTITY: T53 · Churn Risk
// Type: Tool | Owner: admin | Registry: T53
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================


const churnClients = [
    { client: '🔴 Margaret Chen', riskScore: '87%', factors: 'Missed 3 visits, satisfaction ↓', days: 14, action: 'Call scheduled' },
    { client: '🟠 Robert Williams', riskScore: '72%', factors: 'Auth exhausting (92%)', days: 21, action: 'Renewal pending' },
    { client: '🟡 Susan Park', riskScore: '58%', factors: 'PSW turnover (3 changes)', days: 45, action: 'Assign stable PSW' },
    { client: '🟡 James Brown', riskScore: '52%', factors: 'Missed medication 2x', days: 30, action: 'RN follow-up' },
    { client: '🟢 Helen Taylor', riskScore: '23%', factors: 'Stable – no flags', days: 90, action: 'Monitor' },
];

const churnCols: TableColumn[] = [
    { key: 'client', label: 'Client' }, { key: 'riskScore', label: 'Risk' },
    { key: 'factors', label: 'Contributing Factors' }, { key: 'days', label: 'Days Active' },
    { key: 'action', label: 'Recommended Action' },
];

export function ChurnRisk() {
    return (
        <PageTemplate
            pageId="T53"
            title="⚠️ Churn Risk Analysis"
            subtitle="AI-predicted client attrition risk with actionable intervention recommendations"
            actionPageId="admin.churn-risk"
            sectionData={{
                'T53.stats': { kpiCards: [
                    { label: 'At-Risk Clients', value: 4, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Avg Risk Score', value: '58.4%', color: 'var(--pc-warning)' },
                    { label: 'Interventions Active', value: 3, color: 'var(--pc-primary)' },
                    { label: 'Retention Rate', value: '94.1%', color: 'var(--pc-success)' },
                ]},
                'T53.churn-table': { table: { columns: churnCols, rows: churnClients } },
                'T53.trend': { chart: { title: 'Churn Risk Trend (6 Months)', type: 'bar', data: [
                    { label: 'Oct', value: 8 }, { label: 'Nov', value: 6 },
                    { label: 'Dec', value: 5 }, { label: 'Jan', value: 7 },
                    { label: 'Feb', value: 4 }, { label: 'Mar', value: 4 },
                ]}},
            }}
        />
    );
}

// --- Merged from T54-VisitOptimization.tsx ---
// ================================================================
// PAGE IDENTITY: T54 · Visit Optimization
// Type: Tool | Owner: admin | Registry: T54
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

const optimizationSuggestions = [
    { icon: '🗺️', title: 'Route Clustering — North York', subtitle: '3 visits can be grouped → save 45 min drive time' },
    { icon: '⏰', title: 'Schedule Gap — PSW Chen', subtitle: '2 hr gap between visits on Wed. Suggest backfill.' },
    { icon: '📍', title: 'Distance Alert — PSW Williams', subtitle: 'Visit #4 is 38km from #3. Suggest reassign.' },
    { icon: '✅', title: 'Optimal Match — Client Park', subtitle: 'PSW Santos best fit: 98% compatibility score' },
];

export function VisitOptimization() {
    return (
        <PageTemplate
            pageId="T54"
            title="🗺️ Visit Optimization"
            subtitle="AI-powered route clustering, schedule optimization & PSW-client matching"
            actionPageId="admin.visit-optimization"
            sectionData={{
                'T54.stats': { kpiCards: [
                    { label: 'Routes Optimized', value: 12, color: 'var(--pc-primary)' },
                    { label: 'Time Saved', value: '4.2 hrs', color: 'var(--pc-success)' },
                    { label: 'Fuel Saved', value: '$142', color: '#10B981' },
                    { label: 'Suggestions', value: 4, color: 'var(--pc-info, #2563EB)' },
                ]},
                'T54.suggestions': { cardGrid: { items: optimizationSuggestions, columns: 2 } },
                'T54.efficiency': { chart: { title: 'Weekly Efficiency Gains', type: 'bar', data: [
                    { label: 'Mon', value: 35, color: '#10B981' }, { label: 'Tue', value: 42, color: '#10B981' },
                    { label: 'Wed', value: 28, color: '#10B981' }, { label: 'Thu', value: 51, color: '#10B981' },
                    { label: 'Fri', value: 38, color: '#10B981' },
                ]}},
            }}
        />
    );
}

// --- Merged from T55-SentimentAnalysis.tsx ---
// ================================================================
// PAGE IDENTITY: T55 · Sentiment Analysis
// Type: Tool | Owner: admin | Registry: T55
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

const sentimentFeed = [
    { icon: '😊', title: 'Client Park: "PSW Santos is wonderful, always on time"', time: 'Today', level: 'success' as const },
    { icon: '😐', title: 'Client Brown: "Visit was fine, nothing special"', time: 'Yesterday', level: 'info' as const },
    { icon: '😟', title: 'Client Chen: "PSW arrived 20 min late, no notification"', time: '2 days ago', level: 'warning' as const },
    { icon: '😠', title: 'Family Williams: "Scheduling keeps changing without notice"', time: '3 days ago', level: 'danger' as const },
    { icon: '😊', title: 'Client Taylor: "Best care my mother has ever received"', time: '4 days ago', level: 'success' as const },
];

export function SentimentAnalysis() {
    return (
        <PageTemplate
            pageId="T55"
            title="💬 Sentiment Analysis"
            subtitle="AI-powered sentiment tracking from surveys, calls, and feedback forms"
            actionPageId="admin.sentiment-analysis"
            sectionData={{
                'T55.stats': { kpiCards: [
                    { label: 'Overall Score', value: '3.7/5', color: 'var(--pc-primary)' },
                    { label: 'Positive', value: '62%', color: 'var(--pc-success)' },
                    { label: 'Neutral', value: '28%', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Negative', value: '10%', color: 'var(--pc-error, #ef4444)' },
                ]},
                'T55.trend': { chart: { title: 'Sentiment Trend (6 Months)', type: 'bar', data: [
                    { label: 'Oct', value: 72, color: '#10B981' }, { label: 'Nov', value: 68, color: '#F59E0B' },
                    { label: 'Dec', value: 74, color: '#10B981' }, { label: 'Jan', value: 65, color: '#F59E0B' },
                    { label: 'Feb', value: 71, color: '#10B981' }, { label: 'Mar', value: 62, color: '#F59E0B' },
                ]}},
                'T55.feed': { feed: { title: '📡 Recent Feedback', items: sentimentFeed } },
            }}
        />
    );
}

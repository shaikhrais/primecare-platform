import type { TableColumn } from '@/shared/components/sections';
import React, { useState } from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from D5-AiDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D5 · AI Dashboard
// Type: Dashboard | Owner: admin | Registry: D5
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function AiDashboard() {
    return (
        <PageTemplate
            pageId="D5"
            title="🤖 AI Dashboard"
            subtitle="Real-time overview and key performance indicators"
            actionPageId="admin.ai-dashboard"
            sectionData={PageSectionRegistry['D5']}
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
            sectionData={PageSectionRegistry['D20']}
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
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

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
            sectionData={PageSectionRegistry['T52']}
        />
    );
}

// --- Merged from T53-ChurnRisk.tsx ---
// ================================================================
// PAGE IDENTITY: T53 · Churn Risk
// Type: Tool | Owner: admin | Registry: T53
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function ChurnRisk() {
    return (
        <PageTemplate
            pageId="T53"
            title="⚠️ Churn Risk Analysis"
            subtitle="AI-predicted client attrition risk with actionable intervention recommendations"
            actionPageId="admin.churn-risk"
            sectionData={PageSectionRegistry['T53']}
        />
    );
}

// --- Merged from T54-VisitOptimization.tsx ---
// ================================================================
// PAGE IDENTITY: T54 · Visit Optimization
// Type: Tool | Owner: admin | Registry: T54
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function VisitOptimization() {
    return (
        <PageTemplate
            pageId="T54"
            title="🗺️ Visit Optimization"
            subtitle="AI-powered route clustering, schedule optimization & PSW-client matching"
            actionPageId="admin.visit-optimization"
            sectionData={PageSectionRegistry['T54']}
        />
    );
}

// --- Merged from T55-SentimentAnalysis.tsx ---
// ================================================================
// PAGE IDENTITY: T55 · Sentiment Analysis
// Type: Tool | Owner: admin | Registry: T55
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function SentimentAnalysis() {
    return (
        <PageTemplate
            pageId="T55"
            title="💬 Sentiment Analysis"
            subtitle="AI-powered sentiment tracking from surveys, calls, and feedback forms"
            actionPageId="admin.sentiment-analysis"
            sectionData={PageSectionRegistry['T55']}
        />
    );
}

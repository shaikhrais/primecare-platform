// ================================================================
// PAGE IDENTITY: T55 · Sentiment Analysis
// Type: Tool | Owner: admin | Registry: T55
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

const sentimentFeed = [
    { icon: '😊', title: 'Client Park: "PSW Santos is wonderful, always on time"', time: 'Today', level: 'success' as const },
    { icon: '😐', title: 'Client Brown: "Visit was fine, nothing special"', time: 'Yesterday', level: 'info' as const },
    { icon: '😟', title: 'Client Chen: "PSW arrived 20 min late, no notification"', time: '2 days ago', level: 'warning' as const },
    { icon: '😠', title: 'Family Williams: "Scheduling keeps changing without notice"', time: '3 days ago', level: 'danger' as const },
    { icon: '😊', title: 'Client Taylor: "Best care my mother has ever received"', time: '4 days ago', level: 'success' as const },
];

export default function SentimentAnalysis() {
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

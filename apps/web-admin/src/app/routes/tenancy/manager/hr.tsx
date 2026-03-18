import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from L15-PerformanceReviews.tsx ---
// ================================================================
// PAGE IDENTITY: L15 · Performance Reviews
// Type: List | Owner: manager | Registry: L23
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import type { TableColumn } from '@/shared/components/sections';

const reviews = [
    { psw: 'Priya Sharma', period: 'Q1 2026', overall: '4.8', quality: '5.0', punctuality: '4.9', communication: '4.7', status: '✅ Completed', reviewer: 'Sarah Manager', date: 'Mar 12' },
    { psw: 'David Chen', period: 'Q1 2026', overall: '4.5', quality: '4.6', punctuality: '4.8', communication: '4.3', status: '✅ Completed', reviewer: 'Sarah Manager', date: 'Mar 11' },
    { psw: 'Maria Santos', period: 'Q1 2026', overall: '4.2', quality: '4.5', punctuality: '4.0', communication: '4.3', status: '⏳ Pending Review', reviewer: 'Tom Supervisor', date: 'Mar 15' },
    { psw: 'James Wright', period: 'Q1 2026', overall: '3.6', quality: '3.8', punctuality: '3.2', communication: '3.5', status: '⚠️ Needs Improvement', reviewer: 'Sarah Manager', date: 'Mar 14' },
    { psw: 'Kevin O\'Brien', period: 'Q1 2026', overall: '—', quality: '—', punctuality: '—', communication: '—', status: '📝 Not Started', reviewer: 'Tom Supervisor', date: '—' },
];

const reviewCols: TableColumn[] = [
    { key: 'psw', label: 'PSW' }, { key: 'overall', label: 'Overall' },
    { key: 'quality', label: 'Quality' }, { key: 'punctuality', label: 'Punctuality' },
    { key: 'communication', label: 'Communication' }, { key: 'status', label: 'Status' },
    { key: 'reviewer', label: 'Reviewer' }, { key: 'date', label: 'Date' },
];

export function PerformanceReviews() {
    return (
        <PageTemplate
            pageId="L23"
            title="📊 Performance Reviews"
            subtitle="Q1 2026 — PSW performance evaluations"
            actionPageId="manager.performance-reviews"
            sectionData={{
                'L23.stats': { kpiCards: [
                    { label: 'Total Reviews', value: 5, color: 'var(--pc-primary)' },
                    { label: 'Completed', value: 2, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Avg Score', value: '4.3', color: 'var(--pc-success)' },
                ]},
                'L23.review-table': { table: { columns: reviewCols, rows: reviews } },
            }}
        />
    );
}

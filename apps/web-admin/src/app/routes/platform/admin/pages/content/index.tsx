import { useState } from 'react';
import { TabItem } from '@/shared/components/sections/SectionTabs';
import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Re-export from identity file: T2-ContentManager.tsx
import { useDialog } from '@/shared/hooks/useDialog';
// removed broken export: export { default } from './T2-ContentManager';


// --- Merged from T2-ContentManager.tsx ---
// ================================================================
// PAGE IDENTITY: T2 · Content Manager
// Type: Tool | Owner: admin
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================




const blogPosts = [
    { title: 'Introducing PrimeCare Home Care Platform', date: 'Mar 12, 2026', status: '✅ Published', views: 1240 },
    { title: 'HIPAA Compliance Best Practices for PSWs', date: 'Mar 8, 2026', status: '✅ Published', views: 890 },
    { title: 'Remote Patient Monitoring: The Future of Home Care', date: 'Mar 5, 2026', status: '📝 Draft', views: 0 },
];

const faqItems = [
    { question: 'How do I reset my password?', category: 'Account', status: '✅ Active', helpfulness: '92%' },
    { question: 'What certifications does PrimeCare require?', category: 'Compliance', status: '✅ Active', helpfulness: '88%' },
    { question: 'How does the scheduling system work?', category: 'Operations', status: '✅ Active', helpfulness: '95%' },
];

const blogCols: TableColumn[] = [
    { key: 'title', label: 'Title' }, { key: 'date', label: 'Date' },
    { key: 'status', label: 'Status' }, { key: 'views', label: 'Views' },
];
const faqCols: TableColumn[] = [
    { key: 'question', label: 'Question' }, { key: 'category', label: 'Category' },
    { key: 'status', label: 'Status' }, { key: 'helpfulness', label: 'Helpfulness' },
];

export function ContentManager() {
    const [tab, setTab] = useState('blogs');
    const tabs: TabItem[] = [
        { id: 'blogs', label: '📝 Blog Posts', count: 3 },
        { id: 'faqs', label: '❓ FAQs', count: 3 },
    ];

    return (
        <PageTemplate pageId="T2" title="📝 Content Manager" subtitle="Manage blog posts, FAQs & marketing content"
            actionPageId="admin.content-manager"
            sectionData={{
                'T2.stats': { kpiCards: [
                    { label: 'Published', value: 2, color: 'var(--pc-success)' },
                    { label: 'Drafts', value: 1, color: 'var(--pc-warning)' },
                    { label: 'FAQs', value: 3, color: 'var(--pc-primary)' },
                    { label: 'Total Views', value: '2.1K', color: 'var(--pc-info, #2563EB)' },
                ]},
                'T2.tabs': { tabs: { tabs, activeTab: tab, onTabChange: setTab } },
                'T2.content': { table: {
                    columns: tab === 'blogs' ? blogCols : faqCols,
                    rows: tab === 'blogs' ? blogPosts : faqItems,
                }},
            }}
        />
    );
}
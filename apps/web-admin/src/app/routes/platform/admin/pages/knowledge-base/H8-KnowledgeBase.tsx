// PAGE IDENTITY: H8 · Knowledge Base
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function KnowledgeBase() {
    return (
        <PageTemplate pageId="H8" title="📚 Knowledge Base" subtitle="Internal wiki, SOPs, training resources & policy documentation"
            sectionData={{
                'H8.stats': { kpiCards: [
                    { label: 'Articles', value: 148, color: 'var(--pc-primary)' },
                    { label: 'Categories', value: 12, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Views MTD', value: '2.4K', color: 'var(--pc-success)' },
                    { label: 'Last Updated', value: 'Today', color: '#7C3AED' },
                ]},
                'H8.categories': { cardGrid: { items: [
                    { icon: '📋', title: 'Standard Operating Procedures', subtitle: '42 articles — visit protocols, incident reporting' },
                    { icon: '🏥', title: 'Clinical Guidelines', subtitle: '28 articles — care plans, medication admin, wound care' },
                    { icon: '📊', title: 'HR & Policies', subtitle: '35 articles — employment standards, benefits, safety' },
                    { icon: '💻', title: 'Technology', subtitle: '18 articles — platform guides, EVV, telehealth setup' },
                    { icon: '📝', title: 'Training Materials', subtitle: '25 articles — onboarding, HIPAA, certifications' },
                ], columns: 3 } },
            }}
        />
    );
}

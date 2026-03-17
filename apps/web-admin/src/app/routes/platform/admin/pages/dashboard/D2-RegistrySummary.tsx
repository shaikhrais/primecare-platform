// PAGE IDENTITY: D2 · Registry Summary
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

const registryModules = [
    { icon: '📋', title: 'Page Registry', subtitle: '139 pages registered across admin & tenancy' },
    { icon: '🔗', title: 'API Registry', subtitle: '85 endpoints, 12 modules, 4 middleware chains' },
    { icon: '📊', title: 'Section Registry', subtitle: '15 section types, 60+ page configurations' },
    { icon: '🔑', title: 'Role Registry', subtitle: '6 roles, 142 permissions, 5 scopes' },
    { icon: '📡', title: 'Event Registry', subtitle: '24 event types, 6 automation hooks' },
    { icon: '🎨', title: 'Theme Registry', subtitle: '3 themes, 24 CSS variables, dark mode' },
];

export default function RegistrySummary() {
    return (
        <PageTemplate pageId="D2" title="📊 Registry Summary" subtitle="Overview of all platform registries — pages, APIs, sections, roles & events"
            sectionData={{
                'D2.stats': { kpiCards: [
                    { label: 'Total Pages', value: 139, color: 'var(--pc-primary)' },
                    { label: 'API Endpoints', value: 85, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Section Types', value: 15, color: '#8B5CF6' },
                    { label: 'Registries', value: 6, color: 'var(--pc-success)' },
                ]},
                'D2.registries': { cardGrid: { items: registryModules, columns: 3 } },
            }}
        />
    );
}

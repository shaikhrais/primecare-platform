import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Re-export from identity file: T3-TemplateEditor.tsx
// removed broken export: export { default } from './T3-TemplateEditor';


// --- Merged from list.tsx ---
export function TemplatesList() {
    return (
        <PageTemplate 
            pageId="PGE-TL" 
            title="✨ Templates List" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'TL.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'TL.empty']: { emptyState: { title: 'Templates List Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}

// --- Merged from T3-TemplateEditor.tsx ---
// PAGE IDENTITY: T3 · Template Editor



export function TemplateEditor() {
    return (
        <PageTemplate pageId="T3" title="🎨 Template Editor" subtitle="Design & manage email, SMS, PDF & form templates"
            sectionData={{
                'T3.stats': { kpiCards: [
                    { label: 'Templates', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Email', value: 12, color: 'var(--pc-info, #2563EB)' },
                    { label: 'SMS', value: 6, color: 'var(--pc-success)' },
                    { label: 'PDF', value: 6, color: '#7C3AED' },
                ]},
                'T3.modules': { cardGrid: { items: [
                    { icon: '📧', title: 'Email Templates', subtitle: 'Visit reminders, billing, welcome, security alerts' },
                    { icon: '📱', title: 'SMS Templates', subtitle: 'Shift confirmations, schedule changes, auth alerts' },
                    { icon: '📄', title: 'PDF Templates', subtitle: 'Invoices, reports, care plans, timesheets' },
                    { icon: '📋', title: 'Form Templates', subtitle: 'Intake forms, assessments, incident reports' },
                ], columns: 2 } },
            }}
        />
    );
}
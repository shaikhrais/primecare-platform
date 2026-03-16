// ================================================================
// PAGE IDENTITY: H24 · Training Academy — Staff Development
// Type: Hub | Owner: manager | Registry: H29
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React, { useState } from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const courses = [
    { name: 'Fall Prevention & Response', category: 'Safety', duration: '45 min', enrolled: 42, completed: 38, rate: '90%', rating: '⭐ 4.8', mandatory: 'YES' },
    { name: 'HIPAA Compliance 2026', category: 'Compliance', duration: '30 min', enrolled: 48, completed: 48, rate: '100%', rating: '⭐ 4.2', mandatory: 'YES' },
    { name: 'Dementia Care Best Practices', category: 'Clinical', duration: '60 min', enrolled: 35, completed: 28, rate: '80%', rating: '⭐ 4.9', mandatory: '—' },
    { name: 'Medication Administration', category: 'Clinical', duration: '90 min', enrolled: 40, completed: 32, rate: '80%', rating: '⭐ 4.7', mandatory: 'YES' },
    { name: 'Cultural Sensitivity Training', category: 'Professional', duration: '30 min', enrolled: 30, completed: 25, rate: '83%', rating: '⭐ 4.5', mandatory: '—' },
    { name: 'PrimeCare App Training', category: 'Technical', duration: '20 min', enrolled: 48, completed: 45, rate: '94%', rating: '⭐ 4.3', mandatory: 'YES' },
    { name: 'Infection Control & PPE', category: 'Safety', duration: '40 min', enrolled: 44, completed: 40, rate: '91%', rating: '⭐ 4.6', mandatory: 'YES' },
];

const courseCols: TableColumn[] = [
    { key: 'name', label: 'Course' }, { key: 'category', label: 'Category' },
    { key: 'duration', label: 'Duration' }, { key: 'enrolled', label: 'Enrolled' },
    { key: 'completed', label: 'Done' }, { key: 'rate', label: '%' },
    { key: 'rating', label: 'Rating' }, { key: 'mandatory', label: 'Required' },
];

const certifications = [
    { name: '🏆 Priya Sharma', description: '✅ Fall Prevention, ✅ HIPAA, ✅ Medication Admin, ✅ Infection Control, ✅ App Training', progress: 100, badge: '5 certs' },
    { name: '🏆 David Chen', description: '✅ Fall Prevention, ✅ HIPAA, ✅ Infection Control, ✅ App Training', progress: 80, badge: '4 certs', meta: '⚠ 1 expiring' },
    { name: '🏆 Maria Santos', description: '✅ HIPAA, ✅ Medication Admin, ✅ App Training', progress: 60, badge: '3 certs' },
    { name: '🏆 James Wright', description: '✅ HIPAA, ✅ App Training', progress: 40, badge: '2 certs', meta: '⚠ 2 expiring' },
];

export default function TrainingAcademy() {
    const [tab, setTab] = useState('courses');

    const tabContent: Record<string, Record<string, any>> = {
        courses: { 'H29.module-grid': { table: { columns: courseCols, rows: courses } } },
        progress: { 'H29.progress': { progressList: { items: certifications } } },
    };

    return (
        <PageTemplate
            pageId="H29"
            title="🎓 Training Academy"
            subtitle="Courses, certifications & staff development tracking"
            actionPageId="manager.training-academy"
            sectionData={{
                'H29.stats': { kpiCards: [
                    { label: 'Active Courses', value: 7, color: 'var(--pc-primary)' },
                    { label: 'Total Enrollments', value: 287, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Completion Rate', value: '86%', color: 'var(--pc-success)' },
                    { label: 'Expiring Certs', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Avg Rating', value: '4.6 ⭐', color: 'var(--pc-success)' },
                ]},
                'H29.module-grid': { tabs: {
                    tabs: [
                        { id: 'courses', label: '📚 Courses', count: 7 },
                        { id: 'progress', label: '🏆 Certifications', count: 4 },
                    ],
                    activeTab: tab, onTabChange: setTab,
                }},
                ...tabContent[tab],
            }}
        />
    );
}

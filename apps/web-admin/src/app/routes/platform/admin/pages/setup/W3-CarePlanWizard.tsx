// PAGE IDENTITY: W3 · Care Plan Wizard
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function CarePlanWizard() {
    return (<PageTemplate pageId="W3" title="📋 Care Plan Wizard" subtitle="Build individualized care plans with assessments, goals & interventions"
        sectionData={{ 'W3.steps': { cardGrid: { items: [
            { icon: '1️⃣', title: 'Client Assessment', subtitle: 'RAI-HC, functional status, cognitive & risk factors' },
            { icon: '2️⃣', title: 'Goals & Outcomes', subtitle: 'SMART goals, measurement criteria, timeline' },
            { icon: '3️⃣', title: 'Interventions', subtitle: 'Service plan, frequency, provider assignments' },
            { icon: '4️⃣', title: 'Review & Approve', subtitle: 'Clinical review, family consent, publish' },
        ], columns: 4 } } }} />
    );
}

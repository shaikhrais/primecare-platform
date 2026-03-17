// PAGE IDENTITY: W1 · Business Setup Wizard
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function BusinessSetupWizard() {
    return (<PageTemplate pageId="W1" title="🏢 Business Setup Wizard" subtitle="Step-by-step guide to configure your organization"
        sectionData={{ 'W1.steps': { cardGrid: { items: [
            { icon: '1️⃣', title: 'Organization Info', subtitle: 'Legal name, address, business number' },
            { icon: '2️⃣', title: 'License & Compliance', subtitle: 'LHIN, MOH, OHIP provider number' },
            { icon: '3️⃣', title: 'Service Configuration', subtitle: 'Service types, rates, zones' },
            { icon: '4️⃣', title: 'Payment & Billing', subtitle: 'Bank info, payer setup, tax config' },
            { icon: '5️⃣', title: 'Integrations', subtitle: 'Email, SMS, EMR, EVV, payroll' },
            { icon: '6️⃣', title: 'Go Live', subtitle: 'Final checks, user invites, launch' },
        ], columns: 3 } } }} />
    );
}

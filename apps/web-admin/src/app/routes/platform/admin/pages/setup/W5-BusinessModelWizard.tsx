// PAGE IDENTITY: W5 · Business Model Wizard
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function BusinessModelWizard() {
    return (<PageTemplate pageId="W5" title="🏗️ Business Model Wizard" subtitle="Configure franchise model, pricing tiers, territory & revenue sharing"
        sectionData={{ 'W5.steps': { cardGrid: { items: [
            { icon: '1️⃣', title: 'Model Selection', subtitle: 'Franchise, corporate, hybrid or white-label' },
            { icon: '2️⃣', title: 'Territory Setup', subtitle: 'Geographic zones, exclusive areas, overlap rules' },
            { icon: '3️⃣', title: 'Revenue Sharing', subtitle: 'Commission rates, royalty structure, payouts' },
            { icon: '4️⃣', title: 'Launch', subtitle: 'Branding, domains, onboarding materials' },
        ], columns: 4 } } }} />
    );
}

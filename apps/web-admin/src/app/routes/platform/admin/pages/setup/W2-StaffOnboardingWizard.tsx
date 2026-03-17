// PAGE IDENTITY: W2 · Staff Onboarding Wizard
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function StaffOnboardingWizard() {
    return (<PageTemplate pageId="W2" title="🎓 Staff Onboarding Wizard" subtitle="Guided PSW/RN onboarding — credentials, training & compliance"
        sectionData={{ 'W2.steps': { cardGrid: { items: [
            { icon: '1️⃣', title: 'Personal Details', subtitle: 'Contact info, emergency contacts, demographics' },
            { icon: '2️⃣', title: 'Credentials', subtitle: 'CPR, First Aid, VSS, TB test, training certs' },
            { icon: '3️⃣', title: 'Training Modules', subtitle: 'HIPAA, WHMIS, platform training, safety' },
            { icon: '4️⃣', title: 'Go Live', subtitle: 'Supervisor sign-off, badge issue, first shift' },
        ], columns: 4 } } }} />
    );
}

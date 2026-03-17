// PAGE IDENTITY: F11 · Lead Entry
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function LeadEntryForm() {
    return (
        <PageTemplate pageId="F11" title="➕ New Lead Entry" subtitle="Capture new lead information, service interest & contact details"
            sectionData={{
                'F11.form': { cardGrid: { items: [
                    { icon: '👤', title: 'Contact Information', subtitle: 'Name, phone, email & preferred contact method' },
                    { icon: '🏥', title: 'Service Interest', subtitle: 'Requested service, urgency & availability' },
                    { icon: '📋', title: 'Source & Notes', subtitle: 'Referral source, initial notes & follow-up plan' },
                    { icon: '📊', title: 'Qualification', subtitle: 'Budget, timeline, decision maker & scoring' },
                ], columns: 2 } },
            }}
        />
    );
}

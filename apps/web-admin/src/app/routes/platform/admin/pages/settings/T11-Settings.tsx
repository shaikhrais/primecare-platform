// PAGE IDENTITY: T11 · Settings
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function Settings() {
    return (
        <PageTemplate pageId="T11" title="⚙️ Platform Settings" subtitle="General configuration, branding, integrations & system preferences"
            sectionData={{
                'T11.modules': { cardGrid: { items: [
                    { icon: '🎨', title: 'Branding', subtitle: 'Logo, colors, fonts & white-label config' },
                    { icon: '🔗', title: 'Integrations', subtitle: 'Twilio, SendGrid, Stripe, OHIP, EMR connections' },
                    { icon: '🔐', title: 'Security', subtitle: 'Password policy, MFA, session timeout, IP whitelist' },
                    { icon: '📧', title: 'Email Templates', subtitle: 'Notification templates, signatures & branding' },
                    { icon: '🌐', title: 'Localization', subtitle: 'Language, timezone, date format & currency' },
                    { icon: '📊', title: 'Data Management', subtitle: 'Backup, export, retention policies & GDPR tools' },
                ], columns: 3 } },
            }}
        />
    );
}

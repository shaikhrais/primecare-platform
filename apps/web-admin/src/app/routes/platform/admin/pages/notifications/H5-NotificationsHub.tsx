// PAGE IDENTITY: H5 · Notifications Hub
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function NotificationsHub() {
    return (
        <PageTemplate pageId="H5" title="🔔 Notifications Hub" subtitle="Push notifications, email alerts, SMS & in-app notification management"
            sectionData={{
                'H5.stats': { kpiCards: [
                    { label: 'Sent Today', value: 342, color: 'var(--pc-primary)' },
                    { label: 'Delivery Rate', value: '98%', color: 'var(--pc-success)' },
                    { label: 'Templates', value: 18, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Channels', value: 4, color: '#7C3AED' },
                ]},
                'H5.channels': { cardGrid: { items: [
                    { icon: '📧', title: 'Email', subtitle: 'Transactional & marketing emails via SendGrid' },
                    { icon: '📱', title: 'SMS', subtitle: 'Twilio-powered text messages' },
                    { icon: '🔔', title: 'Push', subtitle: 'PWA push notifications via service worker' },
                    { icon: '💬', title: 'In-App', subtitle: 'Real-time notification bell & toast messages' },
                ], columns: 4 } },
                'H5.recent': { feed: { title: '📡 Recent Notifications', items: [
                    { icon: '📧', title: 'Visit Reminder — Margaret Chen — Tomorrow 10:00 AM', time: '5 min ago', level: 'info' as const },
                    { icon: '📱', title: 'Shift Confirmation SMS — PSW Santos', time: '15 min ago', level: 'success' as const },
                    { icon: '🔔', title: 'Auth Exhaustion Alert — Susan Park (92%)', time: '1 hr ago', level: 'warning' as const },
                ]}},
            }}
        />
    );
}

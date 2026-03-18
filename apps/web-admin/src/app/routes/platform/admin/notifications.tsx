import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from H5-NotificationsHub.tsx ---
// PAGE IDENTITY: H5 · Notifications Hub

export function NotificationsHub() {
    return (
        <PageTemplate pageId="H5" title="🔔 Notifications Hub" subtitle="Push notifications, email alerts, SMS & in-app notification management"
            sectionData={PageSectionRegistry['H5']}
        />
    );
}

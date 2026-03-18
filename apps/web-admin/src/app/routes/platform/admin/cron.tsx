import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from D6-CronDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D6 · Cron Dashboard
// Type: Dashboard | Owner: admin | Registry: D6
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// NOTE: Preserves API mutation logic for job execution
// ================================================================
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import type { TableColumn } from '@/shared/components/sections';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

export function CronDashboard() {
    const { t } = useTranslation();

    return (
        <PageTemplate
            pageId="D6"
            title="⏱️ Scheduled Jobs Dashboard"
            subtitle="Monitor automated cron tasks — compliance sweeps, training reminders, auth monitoring & inventory alerts"
            actionPageId="admin.cron-dashboard"
            sectionData={PageSectionRegistry['D6']}
        />
    );
}

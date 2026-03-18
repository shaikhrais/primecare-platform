// PAGE IDENTITY: D6-Obs · Observability Dashboard (separate from D6-Cron)
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

export default function ObservabilityDashboard() {
    return (
        <PageTemplate pageId="D6-OBS" title="📡 Observability Dashboard" subtitle="Application metrics, error tracking, latency & infrastructure health"
            isLive
            sectionData={PageSectionRegistry['D6-OBS']}
        />
    );
}

import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from H4-SupplyChainHub.tsx ---
// PAGE IDENTITY: H4 · Supply Chain / ERP Hub

export function SupplyChainHub() {
    return (
        <PageTemplate pageId="H4" title="📦 Supply Chain & ERP Hub" subtitle="Inventory, purchasing, vendor management & demand forecasting"
            sectionData={PageSectionRegistry['H4']}
        />
    );
}

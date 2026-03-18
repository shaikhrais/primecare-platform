import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from H14-CredentialVault.tsx ---
export function CredentialVault() {
    return (
        <PageTemplate pageId="H14" title="Credential Vault" subtitle="Professional certifications, licenses and compliance documents"
            sectionData={PageSectionRegistry['H14']}
        />
    );
}

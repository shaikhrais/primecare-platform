import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from H21-DocumentSigningCenter.tsx ---
// ================================================================
// PAGE IDENTITY: H21 · Document Signing Center — e-Signatures
// Type: Hub | Owner: manager | Registry: H27
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import type { TableColumn } from '@/shared/components/sections';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

const documents = [
    { name: '📄 Employment Contract — Priya Sharma', type: 'Contract', status: 'PENDING', signers: '⏳ Priya Sharma, ✅ HR Director', created: '2 hrs ago', expires: '7 days' },
    { name: '📄 HIPAA Compliance Agreement 2026', type: 'Compliance', status: 'COMPLETED', signers: '✅ David Chen, ✅ Compliance Officer', created: '1 day ago', expires: '—' },
    { name: '📄 Client Care Plan — Margaret Chen', type: 'Care Plan', status: 'PENDING', signers: '⏳ Margaret Chen, ✅ Dr. Williams, ⏳ Case Manager', created: '3 hrs ago', expires: '14 days' },
    { name: '📄 Incident Report #IR-2026-087', type: 'Incident', status: 'EXPIRED', signers: '✅ Kevin O\'Brien, ⏳ Supervisor', created: '15 days ago', expires: 'Expired' },
    { name: '📄 NDA — PrimeCare × MedTech Inc.', type: 'NDA', status: 'PENDING', signers: '✅ CEO, ⏳ MedTech Rep', created: '5 hrs ago', expires: '30 days' },
    { name: '📄 Training Acknowledgment — Fall Prevention', type: 'Training', status: 'COMPLETED', signers: '✅ James Wright', created: '2 days ago', expires: '—' },
];
const templates = [
    { icon: '📋', title: 'Employment Contract', subtitle: '45 uses' },
    { icon: '🔒', title: 'HIPAA Agreement', subtitle: '120 uses' },
    { icon: '❤️', title: 'Care Plan Consent', subtitle: '89 uses' },
    { icon: '📝', title: 'Incident Report', subtitle: '34 uses' },
    { icon: '🤐', title: 'Non-Disclosure Agreement', subtitle: '12 uses' },
    { icon: '📚', title: 'Training Acknowledgment', subtitle: '67 uses' },
];

export function DocumentSigningCenter() {
    return (
        <PageTemplate
            pageId="H27"
            title="✍️ Document Signing Center"
            subtitle="Digital signatures, audit trails & compliance documents"
            actionPageId="manager.document-signing"
            sectionData={PageSectionRegistry['H27']}
        />
    );
}

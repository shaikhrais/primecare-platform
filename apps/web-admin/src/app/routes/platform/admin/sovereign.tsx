import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T6-SovereignWallet.tsx ---
// PAGE IDENTITY: T6 · Sovereign Wallet

export function SovereignWallet() {
    return (
        <PageTemplate pageId="T6" title="🔐 Sovereign Wallet" subtitle="Decentralized identity, verifiable credentials & blockchain-based trust"
            sectionData={PageSectionRegistry['T6']}
        />
    );
}

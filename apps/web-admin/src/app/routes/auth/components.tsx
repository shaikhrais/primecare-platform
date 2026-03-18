import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from '../shared/PageSectionRegistry';

// --- Merged from BiometricLogin.tsx ---
export function BiometricLogin() {
    return (
        <PageTemplate 
            pageId="PGE-${Math.floor(Math.random() * 900 + 100)}" 
             
            
            sectionData={PageSectionRegistry['COMPLEX_KEY_0']}
        />
    );
}

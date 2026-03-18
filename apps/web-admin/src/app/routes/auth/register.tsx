import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../shared/PageSectionRegistry";

export function Register() {
    return (
        <PageTemplate 
            pageId="PGE-${Math.floor(Math.random() * 900 + 100)}" 
            title="Register" 
            subtitle="System Module"
            sectionData={PageSectionRegistry['COMPLEX_KEY_5']}
        />
    );
}

export default Register;

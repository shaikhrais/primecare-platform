import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export function Login() {
    return (
        <PageTemplate 
            pageId="PGE-${Math.floor(Math.random() * 900 + 100)}" 
            title="Login" 
            subtitle="System Module"
            sectionData={{
                'mod.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
                ]},
                'mod.body': { emptyState: { 
                    title: 'Login', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            }}
        />
    );
}

export default Login;

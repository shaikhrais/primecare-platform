// PAGE IDENTITY: F9a · User Entry
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function UserEntry() {
    return (
        <PageTemplate pageId="F9a" title="➕ New User" subtitle="Create new platform user with role assignment & access configuration"
            sectionData={{
                'F9a.form': { cardGrid: { items: [
                    { icon: '👤', title: 'Personal Information', subtitle: 'Name, email, phone & profile details' },
                    { icon: '🔑', title: 'Role & Permissions', subtitle: 'Assign role, custom permissions & access level' },
                    { icon: '🏥', title: 'Organization', subtitle: 'Department, team, supervisor & location' },
                    { icon: '🔐', title: 'Security', subtitle: 'MFA requirement, password policy & device limits' },
                ], columns: 2 } },
            }}
        />
    );
}

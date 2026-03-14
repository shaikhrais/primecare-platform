// Role flow data: config for each role's workflow steps
import { AdminRegistry } from 'prime-care-shared';
const { ContentRegistry } = AdminRegistry;

export interface RoleFlowEntry {
    label: string;
    steps: readonly string[];
    color: string;
    icon: string;
}

export function buildRoleFlows(t: (key: string) => string): Record<string, RoleFlowEntry> {
    return {
        admin: {
            label: t(ContentRegistry.ROLE_LABELS.ADMIN),
            icon: '👑',
            color: 'var(--brand-500)',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.ADMIN,
        },
        scrum_master: {
            label: t(ContentRegistry.ROLE_LABELS.SCRUM_MASTER),
            icon: '🚀',
            color: '#8b5cf6',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.SCRUM_MASTER,
        },
        manager: {
            label: t(ContentRegistry.ROLE_LABELS.MANAGER),
            icon: '🏢',
            color: '#3b82f6',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.MANAGER,
        },
        staff: {
            label: t(ContentRegistry.ROLE_LABELS.STAFF),
            icon: '👤',
            color: '#10b981',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.STAFF,
        },
        psw: {
            label: t(ContentRegistry.ROLE_LABELS.PSW),
            icon: '🩺',
            color: '#f59e0b',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.PSW,
        },
        rn: {
            label: t(ContentRegistry.ROLE_LABELS.RN),
            icon: '🩺',
            color: '#06b6d4',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.RN,
        },
        marketing_manager: {
            label: 'Marketing Manager',
            icon: '📈',
            color: '#ec4899',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.MARKETING_MANAGER,
        },
        hr_manager: {
            label: 'HR Manager',
            icon: '👤',
            color: '#8b5cf6',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.HR_MANAGER,
        },
        recruiting_manager: {
            label: 'Recruiting Manager',
            icon: '🤝',
            color: '#6366f1',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.RECRUITING_MANAGER,
        },
        finance_manager: {
            label: 'Finance Manager',
            icon: '💰',
            color: '#0ea5e9',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.FINANCE_MANAGER,
        },
        regional_manager: {
            label: 'Regional Manager',
            icon: '🏢',
            color: '#0f172a',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.REGIONAL_MANAGER,
        },
        clinical_manager: {
            label: 'Clinical Manager',
            icon: '🩺',
            color: '#e11d48',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.CLINICAL_MANAGER,
        },
        coordinator: {
            label: 'Coordinator',
            icon: '📡',
            color: '#06b6d4',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.COORDINATOR,
        },
        client: {
            label: t(ContentRegistry.ROLE_LABELS.CLIENT),
            icon: '🏠',
            color: '#ec4899',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.CLIENT,
        },
    };
}

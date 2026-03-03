import { MenuItem } from './menu-configs';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry, ContentRegistry } = AdminRegistry;

export const knowledgeBaseMenus: MenuItem[] = [
    { label: 'KB: Super Admin', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-super-admin`, icon: '🎭' },
    { label: 'KB: Admin', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-admin`, icon: '🎭' },
    { label: 'KB: Regional Mgr', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-regional-manager`, icon: '🎭' },
    { label: 'KB: Operations', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-operations-manager`, icon: '🎭' },
    { label: 'KB: HR Manager', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-hr-manager`, icon: '🎭' },
    { label: 'KB: Clinical Mgr', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-clinical-manager`, icon: '🎭' },
    { label: 'KB: Finance Mgr', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-finance-manager`, icon: '🎭' },
    { label: 'KB: Marketing', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-marketing-manager`, icon: '🎭' },
    { label: 'KB: Recruiting', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-recruiting-manager`, icon: '🎭' },
    { label: 'KB: General Mgr', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-manager`, icon: '🎭' },
    { label: 'KB: Coordinator', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-coordinator`, icon: '🎭' },
    { label: 'KB: Staff', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-staff`, icon: '🎭' },
    { label: 'KB: Finance Clerk', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-finance`, icon: '🎭' },
    { label: 'KB: Client', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-client`, icon: '🎭' },
    { label: 'KB: RN', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-rn`, icon: '🎭' },
    { label: 'KB: PSW', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-psw`, icon: '🎭' },
    { label: 'KB: RMT', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-rmt`, icon: '🎭' },
    { label: 'KB: RPT', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-rpt`, icon: '🎭' },
    { label: 'KB: RCH', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-rch`, icon: '🎭' },
];

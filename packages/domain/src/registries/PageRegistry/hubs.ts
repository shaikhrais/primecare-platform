import type { HubEntry } from '../01_I_page_registry';

export const HubRegistry: HubEntry[] = [
    { id: 'admin.telehealth', label: 'Telehealth Center', route: '/platform/admin/telehealth/center', owner: 'admin', description: 'Video visits, vital signs, session management', sections: ['Sessions', 'Alerts', 'Vitals'] },
    { id: 'admin.pharmacy', label: 'Pharmacy Hub', route: '/platform/admin/pharmacy/hub', owner: 'admin', description: 'Prescriptions, orders, MAR, barcode verification', sections: ['Prescriptions', 'Orders', 'MAR', 'Barcode'] },
    { id: 'admin.rcm', label: 'Revenue Cycle Hub', route: '/platform/admin/rcm/claims', owner: 'admin', description: 'Claims processing, revenue sync', sections: ['Claims', 'Revenue'] },
    { id: 'admin.erp', label: 'Supply Chain Hub', route: '/platform/admin/erp/inventory', owner: 'admin', description: 'Inventory, suppliers, purchase orders', sections: ['Inventory', 'Procurement'] },
    { id: 'admin.notifications', label: 'Notifications Hub', route: '/platform/admin/notifications', owner: 'admin', description: 'Broadcast, family, read status', sections: ['Inbox', 'Broadcast', 'Family'] },
    { id: 'admin.documents', label: 'Document Center', route: '/platform/admin/documents', owner: 'admin', description: 'Upload, download, verify documents', sections: ['Library', 'Upload', 'Verification'] },
    { id: 'admin.payroll', label: 'Payroll Hub', route: '/platform/admin/payroll', owner: 'admin', description: 'Pending approvals, batch runs, summaries', sections: ['Pending', 'Batch', 'Summary'] },
    { id: 'admin.knowledge-base', label: 'Knowledge Base', route: '/platform/admin/knowledge-base', owner: 'admin', description: 'Articles, guides, reference material', sections: ['Articles', 'Search'] },
    { id: 'admin.reference-data', label: 'Reference Data Hub', route: '/platform/admin/reference-data', owner: 'admin', description: 'Insurance providers, billing codes', sections: ['Insurance', 'Billing Codes'] },
    { id: 'admin.logistics', label: 'Logistics Hub', route: '/platform/admin/ops/logistics', owner: 'admin', description: 'Route optimization, fleet management', sections: ['Routes', 'Fleet', 'Dispatch'] },
    { id: 'coordinator.hub', label: 'Coordinator Hub', route: '/tenancy/coordinator/hub', owner: 'coordinator', description: 'Dispatch, matching, scheduling', sections: ['Dispatch', 'Matching', 'Schedule'] },
    { id: 'client.family', label: 'Family Hub', route: '/tenancy/client/family-hub', owner: 'client', description: 'Family members, feed, messaging', sections: ['Members', 'Feed', 'Messages'] },
    { id: 'coordinator.sos', label: 'SOS Center', route: '/tenancy/coordinator/sos-center', owner: 'coordinator', description: 'Emergency response, dispatch, acknowledgment', sections: ['Active', 'Dispatch', 'History'] },
    { id: 'superuser.governance', label: 'Governance Hub', route: '/platform/governance', owner: 'superuser', description: 'Platform governance, policies, risk', sections: ['Policies', 'Risk', 'SLA'] },
];

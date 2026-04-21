import type { ListEntry } from '../01_I_page_registry';

export const ListRegistry: ListEntry[] = [
    { id: 'admin.users', label: 'User List', route: '/platform/admin/users', owner: 'admin', fetchEndpoint: '/v1/admin/users', columns: ['name', 'email', 'role', 'status'], searchable: true, filterable: true },
    { id: 'admin.incidents', label: 'Incident List', route: '/platform/admin/incidents', owner: 'admin', fetchEndpoint: '/v1/admin/incidents', columns: ['title', 'severity', 'status', 'date'], searchable: true, filterable: true },
    { id: 'admin.leads', label: 'Leads Pipeline', route: '/platform/admin/leads', owner: 'admin', fetchEndpoint: '/v1/admin/leads', columns: ['name', 'source', 'status', 'date'], searchable: true, filterable: true },
    { id: 'admin.timesheets', label: 'Timesheets', route: '/platform/admin/timesheets', owner: 'admin', fetchEndpoint: '/v1/admin/timesheets', columns: ['psw', 'date', 'hours', 'status'], searchable: true, filterable: true },
    { id: 'admin.services', label: 'Services', route: '/platform/admin/services', owner: 'admin', fetchEndpoint: '/v1/admin/services', columns: ['name', 'rate', 'category', 'status'], searchable: true, filterable: false },
    { id: 'admin.audits', label: 'Audit Logs', route: '/platform/admin/audits', owner: 'admin', fetchEndpoint: '/v1/superuser/audit-logs', columns: ['action', 'user', 'resource', 'timestamp'], searchable: true, filterable: true },
    { id: 'admin.authorizations', label: 'Authorizations', route: '/platform/admin/authorizations', owner: 'admin', fetchEndpoint: '/v1/admin/authorizations', columns: ['client', 'service', 'units', 'expiry'], searchable: true, filterable: true },
    { id: 'admin.consent', label: 'Consent Records', route: '/platform/admin/consent', owner: 'admin', fetchEndpoint: '/v1/admin/consent/templates', columns: ['client', 'type', 'status', 'expiry'], searchable: true, filterable: true },
    { id: 'admin.referrals', label: 'Referrals', route: '/platform/admin/referrals', owner: 'admin', fetchEndpoint: '/v1/admin/referrals', columns: ['name', 'source', 'status', 'date'], searchable: true, filterable: true },
    { id: 'admin.claims', label: 'Claims', route: '/platform/admin/claims', owner: 'admin', fetchEndpoint: '/v1/admin/claims', columns: ['claimId', 'client', 'amount', 'status'], searchable: true, filterable: true },
    { id: 'admin.webhooks', label: 'Webhooks', route: '/platform/admin/webhooks', owner: 'admin', fetchEndpoint: '/v1/admin/webhooks', columns: ['url', 'events', 'status', 'lastDelivery'], searchable: false, filterable: true },
    { id: 'admin.booking-requests', label: 'Booking Requests', route: '/platform/admin/booking-requests', owner: 'admin', fetchEndpoint: '/v1/admin/booking-requests', columns: ['client', 'service', 'date', 'status'], searchable: true, filterable: true },
    { id: 'superuser.tenants', label: 'Tenants', route: '/platform/tenants', owner: 'superuser', fetchEndpoint: '/v1/superuser/tenants', columns: ['name', 'slug', 'plan', 'status'], searchable: true, filterable: true },
    { id: 'superuser.audit-logs', label: 'Platform Audit Logs', route: '/platform/audit-logs', owner: 'superuser', fetchEndpoint: '/v1/superuser/audit-logs', columns: ['action', 'tenant', 'user', 'timestamp'], searchable: true, filterable: true },
    { id: 'admin.customers', label: 'Customers', route: '/platform/admin/customers', owner: 'admin', fetchEndpoint: '/v1/staff/customers', columns: ['name', 'email', 'phone', 'status'], searchable: true, filterable: true },
    // Client / PSW lists
    { id: 'client.bookings', label: 'My Bookings', route: '/tenancy/client/bookings', owner: 'client', fetchEndpoint: '/v1/client/bookings', columns: ['date', 'service', 'provider', 'status'], searchable: false, filterable: true },
    { id: 'psw.schedule', label: 'Visit Schedule', route: '/tenancy/psw/schedule', owner: 'psw', fetchEndpoint: '/v1/psw/schedule/visits', columns: ['date', 'client', 'time', 'status'], searchable: false, filterable: true },
    { id: 'staff.customers', label: 'Staff Customers', route: '/tenancy/staff/customers', owner: 'staff', fetchEndpoint: '/v1/staff/customers', columns: ['name', 'email', 'status'], searchable: true, filterable: false },
    { id: 'staff.tasks', label: 'Task Grid', route: '/tenancy/staff/tasks', owner: 'staff', fetchEndpoint: '/v1/staff/tasks/grid', columns: ['title', 'assignee', 'priority', 'due'], searchable: true, filterable: true },
];

export const UI_ROLE_MATRIX = {
    admin: [
        { route: '/admin/home', elements: ['KPI Cards', 'Alerts Panel', 'Quick Action Bar'] },
        { route: '/admin/users', elements: ['DataTable', 'Add User button', 'Filter'] },
        { route: '/admin/audit', elements: ['DataTable', 'Export CSV button'] }
    ],
    manager: [
        { route: '/manager/home', elements: ['Timeline', 'Quick Actions', 'Alerts'] },
        { route: '/manager/clients', elements: ['Tabs', 'Add Client button', 'Document uploader'] },
        { route: '/manager/shifts', elements: ['Calendar', 'Create Shift button'] }
    ],
    rn: [
        {
            route: '/rn/home',
            elements: ['[data-cy="page.container"]', '[data-cy="kpi-pending-plans"]', '[data-cy="section.tasks"]']
        }
    ],
    psw: [
        {
            route: '/shifts',
            elements: ['[data-cy="page.container"]', '[data-cy="section.shifts"]', '[data-cy="btn-view-all-shifts"]']
        }
    ],
    staff: [
        { route: '/staff/home', elements: ['Schedule View', 'Alerts'] }, // Note: needs data-cy verification
        { route: '/staff/shifts', elements: ['Calendar', 'Swap button'] }
    ]
};

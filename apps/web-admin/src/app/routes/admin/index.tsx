import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Layouts
import AdminLayout from '@/shared/components/layout/AdminLayout';

// Pages
import Dashboard from './pages/dashboard';
import Users from './pages/users';
import Schedule from './pages/schedule';
import Incidents from './pages/incidents';
import Timesheets from './pages/timesheets';
import Leads from './pages/leads';
import Services from './pages/services';
import Settings from './pages/settings';
import Content from './pages/content';
import Audits from './pages/audits';
import Support from './pages/support';
import Admission from './pages/admission';
import Onboarding from './pages/onboarding';
import Locations from './pages/locations';
import UsersNew from './pages/users-new';
import IncidentsNew from './pages/incidents-new';
import LeadsNew from './pages/leads-new';
import InvoicesNew from './pages/invoices-new';
import TimesheetAdjustment from './pages/timesheet-adjustment';

import EarningsPage from './pages/earnings';

/**
 * Admin Routes
 * Base path: /admin
 */
const AdminRoutes: React.FC = () => {
    return (
        <Routes>
            <Route path="dashboard" element={<AdminLayout><Dashboard /></AdminLayout>} />
            <Route path="users" element={<AdminLayout><Users /></AdminLayout>} />
            <Route path="schedule" element={<AdminLayout><Schedule /></AdminLayout>} />
            <Route path="earnings" element={<AdminLayout><EarningsPage /></AdminLayout>} />
            <Route path="incidents" element={<AdminLayout><Incidents /></AdminLayout>} />
            <Route path="timesheets" element={<AdminLayout><Timesheets /></AdminLayout>} />
            <Route path="leads" element={<AdminLayout><Leads /></AdminLayout>} />
            <Route path="services" element={<AdminLayout><Services /></AdminLayout>} />
            <Route path="settings" element={<AdminLayout><Settings /></AdminLayout>} />
            <Route path="content" element={<AdminLayout><Content /></AdminLayout>} />
            <Route path="audits" element={<AdminLayout><Audits /></AdminLayout>} />
            <Route path="support" element={<AdminLayout><Support /></AdminLayout>} />
            <Route path="admission" element={<AdminLayout><Admission /></AdminLayout>} />
            <Route path="onboarding" element={<AdminLayout><Onboarding /></AdminLayout>} />
            <Route path="locations/new" element={<AdminLayout><Locations /></AdminLayout>} />
            <Route path="users/new" element={<AdminLayout><UsersNew /></AdminLayout>} />
            <Route path="incidents/new" element={<AdminLayout><IncidentsNew /></AdminLayout>} />
            <Route path="leads/new" element={<AdminLayout><LeadsNew /></AdminLayout>} />
            <Route path="invoices/new" element={<AdminLayout><InvoicesNew /></AdminLayout>} />
            <Route path="timesheets/adjust" element={<AdminLayout><TimesheetAdjustment /></AdminLayout>} />
        </Routes>
    );
};

export default AdminRoutes;

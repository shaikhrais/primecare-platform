import React from 'react';
import { Route, Routes } from 'react-router-dom';

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
            <Route path="dashboard" element={<Dashboard />} />
            <Route path="users" element={<Users />} />
            <Route path="schedule" element={<Schedule />} />
            <Route path="earnings" element={<EarningsPage />} />
            <Route path="incidents" element={<Incidents />} />
            <Route path="timesheets" element={<Timesheets />} />
            <Route path="leads" element={<Leads />} />
            <Route path="services" element={<Services />} />
            <Route path="settings" element={<Settings />} />
            <Route path="content" element={<Content />} />
            <Route path="audits" element={<Audits />} />
            <Route path="support" element={<Support />} />
            <Route path="admission" element={<Admission />} />
            <Route path="onboarding" element={<Onboarding />} />
            <Route path="locations/new" element={<Locations />} />
            <Route path="users/new" element={<UsersNew />} />
            <Route path="incidents/new" element={<IncidentsNew />} />
            <Route path="leads/new" element={<LeadsNew />} />
            <Route path="invoices/new" element={<InvoicesNew />} />
            <Route path="timesheets/adjust" element={<TimesheetAdjustment />} />
        </Routes>
    );
};

export default AdminRoutes;

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
        </Routes>
    );
};

export default AdminRoutes;

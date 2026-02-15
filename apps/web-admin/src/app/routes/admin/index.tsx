import React, { Suspense } from 'react';
import { Route, Routes } from 'react-router-dom';

// Lazy Load Pages
const Dashboard = React.lazy(() => import('./pages/dashboard'));
const Users = React.lazy(() => import('./pages/users'));
const Schedule = React.lazy(() => import('./pages/schedule'));
const Incidents = React.lazy(() => import('./pages/incidents'));
const Timesheets = React.lazy(() => import('./pages/timesheets'));
const Leads = React.lazy(() => import('./pages/leads'));
const Services = React.lazy(() => import('./pages/services'));
const Settings = React.lazy(() => import('./pages/settings'));
const Content = React.lazy(() => import('./pages/content'));
const Audits = React.lazy(() => import('./pages/audits'));
const LocationsList = React.lazy(() => import('./pages/locations/list'));
const LocationForm = React.lazy(() => import('./pages/locations'));
const RoleEditor = React.lazy(() => import('./pages/role-editor'));
const RolesList = React.lazy(() => import('./pages/role-editor/list'));
const TemplateEditor = React.lazy(() => import('./pages/template-editor'));
const TemplatesList = React.lazy(() => import('./pages/template-editor/list'));

const UsersNew = React.lazy(() => import('./pages/users-new'));
const IncidentsNew = React.lazy(() => import('./pages/incidents-new'));
const LeadsNew = React.lazy(() => import('./pages/leads-new'));
const InvoicesNew = React.lazy(() => import('./pages/invoices-new'));
const TimesheetAdjustment = React.lazy(() => import('./pages/timesheet-adjustment'));
const Support = React.lazy(() => import('./pages/support'));
const Admission = React.lazy(() => import('./pages/admission'));
const Onboarding = React.lazy(() => import('./pages/onboarding'));

const EarningsPage = React.lazy(() => import('./pages/earnings'));
const ReportsPage = React.lazy(() => import('./pages/reports'));

const LoadingFallback = () => (
    <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100%', color: '#6B7280' }}>
        Loading...
    </div>
);

/**
 * Admin Routes
 * Base path: /admin
 */
const AdminRoutes: React.FC = () => {
    return (
        <Suspense fallback={<LoadingFallback />}>
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
                <Route path="reports" element={<ReportsPage />} />

                <Route path="locations" element={<LocationsList />} />
                <Route path="locations/new" element={<LocationForm />} />
                <Route path="locations/:id" element={<LocationForm />} />

                <Route path="users/new" element={<UsersNew />} />
                <Route path="incidents/new" element={<IncidentsNew />} />
                <Route path="leads/new" element={<LeadsNew />} />
                <Route path="invoices/new" element={<InvoicesNew />} />
                <Route path="timesheets/adjust" element={<TimesheetAdjustment />} />

                <Route path="roles" element={<RolesList />} />
                <Route path="roles/new" element={<RoleEditor />} />
                <Route path="roles/:id" element={<RoleEditor />} />

                <Route path="templates" element={<TemplatesList />} />
                <Route path="templates/new" element={<TemplateEditor />} />
                <Route path="templates/:id" element={<TemplateEditor />} />
            </Routes>
        </Suspense>
    );
};

export default AdminRoutes;

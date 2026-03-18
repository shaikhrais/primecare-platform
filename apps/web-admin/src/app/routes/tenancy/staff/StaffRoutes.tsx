import React, { lazy } from 'react';
import { Route } from 'react-router';
import { AdminRegistry } from 'prime-care-shared';
import RequireRole from '@/shared/rbac/RequireRole';
import AppLayout from '@/shared/components/layout/AppLayout';

const { RouteRegistry } = AdminRegistry;

// Staff Pages
const StaffDashboard = lazy(() => import('./dashboard').then(m => ({ default: Object.values(m)[0] as any })));
const UserList = lazy(() => import('../../platform/admin/users').then(m => ({ default: m.UserList })));
const TaskGrid = lazy(() => import('./tasks').then(m => ({ default: Object.values(m)[0] as any })));
const MessageCenter = lazy(() => import('./messages').then(m => ({ default: Object.values(m)[0] as any })));
const IncidentPortal = lazy(() => import('./operations').then(m => ({ default: m.IncidentPortal })));
const ComplianceMonitor = lazy(() => import('./operations').then(m => ({ default: m.ComplianceMonitor })));

export const StaffRoutes = () => (
    <Route path={RouteRegistry.STAFF.DASHBOARD} element={<RequireRole allowedRoles={['staff', 'admin']}><AppLayout /></RequireRole>}>
        <Route index element={<StaffDashboard />} />
        <Route path={RouteRegistry.STAFF.CUSTOMERS} element={<UserList />} />
        <Route path={RouteRegistry.STAFF.TASKS} element={<TaskGrid />} />
        <Route path={RouteRegistry.STAFF.MESSAGES} element={<MessageCenter />} />
        <Route path={RouteRegistry.STAFF.INCIDENTS} element={<IncidentPortal />} />
        <Route path={RouteRegistry.STAFF.COMPLIANCE} element={<ComplianceMonitor />} />
    </Route>
);

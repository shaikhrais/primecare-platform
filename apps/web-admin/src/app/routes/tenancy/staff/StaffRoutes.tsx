import React, { lazy } from 'react';
import { Route } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import RequireRole from '@/shared/rbac/RequireRole';
import AppLayout from '@/shared/components/layout/AppLayout';

const { RouteRegistry } = AdminRegistry;

// Staff Pages
const StaffDashboard = lazy(() => import('./pages/dashboard'));
const UserList = lazy(() => import('../../platform/admin/pages/users').then(m => ({ default: m.UserList })));
const TaskGrid = lazy(() => import('./pages/tasks/TaskGrid'));
const MessageCenter = lazy(() => import('./pages/messages/MessageCenter'));

export const StaffRoutes = () => (
    <Route path={RouteRegistry.STAFF.DASHBOARD} element={<RequireRole allowedRoles={['staff', 'admin']}><AppLayout /></RequireRole>}>
        <Route index element={<StaffDashboard />} />
        <Route path={RouteRegistry.STAFF.CUSTOMERS} element={<UserList />} />
        <Route path={RouteRegistry.STAFF.TASKS} element={<TaskGrid />} />
        <Route path={RouteRegistry.STAFF.MESSAGES} element={<MessageCenter />} />
    </Route>
);

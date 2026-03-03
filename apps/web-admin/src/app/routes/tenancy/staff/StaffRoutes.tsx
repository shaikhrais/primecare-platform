import React, { lazy } from 'react';
import { Route } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import RequireRole from '@/shared/rbac/RequireRole';
import AppLayout from '@/shared/components/layout/AppLayout';

const { RouteRegistry } = AdminRegistry;

// Staff Pages
const StaffDashboard = lazy(() => import('./pages/dashboard'));
const UserList = lazy(() => import('../../platform/admin/pages/users').then(m => ({ default: m.UserList })));

export const StaffRoutes = () => (
    <Route path={RouteRegistry.STAFF.DASHBOARD} element={<RequireRole allowedRoles={['staff', 'admin']}><AppLayout /></RequireRole>}>
        <Route index element={<StaffDashboard />} />
        <Route path={RouteRegistry.STAFF.CUSTOMERS} element={<UserList />} />
    </Route>
);

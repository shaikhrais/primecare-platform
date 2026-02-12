import React from 'react';
import ClientDashboard from '../client/ClientDashboard';
import PswDashboard from '../psw/PswDashboard';
import AdminDashboard from '../admin/AdminDashboard';
import { AdminRegistry } from 'prime-care-shared';

const { DataRegistry } = AdminRegistry;

export default function Dashboard() {
    const userStr = localStorage.getItem('user');
    const user = userStr ? JSON.parse(userStr) : { role: DataRegistry.Roles.ADMIN };
    const role = user.role;
    if (role === DataRegistry.Roles.CLIENT) return <div data-cy="dashboard-page"><ClientDashboard /></div>;
    if (role === DataRegistry.Roles.PSW) return <div data-cy="dashboard-page"><PswDashboard /></div>;

    // Default to Admin Dashboard for admin, staff, or others
    return <div data-cy="dashboard-page"><AdminDashboard /></div>;
}

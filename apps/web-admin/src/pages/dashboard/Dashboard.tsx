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
    return (
        <div style={{ padding: '2rem' }} data-cy="dashboard-page">
            <h1 data-cy="page.title">User Dashboard</h1>
            <p data-cy="page.subtitle">Welcome back. Select a role to get started.</p>
        </div>
    );
}

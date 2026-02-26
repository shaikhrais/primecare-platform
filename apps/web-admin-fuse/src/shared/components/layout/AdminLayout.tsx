import React from 'react';
import FuseLayout from '@fuse/core/FuseLayout';
import themeLayouts from '@/shared/theme-layouts/themeLayouts';
import { useAuth } from '@/shared/context/AuthContext';
import { Navigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

interface AdminLayoutProps {
    children: React.ReactNode;
}

export default function AdminLayout({ children }: AdminLayoutProps) {
    const { user, loading } = useAuth();

    if (loading) return null;
    if (!user) {
        return <Navigate to={RouteRegistry.LOGIN} replace />;
    }

    return (
        <FuseLayout
            layouts={themeLayouts}
        >
            {children}
        </FuseLayout>
    );
}


import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Layouts
import AdminLayout from '../../shared/components/layout/AdminLayout';

// Pages
import Profile from './pages/profile';
import SupportHub from './pages/support-hub';
import Messaging from './pages/messaging';

/**
 * Shared Routes
 */
const SharedRoutes: React.FC = () => {
    return (
        <Routes>
            <Route path="profile" element={<AdminLayout><Profile /></AdminLayout>} />
            <Route path="support" element={<AdminLayout><SupportHub /></AdminLayout>} />
            <Route path="messaging" element={<AdminLayout><Messaging /></AdminLayout>} />
        </Routes>
    );
};

export default SharedRoutes;

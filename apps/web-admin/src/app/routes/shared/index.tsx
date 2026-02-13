import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Layouts
import AdminLayout from '../../../shared/components/layout/AdminLayout';

// Pages
import Profile from './pages/profile';
import SupportHub from './pages/support-hub';
import SupportTicket from './pages/support-ticket';
import Messaging from './pages/messaging';
import VisitCompletion from './pages/visit-completion';
import VisitDetails from './pages/visit-details';

/**
 * Shared Routes
 */
const SharedRoutes: React.FC = () => {
    return (
        <Routes>
            <Route path="profile" element={<AdminLayout><Profile /></AdminLayout>} />
            <Route path="support" element={<AdminLayout><SupportHub /></AdminLayout>} />
            <Route path="support/tickets/new" element={<AdminLayout><SupportTicket /></AdminLayout>} />
            <Route path="messaging" element={<AdminLayout><Messaging /></AdminLayout>} />
            <Route path="visits/:id" element={<AdminLayout><VisitDetails /></AdminLayout>} />
            <Route path="visits/:id/complete" element={<AdminLayout><VisitCompletion /></AdminLayout>} />
        </Routes>
    );
};

export default SharedRoutes;

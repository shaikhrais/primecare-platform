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

// Error Pages
import NotFound from './pages/error/NotFound';
import Unauthorized from './pages/error/Unauthorized';
import ServerError from './pages/error/ServerError';

/**
 * Shared Routes
 */
const SharedRoutes: React.FC = () => {
    return (
        <Routes>
            <Route path="profile" element={<Profile />} />
            <Route path="support" element={<SupportHub />} />
            <Route path="support/tickets/new" element={<SupportTicket />} />
            <Route path="messaging" element={<Messaging />} />
            <Route path="visits/:id" element={<VisitDetails />} />
            <Route path="visits/:id/complete" element={<VisitCompletion />} />

            {/* Error Page Test Routes */}
            <Route path="404" element={<NotFound />} />
            <Route path="401" element={<Unauthorized />} />
            <Route path="500" element={<ServerError />} />
        </Routes>
    );
};

export default SharedRoutes;

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
            <Route path="profile" element={<Profile />} />
            <Route path="support" element={<SupportHub />} />
            <Route path="support/tickets/new" element={<SupportTicket />} />
            <Route path="messaging" element={<Messaging />} />
            <Route path="visits/:id" element={<VisitDetails />} />
            <Route path="visits/:id/complete" element={<VisitCompletion />} />
        </Routes>
    );
};

export default SharedRoutes;

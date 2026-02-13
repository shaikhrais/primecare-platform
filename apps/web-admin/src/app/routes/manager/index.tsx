import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Layouts
import ManagerLayout from '../../../shared/components/layout/ManagerLayout';

// Pages
import Dashboard from './pages/dashboard';
import DailyEntry from './pages/daily-entry';
import Evaluations from './pages/evaluations';
import ServiceReview from './pages/service-review';

/**
 * Manager Routes
 * Base path: /manager
 */
const ManagerRoutes: React.FC = () => {
    return (
        <Routes>
            <Route path="dashboard" element={<Dashboard />} />
            <Route path="daily-entry" element={<DailyEntry />} />
            <Route path="evaluations" element={<Evaluations />} />
            <Route path="service-review" element={<ServiceReview />} />
        </Routes>
    );
};

export default ManagerRoutes;

import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Layouts
import ManagerLayout from '../../../components/layout/ManagerLayout';

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
            <Route
                path="dashboard"
                element={
                    <ManagerLayout>
                        <Dashboard />
                    </ManagerLayout>
                }
            />
            <Route
                path="daily-entry"
                element={
                    <ManagerLayout>
                        <DailyEntry />
                    </ManagerLayout>
                }
            />
            <Route
                path="evaluations"
                element={
                    <ManagerLayout>
                        <Evaluations />
                    </ManagerLayout>
                }
            />
            <Route
                path="service-review"
                element={
                    <ManagerLayout>
                        <ServiceReview />
                    </ManagerLayout>
                }
            />
        </Routes>
    );
};

export default ManagerRoutes;

import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Layouts
import ManagerLayout from '../../../shared/components/layout/ManagerLayout';
import { NotificationCenterProvider } from '@/shared/context/NotificationCenterContext';
import { CommandPaletteWrapper } from '@/shared/components/CommandPaletteWrapper';

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
        <NotificationCenterProvider>
            <CommandPaletteWrapper>
                <Routes>
                    <Route path="dashboard" element={<Dashboard />} />
                    <Route path="daily-entry" element={<DailyEntry />} />
                    <Route path="evaluations" element={<Evaluations />} />
                    <Route path="service-review" element={<ServiceReview />} />
                </Routes>
            </CommandPaletteWrapper>
        </NotificationCenterProvider>
    );
};

export default ManagerRoutes;

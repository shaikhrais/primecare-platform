import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Layouts
import ManagerLayout from '../../../shared/components/layout/ManagerLayout';
import { NotificationCenterProvider } from '@/shared/context/NotificationCenterContext';
import { CommandPaletteWrapper } from '@/shared/components/CommandPaletteWrapper';

// Pages
import Dashboard from './pages/dashboard';
import Portfolio from './pages/portfolio';
import DailyEntry from './pages/daily-entry';
import Evaluations from './pages/evaluations';
import ServiceReview from './pages/service-review';

/**
 * Manager Routes
 * Base path: /managers
 */
const ManagerRoutes: React.FC = () => {
    return (
        <CommandPaletteWrapper>
            <Routes>
                <Route element={<ManagerLayout />}>
                    <Route path="dashboard" element={<Portfolio />} />
                    <Route path="portfolio" element={<Portfolio />} />
                    <Route path="marketing" element={<Dashboard />} />
                    <Route path="operations" element={<Dashboard />} />
                    <Route path="clinical" element={<Dashboard />} />
                    <Route path="regional" element={<Dashboard />} />
                    <Route path="recruiting" element={<Dashboard />} />
                    <Route path="coordinator" element={<Dashboard />} />
                    <Route path="crm" element={<Dashboard />} />
                    <Route path="training" element={<Dashboard />} />
                    <Route path="daily-entry" element={<DailyEntry />} />
                    <Route path="evaluations" element={<Evaluations />} />
                    <Route path="service-review" element={<ServiceReview />} />
                    {/* Default redirect for /managers */}
                    <Route index element={<Portfolio />} />
                </Route>
            </Routes>
        </CommandPaletteWrapper>
    );
};

export default ManagerRoutes;

import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Pages
import Dashboard from './pages/dashboard';

/**
 * RN Routes
 * Base path: /rn
 */
// Layouts
import RnLayout from '../../../shared/components/layout/RnLayout';
import { NotificationCenterProvider } from '@/shared/context/NotificationCenterContext';
import { CommandPaletteWrapper } from '@/shared/components/CommandPaletteWrapper';

/**
 * RN Routes
 * Base path: /rn
 */
const RnRoutes: React.FC = () => {
    return (
        <NotificationCenterProvider>
            <CommandPaletteWrapper>
                <Routes>
                    <Route element={<RnLayout />}>
                        <Route path="dashboard" element={<Dashboard />} />
                        {/* Add more RN pages here as we migrate them */}
                    </Route>
                </Routes>
            </CommandPaletteWrapper>
        </NotificationCenterProvider>
    );
};

export default RnRoutes;

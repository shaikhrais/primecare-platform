import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Pages
import Dashboard from './pages/dashboard';
import PswDashboardEnterprise from '../../../roles/psw/dashboard';
import ShiftsPage from '../../../roles/psw/pages/shifts';
import EarningsPage from '../../../roles/psw/pages/earnings';
import ProfilePage from '../../../roles/psw/pages/profile';
import Schedule from './pages/schedule';
import OpenShifts from './pages/OpenShifts';
import Availability from './pages/availability';
import Expenses from './pages/expenses';
import ShiftConfirmation from './pages/shift-confirmation';

/**
 * PSW Routes
 * Base path: /psw
 */
// Layouts
import PswLayout from '../../../shared/components/layout/PswLayout';
import { NotificationCenterProvider } from '@/shared/context/NotificationCenterContext';
import { CommandPaletteWrapper } from '@/shared/components/CommandPaletteWrapper';

/**
 * PSW Routes
 * Base path: /psw
 */
const PswRoutes: React.FC = () => {
    return (
        <NotificationCenterProvider>
            <CommandPaletteWrapper>
                <Routes>
                    <Route element={<PswLayout />}>
                        <Route path="dashboard" element={<PswDashboardEnterprise />} />
                        <Route path="schedule" element={<Schedule />} />
                        <Route path="open-shifts" element={<OpenShifts />} />
                        <Route path="availability" element={<Availability />} />
                        <Route path="earnings" element={<EarningsPage />} />
                        <Route path="expenses" element={<Expenses />} />
                        <Route path="profile" element={<ProfilePage />} />
                    </Route>
                </Routes>
            </CommandPaletteWrapper>
        </NotificationCenterProvider>
    );
};

export default PswRoutes;

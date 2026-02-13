import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Layouts
import AdminLayout from '../../../shared/components/layout/AdminLayout';

// Pages
import Dashboard from './pages/dashboard';

/**
 * RN Routes
 * Base path: /rn
 */
const RnRoutes: React.FC = () => {
    return (
        <Routes>
            <Route path="dashboard" element={<Dashboard />} />
            {/* Add more RN pages here as we migrate them */}
        </Routes>
    );
};

export default RnRoutes;

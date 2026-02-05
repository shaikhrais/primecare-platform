import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import Login from './pages/auth/Login';
import Dashboard from './pages/dashboard/Dashboard';

import UserList from './pages/users/UserList';
import Schedule from './pages/schedule/Schedule';
import LeadsPage from './pages/leads/LeadsPage';
import AdminLayout from './components/layout/AdminLayout';

const { RouteRegistry } = AdminRegistry;

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path={RouteRegistry.LOGIN} element={<Login />} />

        {/* Protected Dashboard Routes */}
        <Route path={RouteRegistry.DASHBOARD} element={<AdminLayout><Dashboard /></AdminLayout>} />
        <Route path={RouteRegistry.USERS} element={<AdminLayout><UserList /></AdminLayout>} />
        <Route path={RouteRegistry.SCHEDULE} element={<AdminLayout><Schedule /></AdminLayout>} />
        <Route path="/leads" element={<AdminLayout><LeadsPage /></AdminLayout>} />

        {/* Portal-Specific Routes (Shared layouts) */}
        <Route path="/bookings" element={<AdminLayout><div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '0.75rem' }}>My Bookings coming soon.</div></AdminLayout>} />
        <Route path="/profile" element={<AdminLayout><div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '0.75rem' }}>Account Profile coming soon.</div></AdminLayout>} />
        <Route path="/shifts" element={<AdminLayout><div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '0.75rem' }}>My Shifts coming soon.</div></AdminLayout>} />
        <Route path="/support" element={<AdminLayout><div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '0.75rem' }}>Help & Support coming soon.</div></AdminLayout>} />
        <Route path="/settings" element={<AdminLayout><div style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '0.75rem' }}>Settings coming soon.</div></AdminLayout>} />

        {/* Fallback */}
        <Route path="/" element={<Navigate to={RouteRegistry.DASHBOARD} replace />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;

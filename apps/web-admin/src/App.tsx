import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import Login from './pages/auth/Login';
import Register from './pages/auth/Register';
import ForgotPassword from './pages/auth/ForgotPassword';
import ResetPassword from './pages/auth/ResetPassword';
import Dashboard from './pages/dashboard/Dashboard';

import UserList from './pages/users/UserList';
import Schedule from './pages/schedule/Schedule';
import LeadsPage from './pages/leads/LeadsPage';
import BookingsPage from './pages/client/BookingsPage';
import ShiftsPage from './pages/psw/ShiftsPage';
import ProfilePage from './pages/shared/ProfilePage';
import SupportHub from './pages/shared/SupportHub';
import SettingsPage from './pages/admin/SettingsPage';
import ContentManager from './pages/admin/ContentManager';
import CallAuditPage from './pages/admin/CallAuditPage';
import ServicesPage from './pages/admin/ServicesPage';
import CustomerList from './pages/admin/CustomerList';
import SupportDashboard from './pages/admin/SupportDashboard';
import IncidentList from './pages/admin/IncidentList';
import TimesheetList from './pages/admin/TimesheetList';
import ClientAdmissionForm from './pages/admin/ClientAdmissionForm';
import PswOnboardingForm from './pages/admin/PswOnboardingForm';
import BillingPage from './pages/client/BillingPage';
import EarningsPage from './pages/psw/EarningsPage';
import VisitDetails from './pages/shared/VisitDetails';
import MessagingPortal from './pages/shared/MessagingPortal';
import AdminLayout from './components/layout/AdminLayout';
import ManagerLayout from './components/layout/ManagerLayout';
import ManagerDashboard from './pages/manager/ManagerDashboard';
import DailyEntryPage from './pages/manager/DailyEntryPage';

import { NotificationProvider, useNotification } from './context/NotificationContext';

const { RouteRegistry, ApiRegistry } = AdminRegistry;

export { useNotification };

function App() {
  return (
    <NotificationProvider>
      <BrowserRouter>
        <Routes>
          <Route path={RouteRegistry.LOGIN} element={<Login />} />
          <Route path={RouteRegistry.REGISTER} element={<Register />} />
          <Route path={ApiRegistry.AUTH.FORGOT_PASSWORD.replace('/v1/auth', '')} element={<ForgotPassword />} />
          <Route path={ApiRegistry.AUTH.RESET_PASSWORD.replace('/v1/auth', '')} element={<ResetPassword />} />

          {/* Protected Dashboard Routes */}
          <Route path={RouteRegistry.DASHBOARD} element={<AdminLayout><Dashboard /></AdminLayout>} />
          <Route path={RouteRegistry.USERS} element={<AdminLayout><UserList /></AdminLayout>} />
          <Route path={RouteRegistry.SCHEDULE} element={<AdminLayout><Schedule /></AdminLayout>} />
          {/* ... existing routes ... */}
          <Route path="/leads" element={<AdminLayout><LeadsPage /></AdminLayout>} />
          <Route path="/services" element={<AdminLayout><ServicesPage /></AdminLayout>} />
          <Route path="/content" element={<AdminLayout><ContentManager /></AdminLayout>} />
          <Route path="/audits" element={<AdminLayout><CallAuditPage /></AdminLayout>} />
          <Route path="/visits/:id" element={<AdminLayout><VisitDetails /></AdminLayout>} />

          {/* Portal-Specific Routes (Shared layouts) */}
          <Route path="/bookings" element={<AdminLayout><BookingsPage /></AdminLayout>} />
          <Route path="/billing" element={<AdminLayout><BillingPage /></AdminLayout>} />
          <Route path="/earnings" element={<AdminLayout><EarningsPage /></AdminLayout>} />
          <Route path="/profile" element={<AdminLayout><ProfilePage /></AdminLayout>} />
          <Route path="/shifts" element={<AdminLayout><ShiftsPage /></AdminLayout>} />

          {/* Staff & Admin Only */}
          <Route path="/customers" element={<AdminLayout><CustomerList /></AdminLayout>} />
          <Route path="/support" element={<AdminLayout roleGated={['staff', 'admin']}><SupportDashboard /></AdminLayout>} />
          <Route path="/support/chat" element={<AdminLayout roleGated={['client', 'psw']}><MessagingPortal /></AdminLayout>} />
          <Route path="/support/chat/:id" element={<AdminLayout roleGated={['staff', 'admin']}><MessagingPortal /></AdminLayout>} />

          <Route path="/support/manual" element={<AdminLayout><SupportHub /></AdminLayout>} />
          <Route path="/incidents" element={<AdminLayout roleGated={['admin', 'staff']}><IncidentList /></AdminLayout>} />
          <Route path="/timesheets" element={<AdminLayout roleGated={['admin']}><TimesheetList /></AdminLayout>} />
          <Route path="/admin/clients/admission" element={<AdminLayout><ClientAdmissionForm /></AdminLayout>} />
          <Route path="/admin/psw/onboarding" element={<AdminLayout><PswOnboardingForm /></AdminLayout>} />
          <Route path="/settings" element={<AdminLayout><SettingsPage /></AdminLayout>} />

          <Route path="/settings" element={<AdminLayout><SettingsPage /></AdminLayout>} />

          {/* Manager Routes */}
          <Route path="/manager/dashboard" element={<ManagerLayout><ManagerDashboard /></ManagerLayout>} />
          <Route path="/manager/daily-entry" element={<ManagerLayout><DailyEntryPage /></ManagerLayout>} />
          <Route path="/reports" element={<ManagerLayout><div>Reports Placeholder</div></ManagerLayout>} />

          {/* Fallback */}
          <Route path="/" element={<Navigate to={RouteRegistry.DASHBOARD} replace />} />
        </Routes>
      </BrowserRouter>
    </NotificationProvider>
  );
}

export default App;

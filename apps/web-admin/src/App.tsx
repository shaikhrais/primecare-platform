import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import Login from './pages/auth/Login';
import Dashboard from './pages/dashboard/Dashboard';

import UserList from './pages/users/UserList';
import Schedule from './pages/schedule/Schedule';

const { RouteRegistry } = AdminRegistry;

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path={RouteRegistry.LOGIN} element={<Login />} />
        <Route path={RouteRegistry.DASHBOARD} element={<Dashboard />} />
        <Route path={RouteRegistry.USERS} element={<UserList />} />
        <Route path={RouteRegistry.SCHEDULE} element={<Schedule />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;

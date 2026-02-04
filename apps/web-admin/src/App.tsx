import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { AdminRegistry } from '@primecare/shared';
import Login from './pages/auth/Login';
import Dashboard from './pages/dashboard/Dashboard';

import UserList from './pages/users/UserList';

const { RouteRegistry } = AdminRegistry;

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path={RouteRegistry.LOGIN} element={<Login />} />
        <Route path={RouteRegistry.DASHBOARD} element={<Dashboard />} />
        <Route path={RouteRegistry.USERS} element={<UserList />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;

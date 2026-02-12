import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Pages
import Login from './pages/login';
import Register from './pages/register';
import ForgotPassword from './pages/forgot-password';
import ResetPassword from './pages/reset-password';

/**
 * Auth Routes
 */
const AuthRoutes: React.FC = () => {
    return (
        <Routes>
            <Route path="login" element={<Login />} />
            <Route path="register" element={<Register />} />
            <Route path="forgot-password" element={<ForgotPassword />} />
            <Route path="reset-password" element={<ResetPassword />} />
        </Routes>
    );
};

export default AuthRoutes;

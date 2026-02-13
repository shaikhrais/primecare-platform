import Unauthorized from '../routes/shared/pages/error/Unauthorized';

export const RequireRole: React.FC<RequireRoleProps> = ({ children, allowedRoles }) => {
    const location = useLocation();
    const { user, loading } = useAuth();

    if (loading) {
        return null; // Silent while checking session
    }

    if (!user) {
        return <Navigate to={RouteRegistry.LOGIN} state={{ from: location }} replace />;
    }

    const role = user.activeRole || (user.roles && user.roles[0]) || 'client';

    if (user.roles?.includes('admin')) {
        return <>{children}</>;
    }

    if (!allowedRoles.includes(role)) {
        return <Unauthorized />;
    }

    return <>{children}</>;
};

export default RequireRole;

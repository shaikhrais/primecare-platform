import React, { lazy } from 'react';
import { Route } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import RequireRole from '@/shared/rbac/RequireRole';
import AppLayout from '@/shared/components/layout/AppLayout';

const { RouteRegistry } = AdminRegistry;

// Manager Pages
const Portfolio = lazy(() => import('./manager/pages/portfolio'));
const DailyEntry = lazy(() => import('./manager/pages/daily-entry'));
const Evaluations = lazy(() => import('./manager/pages/evaluations'));
const ServiceReview = lazy(() => import('./manager/pages/service-review'));
const ManagerDashboard = lazy(() => import('./manager/pages/dashboard'));
const StaffRanker = lazy(() => import('./manager/pages/performance/StaffRanker'));
const BranchPL = lazy(() => import('./manager/pages/finance/BranchP_L'));

// PSW Pages
const PswDashboard = lazy(() => import('./psw/pages/dashboard'));
const PswSchedule = lazy(() => import('./psw/pages/schedule'));
const PswOpenShifts = lazy(() => import('./psw/pages/OpenShifts'));
const PswOpenOffers = lazy(() => import('./psw/pages/OpenShifts/OpenOffers'));
const PswAvailability = lazy(() => import('./psw/pages/availability'));
const PswEarnings = lazy(() => import('./psw/pages/earnings'));
const PswExpenses = lazy(() => import('./psw/pages/expenses'));
const PswShiftConfirmation = lazy(() => import('./psw/pages/shift-confirmation'));
const CredentialVault = lazy(() => import('./psw/pages/credentials/CredentialVault'));
const ProviderSocial = lazy(() => import('./psw/pages/feed/ProviderSocial'));

// RN Pages
const RnDashboard = lazy(() => import('./rn/pages/dashboard'));

// Client Pages
const ClientDashboard = lazy(() => import('./client/pages/dashboard'));
const ClientBookings = lazy(() => import('./client/pages/bookings'));
const ClientBilling = lazy(() => import('./client/pages/billing'));
const ClientFeedback = lazy(() => import('./client/pages/feedback'));
const RequestBooking = lazy(() => import('./client/pages/request-booking'));
const CatalogBrowser = lazy(() => import('./client/pages/services/CatalogBrowser'));
const ClientMessaging = lazy(() => import('./client/pages/support/ClientMessaging'));

export const TenancyRoutes = () => (
    <>
        {/* MANAGER PORTAL */}
        <Route path={RouteRegistry.MANAGER.DASHBOARD} element={<RequireRole allowedRoles={['manager', 'operations_manager', 'clinical_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<Portfolio />} />
            <Route path={RouteRegistry.MANAGER.DAILY_ENTRY} element={<DailyEntry />} />
            <Route path={RouteRegistry.MANAGER.EVALUATIONS} element={<Evaluations />} />
            <Route path={RouteRegistry.MANAGER.SERVICE_REVIEW} element={<ServiceReview />} />
            <Route path={RouteRegistry.MANAGER.PERFORMANCE} element={<StaffRanker />} />
            <Route path={RouteRegistry.MANAGER.FINANCE} element={<BranchPL />} />
            <Route path=":category" element={<ManagerDashboard />} />
        </Route>

        {/* PSW / PROVIDER PORTAL */}
        <Route path={RouteRegistry.PSW.DASHBOARD} element={<RequireRole allowedRoles={['psw']}><AppLayout /></RequireRole>}>
            <Route index element={<PswDashboard />} />
            <Route path={RouteRegistry.PSW.SCHEDULE} element={<PswSchedule />} />
            <Route path={RouteRegistry.PSW.OPEN_SHIFTS} element={<PswOpenShifts />} />
            <Route path={RouteRegistry.PSW.OFFERS} element={<PswOpenOffers />} />
            <Route path={RouteRegistry.PSW.AVAILABILITY} element={<PswAvailability />} />
            <Route path={RouteRegistry.PSW.EARNINGS} element={<PswEarnings />} />
            <Route path={RouteRegistry.PSW.EXPENSES} element={<PswExpenses />} />
            <Route path={RouteRegistry.PSW.SHIFT_CONFIRMATION} element={<PswShiftConfirmation />} />
            <Route path={RouteRegistry.PSW.CREDENTIALS} element={<CredentialVault />} />
            <Route path={RouteRegistry.PSW.FEED} element={<ProviderSocial />} />
        </Route>

        {/* RN PORTAL */}
        <Route path={RouteRegistry.RN.DASHBOARD} element={<RequireRole allowedRoles={['rn']}><AppLayout /></RequireRole>}>
            <Route index element={<RnDashboard />} />
        </Route>

        {/* CLIENT PORTAL */}
        <Route path={RouteRegistry.CLIENT.DASHBOARD} element={<RequireRole allowedRoles={['client']}><AppLayout /></RequireRole>}>
            <Route index element={<ClientDashboard />} />
            <Route path={RouteRegistry.CLIENT.BOOKINGS} element={<ClientBookings />} />
            <Route path={RouteRegistry.CLIENT.BILLING} element={<ClientBilling />} />
            <Route path={RouteRegistry.CLIENT.FEEDBACK} element={<ClientFeedback />} />
            <Route path={RouteRegistry.CLIENT.REQUEST_BOOKING} element={<RequestBooking />} />
            <Route path={RouteRegistry.CLIENT.SERVICES} element={<CatalogBrowser />} />
            <Route path={RouteRegistry.CLIENT.SUPPORT} element={<ClientMessaging />} />
        </Route>
    </>
);

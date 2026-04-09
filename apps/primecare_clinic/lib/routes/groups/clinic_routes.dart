import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_core/routes/app_routes.dart';
import 'package:primecare_ui/primecare_ui.dart';

final List<RouteBase> clinicRoutes = [
  // --- Dashboards by Role ---
  GoRoute(
    path: AppRoutes.ceoDashboard,
    builder: (context, state) => const CeoDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.headOfBusDevDashboard,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: AppRoutes.franchiseOwnerDashboard,
    builder: (context, state) => const FranchiseOwnerDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.billingAdminDashboard,
    builder: (context, state) => const BillingAdminDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.customerSupportDashboard,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicDashboard,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerDashboard,
    builder: (context, state) => const ComplianceManagerDashboardScreenStitch(),
  ),

  // --- Sub-Screens ---
  GoRoute(
    path: AppRoutes.clinicClientProfile,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicCarePlan,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicHistoryLogs,
    builder: (context, state) => const HistoryLogsScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicProfileSettings,
    builder: (context, state) => const ProfileSettingsScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicMessaging,
    builder: (context, state) => const MessagingScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicIncidentReport,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicCheckInOut,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicDailyNotes,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicShiftDetails,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: AppRoutes.clinicMyShifts,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  )
];

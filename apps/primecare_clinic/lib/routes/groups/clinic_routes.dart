import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_ui/flutter_ui.dart';

final List<RouteBase> clinicRoutes = [
  // --- Dashboards by Role ---
  GoRoute(
    path: CorporateRoutes.ceoDashboard,
    builder: (context, state) => const CeoDashboardScreenStitch(),
  ),
  GoRoute(
    path: CorporateRoutes.headOfBusDevDashboard,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: FranchiseRoutes.franchiseOwnerDashboard,
    builder: (context, state) => const FranchiseOwnerDashboardScreenStitch(),
  ),
  GoRoute(
    path: FranchiseRoutes.billingAdminDashboard,
    builder: (context, state) => const BillingAdminDashboardScreenStitch(),
  ),
  GoRoute(
    path: SupportRoutes.customerSupportDashboard,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicDashboard,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.complianceManagerDashboard,
    builder: (context, state) => const ComplianceManagerDashboardScreenStitch(),
  ),

  // --- Sub-Screens ---
  GoRoute(
    path: CommonRoutes.clinicClientProfile,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicCarePlan,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicHistoryLogs,
    builder: (context, state) => const HistoryLogsScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicProfileSettings,
    builder: (context, state) => const ProfileSettingsScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicMessaging,
    builder: (context, state) => const MessagingScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicIncidentReport,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicCheckInOut,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicDailyNotes,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicShiftDetails,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  ),
  GoRoute(
    path: CommonRoutes.clinicMyShifts,
    builder: (context, state) => const DynamicRoleDashboardScreen(),
  )
];


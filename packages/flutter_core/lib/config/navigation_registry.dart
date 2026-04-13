import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_core/flutter_core.dart';

class NavigationRegistry {
  static final Map<String, List<PrimeCareNavigationItem>> _roleMenus = {
    'Admin': [
      const PrimeCareNavigationItem(
        label: 'Executive Dashboard',
        icon: Icons.dashboard,
        route: CorporateRoutes.ceoDashboard,
      ),
      const PrimeCareNavigationItem(
        label: 'Global Reports',
        icon: Icons.analytics,
        route: CorporateRoutes.complianceManagerDashboard,
      ),
      const PrimeCareNavigationItem(
        label: 'System Settings',
        icon: Icons.settings,
        route: CommonRoutes.globalSettings,
      ),
    ],
    'PSW': [
      const PrimeCareNavigationItem(
        label: 'Clinical Dashboard',
        icon: LucideIcons.stethoscope,
        route: CommonRoutes.clinicDashboard,
      ),
      const PrimeCareNavigationItem(
        label: 'Messages',
        icon: Icons.chat_bubble_outline,
        route: CommonRoutes.messagingHub,
      ),
      const PrimeCareNavigationItem(
        label: 'My Schedule',
        icon: Icons.calendar_today,
        route: '/',
      ),
    ],
    'Client': [
      const PrimeCareNavigationItem(
        label: 'Home',
        icon: Icons.home,
        route: ClientRoutes.clientDashboard,
      ),
      const PrimeCareNavigationItem(
        label: 'Appointments',
        icon: Icons.calendar_today,
        route: '/',
      ),
      const PrimeCareNavigationItem(
        label: 'Messages',
        icon: Icons.chat,
        route: CommonRoutes.messagingHub,
      ),
      const PrimeCareNavigationItem(
        label: 'Profile',
        icon: Icons.account_circle,
        route: CommonRoutes.globalProfile,
      ),
    ],
    'Receptionist': [
      const PrimeCareNavigationItem(
        label: 'Institutional Scheduler',
        icon: LucideIcons.calendar,
        route: CommonRoutes.institutionalScheduler,
      ),
      const PrimeCareNavigationItem(
        label: 'Messaging',
        icon: LucideIcons.messageSquare,
        route: CommonRoutes.messagingHub,
      ),
    ],
    'Facility Manager': [
      const PrimeCareNavigationItem(
        label: 'Command Center',
        icon: LucideIcons.layoutDashboard,
        route: CommonRoutes.institutionalScheduler,
      ),
      const PrimeCareNavigationItem(
        label: 'Staff Matrix',
        icon: LucideIcons.users,
        route: CommonRoutes.institutionalScheduler,
      ),
      const PrimeCareNavigationItem(
        label: 'System Audits',
        icon: LucideIcons.shieldCheck,
        route: CommonRoutes.auditsScreen,
      ),
    ],
  };

  static List<PrimeCareNavigationItem> getMenuForRole(String role) {
    // Exact match or fallback to a default (e.g. clinic dashboard for staff)
    return _roleMenus[role] ?? _roleMenus['PSW']!;
  }
}

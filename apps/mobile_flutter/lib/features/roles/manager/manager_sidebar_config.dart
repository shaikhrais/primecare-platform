import 'package:primecare_mobile/core/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/sidebar_config.dart';

final managerSidebarConfig = SidebarConfig(
  activeColor: const Color(0xFFF43F5E),
  paths: [AppRoutes.managerHome, AppRoutes.managerTeams, AppRoutes.managerPayroll, AppRoutes.managerIncidents, AppRoutes.managerInbox, AppRoutes.managerSow],
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reports'),
    BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Teams'),
    BottomNavigationBarItem(icon: Icon(Icons.payments), label: 'Payroll'),
    BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'Escalations'),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
    BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'My List'),
  ],
);

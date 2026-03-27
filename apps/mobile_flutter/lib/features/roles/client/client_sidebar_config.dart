import 'package:primecare_mobile/core/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/sidebar_config.dart';

final clientSidebarConfig = SidebarConfig(
  activeColor: const Color(0xFF0EA5E9),
  paths: [AppRoutes.clientHome, AppRoutes.clientPulse, AppRoutes.clientDispatch, AppRoutes.clientPayments, AppRoutes.clientInbox],
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Team'),
    BottomNavigationBarItem(icon: Icon(Icons.monitor_heart), label: 'Pulse'),
    BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Tracker'),
    BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Billing'),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
  ],
);

import 'package:primecare_mobile/core/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/sidebar_config.dart';

final gmSidebarConfig = SidebarConfig(
  activeColor: const Color(0xFF6366F1),
  paths: [AppRoutes.gmHomeAlt, AppRoutes.gmPnl, AppRoutes.gmInbox, AppRoutes.gmSow],
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Executive'),
    BottomNavigationBarItem(icon: Icon(Icons.stacked_line_chart), label: 'Ledger'),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Comm'),
    BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'My List'),
  ],
);

import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/sidebar_config.dart';

final gmSidebarConfig = SidebarConfig(
  activeColor: const Color(0xFF6366F1),
  paths: ['/gm_home', '/gm/pnl', '/gm/inbox', '/gm/sow'],
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Executive'),
    BottomNavigationBarItem(icon: Icon(Icons.stacked_line_chart), label: 'Ledger'),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Comm'),
    BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'My List'),
  ],
);

import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/sidebar_config.dart';

final managerSidebarConfig = SidebarConfig(
  activeColor: const Color(0xFFF43F5E),
  paths: ['/manager/home', '/manager/teams', '/manager/payroll', '/manager/incidents', '/universal/manager/inbox', '/universal/sow'],
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reports'),
    BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Teams'),
    BottomNavigationBarItem(icon: Icon(Icons.payments), label: 'Payroll'),
    BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'Escalations'),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
    BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'My List'),
  ],
);

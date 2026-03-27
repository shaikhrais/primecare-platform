import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/sidebar_config.dart';

final coordinatorSidebarConfig = SidebarConfig(
  activeColor: const Color(0xFFF59E0B),
  paths: ['/coordinator/home', '/coordinator/approvals', '/coordinator/callin', '/coordinator/visit-adjust', '/coordinator/inbox', '/coordinator/sow'],
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Hub'),
    BottomNavigationBarItem(icon: Icon(Icons.fact_check), label: 'Approvals'),
    BottomNavigationBarItem(icon: Icon(Icons.phone_disabled), label: 'Call-in'),
    BottomNavigationBarItem(icon: Icon(Icons.edit_calendar), label: 'Adjust'),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
    BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'My List'),
  ],
);

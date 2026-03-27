import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/sidebar_config.dart';

final adminSidebarConfig = SidebarConfig(
  activeColor: const Color(0xFF8B5CF6),
  paths: ['/admin/home', '/admin/audit', '/admin/inbox', '/admin/sow', '/admin/forms'],
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.radar), label: 'Telemetry'),
    BottomNavigationBarItem(icon: Icon(Icons.security), label: 'Shadows'),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
    BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'My List'),
    BottomNavigationBarItem(icon: Icon(Icons.dynamic_form_rounded), label: 'Forms'),
  ],
);

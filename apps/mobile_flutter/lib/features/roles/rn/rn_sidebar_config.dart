import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/sidebar_config.dart';

final rnSidebarConfig = SidebarConfig(
  activeColor: const Color(0xFF3B82F6),
  paths: ['/rn/home', '/rn/care-plan', '/rn/inbox', '/rn/sow'],
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Patients'),
    BottomNavigationBarItem(icon: Icon(Icons.edit_document), label: 'Plan'),
    BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Inbox'),
    BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'My List'),
  ],
);

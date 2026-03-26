import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/sidebar_config.dart';

final superuserSidebarConfig = SidebarConfig(
  activeColor: const Color(0xFFEF4444),
  paths: ['/superuser/home', '/superuser/territory', '/superuser/registry', '/universal/sow'],
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Root'),
    BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Territories'),
    BottomNavigationBarItem(icon: Icon(Icons.sync_problem), label: 'Registry'),
    BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'My List'),
  ],
);

import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/sidebar_config.dart';

final mtSidebarConfig = SidebarConfig(
  activeColor: const Color(0xFFF97316),
  paths: ['/mt/home', '/mt/surge-config', '/universal/mt/inbox', '/universal/sow'],
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analytics'),
    BottomNavigationBarItem(icon: Icon(Icons.offline_bolt), label: 'Surge'),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
    BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'My List'),
  ],
);

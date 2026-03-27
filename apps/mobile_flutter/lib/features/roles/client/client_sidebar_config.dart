import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/sidebar_config.dart';

final clientSidebarConfig = SidebarConfig(
  activeColor: const Color(0xFF0EA5E9),
  paths: ['/client/home', '/client/pulse', '/client/dispatch', '/client/payments', '/client/inbox'],
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Team'),
    BottomNavigationBarItem(icon: Icon(Icons.monitor_heart), label: 'Pulse'),
    BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Tracker'),
    BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Billing'),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
  ],
);

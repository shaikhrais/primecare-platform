import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/sidebar_config.dart';

final pswSidebarConfig = SidebarConfig(
  activeColor: const Color(0xFF10B981),
  paths: ['/psw/home', '/psw/timesheets', '/psw/earnings', '/psw/inbox', '/psw/sow'],
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.schedule_send), label: 'Timesheet'),
    BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: 'Earnings'),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
    BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'My List'),
  ],
);

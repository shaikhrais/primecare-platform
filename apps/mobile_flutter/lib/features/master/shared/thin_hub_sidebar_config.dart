import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/sidebar_config.dart';

final thinHubSidebarConfig = SidebarConfig(
  activeColor: Colors.grey,
  paths: ['/thin-hub'],
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.hub), label: 'Hub'),
  ],
);

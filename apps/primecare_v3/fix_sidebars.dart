import 'dart:io';

void main() {
  final roles = {
    'client': { 'title': 'Client Portal', 'icon': 'Icons.person' },
    'family_member': { 'title': 'Family Monitoring', 'icon': 'Icons.family_restroom' },
    'territory_sales_manager': { 'title': 'Territory Manager', 'icon': 'Icons.business_center' }
  };
  
  for (var role in roles.keys) {
    String titleCaseRole = role[0].toUpperCase() + role.substring(1).toLowerCase();
    
    // Sidebar
    File('lib/modules/offices/HO/$role/${role}_side_bar.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';

class \${titleCaseRole}Side_barWidget extends StatelessWidget {
  const \${titleCaseRole}Side_barWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSidebarEngine(
      activeRoute: '/ho/$role/dashboard',
      roleTitle: '${roles[role]!['title']}',
      officeCode: 'Head Office (HO)',
      menus: [
        SidebarMenuConfig(label: 'Dashboard', route: '/ho/$role/dashboard', icon: ${roles[role]!['icon']}),
        SidebarMenuConfig(label: 'Settings', route: '/ho/$role/settings', icon: Icons.settings),
      ],
    );
  }
}
''');

    // Topbar
    File('lib/modules/offices/HO/$role/${role}_top_bar.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/components/common_topbar_engine.dart';

class \${titleCaseRole}Top_barWidget extends StatelessWidget {
  const \${titleCaseRole}Top_barWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTopbarEngine(
      screenTitle: '${roles[role]!['title']} Dashboard',
      onLanguageToggle: () {
        context.setLocale(context.locale == const Locale('en') ? const Locale('fr') : const Locale('en'));
      },
      onNotificationsTap: () {},
    );
  }
}
''');
  }
  print('Constructed 6 sidebars/topbars safely.');
}

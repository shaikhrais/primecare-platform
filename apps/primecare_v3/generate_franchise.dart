import 'dart:io';

void main() {
  final office = 'FR';
  final roles = [
    'clinical_team',
    'support_team',
    'marketing_local_growth',
    'client_side',
    'business_development'
  ];
  
  final basePath = 'lib/modules/offices';

  for (final role in roles) {
    final roleDir = Directory('$basePath/$office/$role');
    roleDir.createSync(recursive: true);

    String titleCaseRole = role.split('_').map((w) => w[0].toUpperCase() + w.substring(1)).join('');

    final files = [
      'layout',
      'side_bar',
      'top_bar',
      'dashboard',
      'settings',
      'routes',
      'menu_config',
      'permissions',
      'screen_registry',
      'translation_keys'
    ];

    for (final f in files) {
      final file = File('${roleDir.path}/${role}_$f.dart');
      final placeholderKey = '${office}_${role.toUpperCase()}_${f.toUpperCase()}_PLACEHOLDER';
      
      String classNamePrefix = titleCaseRole;
      String classNameSuffix = f.split('_').map((w) => w[0].toUpperCase() + w.substring(1)).join('');
      
      String content = '';
      
      if (f == 'layout') {
         content = '''
import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import '${role}_side_bar.dart';
import '${role}_top_bar.dart';

class ${classNamePrefix}LayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const ${classNamePrefix}LayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const ${classNamePrefix}SideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const ${classNamePrefix}TopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
''';
      } else if (f == 'side_bar') {
         content = '''
import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';

class ${classNamePrefix}SideBarWidget extends StatelessWidget {
  const ${classNamePrefix}SideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonSidebarEngine(
      activeRoute: '/fr/$role/dashboard',
      roleTitle: '$titleCaseRole Franchise',
      officeCode: 'Franchise Office (FR)',
      menus: [
        SidebarMenuConfig(label: 'Dashboard', route: '/fr/$role/dashboard', icon: Icons.dashboard),
        SidebarMenuConfig(label: 'Settings', route: '/fr/$role/settings', icon: Icons.settings),
      ],
    );
  }
}
''';
      } else if (f == 'top_bar') {
         content = '''
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/components/common_topbar_engine.dart';

class ${classNamePrefix}TopBarWidget extends StatelessWidget {
  const ${classNamePrefix}TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTopbarEngine(
      screenTitle: '$titleCaseRole Center',
      onLanguageToggle: () {
        context.setLocale(context.locale == const Locale('en') ? const Locale('fr') : const Locale('en'));
      },
      onNotificationsTap: () {},
    );
  }
}
''';
      } else if (f == 'dashboard') {
         content = '''
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ${classNamePrefix}DashboardWidget extends StatelessWidget {
  const ${classNamePrefix}DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScrollWrapper(
      physics: const BouncingScrollPhysics(),
      child: PrimeCareContainer(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const PrimeCareText('$titleCaseRole Matrix', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const PrimeCareSizedBox(height: 16),
            const UrgentAlertBanner(
              message: 'Connecting to ${role.replaceAll('_', ' ')} endpoints...'
            ),
          ]
        ),
      )
    );
  }
}
''';
      } else {
         content = '''
import 'package:flutter/material.dart';

class ${classNamePrefix}${classNameSuffix}Widget extends StatelessWidget {
  const ${classNamePrefix}${classNameSuffix}Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: const EdgeInsets.all(24),
       child: Center(
         child: Text(
           'FRANCHISE GENERATED:\\n$placeholderKey',
           textAlign: TextAlign.center,
           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
         )
       )
    );
  }
}
''';
      }
      file.writeAsStringSync(content);
    }
  }
  print('Scaffolded 50 precise franchise components natively!');
}

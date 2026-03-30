import 'dart:io';

void main() {
  final offices = {
    'corporate_head_office': 'Corporate / Head Office',
    'business_development_team': 'Business Development Team',
    'franchise_level': 'Franchise Level (Hamilton)',
    'clinical_team': 'Clinical Team',
    'support_team': 'Support Team',
    'marketing_local_growth': 'Marketing and Local Growth',
    'client_side': 'Client Side'
  };
  
  final basePath = 'lib/modules/offices';

  for (final entry in offices.entries) {
    final folder = entry.key;
    final title = entry.value;

    final dir = Directory('$basePath/$folder');
    dir.createSync(recursive: true);

    String classNamePrefix = folder.split('_').map((w) => w[0].toUpperCase() + w.substring(1)).join('');

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
      final file = File('${dir.path}/${folder}_$f.dart');
      
      String classNameSuffix = f.split('_').map((w) => w[0].toUpperCase() + w.substring(1)).join('');
      
      String content = '';
      
      if (f == 'layout') {
         content = '''
import 'package:flutter/material.dart';
import '../../../core/role_templates/base_role_layout.dart';
import '${folder}_side_bar.dart';
import '${folder}_top_bar.dart';

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
import '../../../../core/components/common_sidebar_engine.dart';

class ${classNamePrefix}SideBarWidget extends StatelessWidget {
  const ${classNamePrefix}SideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonSidebarEngine(
      activeRoute: '/$folder/dashboard',
      roleTitle: '$title Dashboard',
      officeCode: '$title',
      menus: [
        SidebarMenuConfig(label: 'Dashboard', route: '/$folder/dashboard', icon: Icons.dashboard),
        SidebarMenuConfig(label: 'Dynamic SDUI', route: '/schema-form/$folder', icon: Icons.dynamic_form),
        SidebarMenuConfig(label: 'Settings', route: '/$folder/settings', icon: Icons.settings),
      ],
    );
  }
}
''';
      } else if (f == 'top_bar') {
         content = '''
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/components/common_topbar_engine.dart';

class ${classNamePrefix}TopBarWidget extends StatelessWidget {
  const ${classNamePrefix}TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTopbarEngine(
      screenTitle: '$title Terminal',
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
            const PrimeCareText('$title Overview', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const PrimeCareSizedBox(height: 16),
            const UrgentAlertBanner(
              message: 'Connecting to $title Data Modules...'
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
       child: const Center(
         child: Text(
           'DYNAMICALLY GENERATED COMPONENT',
           textAlign: TextAlign.center,
           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
  print('Scaffolded 70 Named Department UI Files!');
}

import 'dart:io';

void main() {
  final architecture = {
    'corporate_head_office': {
      'title': 'Corporate / Head Office',
      'roles': {
        'founder_ceo': 'Founder / CEO',
        'coo_operations_head': 'COO (Operations Head)',
        'cfo_finance_head': 'CFO (Finance Head)',
        'cto_tech_head': 'CTO (Tech Head)',
        'compliance_manager': 'Compliance Manager',
        'head_business_development': 'Head of Business Development',
        'head_marketing': 'Head of Marketing',
        'training_director': 'Training Director',
        'director_of_nursing': 'Director of Nursing (DON)'
      }
    },
    'business_development_team': {
      'title': 'Business Development Team',
      'roles': {
        'regional_bd_manager_on': 'Regional BD Manager (Ontario)',
        'regional_bd_manager_usa': 'Regional BD Manager (USA)',
        'franchise_sales_manager': 'Franchise Sales Manager',
        'partnership_manager': 'Partnership Manager',
        'territory_expansion_manager': 'Territory Expansion Manager'
      }
    },
    'franchise_level': {
      'title': 'Franchise Level (Hamilton)',
      'roles': {
        'franchise_owner': 'Franchise Owner',
        'operations_manager': 'Operations Manager',
        'scheduler_coordinator': 'Scheduler / Coordinator',
        'billing_admin': 'Billing / Admin',
        'hr_hiring': 'HR / Hiring'
      }
    },
    'clinical_team': {
      'title': 'Clinical Team',
      'roles': {
        'rn': 'RN (Registered Nurse)',
        'rpn': 'RPN',
        'rmt': 'RMT',
        'psw': 'PSW',
        'physiotherapist': 'Physiotherapist (PT)',
        'care_coordinator': 'Care Coordinator'
      }
    },
    'support_team': {
      'title': 'Support Team',
      'roles': {
        'customer_support': 'Customer Support',
        'intake_coordinator': 'Intake Coordinator',
        'quality_assurance': 'Quality Assurance',
        'training_coordinator': 'Training Coordinator',
        'it_administrator': 'IT Administrator',
        'billing_specialist': 'Billing Specialist'
      }
    },
    'marketing_local_growth': {
      'title': 'Marketing and Local Growth',
      'roles': {
        'local_marketing_manager': 'Local Marketing Manager',
        'community_outreach': 'Community Outreach',
        'territory_sales_manager': 'Territory Sales Manager'
      }
    },
    'client_side': {
      'title': 'Client Side',
      'roles': {
        'client': 'Client',
        'family_member': 'Family Member'
      }
    }
  };

  final basePath = 'lib/modules/offices';

  StringBuffer routerImports = StringBuffer();
  StringBuffer routerRoutes = StringBuffer();
  
  routerImports.writeln("import 'package:flutter/material.dart';");
  routerImports.writeln("import 'package:go_router/go_router.dart';");
  routerImports.writeln("import '../core/forms/form_renderer_adapter.dart';");

  for (final officeEntry in architecture.entries) {
    final officeKey = officeEntry.key;
    final officeTitle = officeEntry.value['title'] as String;
    final roles = officeEntry.value['roles'] as Map<String, String>;

    for (final roleEntry in roles.entries) {
      final roleKey = roleEntry.key;
      final roleTitle = roleEntry.value;

      final dir = Directory('$basePath/$officeKey/$roleKey');
      dir.createSync(recursive: true);

      String roleClassNamePrefix = roleKey.split('_').map((w) => w[0].toUpperCase() + w.substring(1)).join('');

      routerImports.writeln("import '../modules/offices/$officeKey/$roleKey/${roleKey}_layout.dart';");
      routerImports.writeln("import '../modules/offices/$officeKey/$roleKey/${roleKey}_dashboard.dart';");
      routerImports.writeln("import '../modules/offices/$officeKey/$roleKey/${roleKey}_settings.dart';");

      routerRoutes.writeln('''
      ShellRoute(
        builder: (context, state, child) {
          return ${roleClassNamePrefix}LayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: '/$officeKey/$roleKey/dashboard',
             builder: (_, __) => const ${roleClassNamePrefix}DashboardWidget(),
           ),
           GoRoute(
             path: '/$officeKey/$roleKey/settings',
             builder: (_, __) => const ${roleClassNamePrefix}SettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),''');

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
        final file = File('${dir.path}/${roleKey}_$f.dart');
        String classNameSuffix = f.split('_').map((w) => w[0].toUpperCase() + w.substring(1)).join('');
        String content = '';

        if (f == 'layout') {
          content = '''
import 'package:flutter/material.dart';
import '../../../../core/role_templates/base_role_layout.dart';
import '${roleKey}_side_bar.dart';
import '${roleKey}_top_bar.dart';

class ${roleClassNamePrefix}LayoutWidget extends BaseRoleLayout {
  final Widget childContent;

  const ${roleClassNamePrefix}LayoutWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget buildSideBar(BuildContext context) => const ${roleClassNamePrefix}SideBarWidget();

  @override
  Widget buildTopBar(BuildContext context) => const ${roleClassNamePrefix}TopBarWidget();

  @override
  Widget buildContent(BuildContext context) => childContent;
}
''';
        } else if (f == 'side_bar') {
          content = '''
import 'package:flutter/material.dart';
import '../../../../../core/components/common_sidebar_engine.dart';

class ${roleClassNamePrefix}SideBarWidget extends StatelessWidget {
  const ${roleClassNamePrefix}SideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonSidebarEngine(
      activeRoute: '/$officeKey/$roleKey/dashboard',
      roleTitle: '$roleTitle',
      officeCode: '$officeTitle',
      menus: [
        SidebarMenuConfig(label: 'Dashboard', route: '/$officeKey/$roleKey/dashboard', icon: Icons.dashboard),
        SidebarMenuConfig(label: 'Dynamic SDUI', route: '/schema-form/$roleKey', icon: Icons.dynamic_form),
        SidebarMenuConfig(label: 'Settings', route: '/$officeKey/$roleKey/settings', icon: Icons.settings),
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

class ${roleClassNamePrefix}TopBarWidget extends StatelessWidget {
  const ${roleClassNamePrefix}TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTopbarEngine(
      screenTitle: '$roleTitle Terminal',
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

class ${roleClassNamePrefix}DashboardWidget extends StatelessWidget {
  const ${roleClassNamePrefix}DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScrollWrapper(
      physics: const BouncingScrollPhysics(),
      child: PrimeCareContainer(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const PrimeCareText('$roleTitle Overview', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const PrimeCareSizedBox(height: 16),
            const UrgentAlertBanner(
              message: 'Connecting to $officeTitle Data Modules for $roleTitle...'
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

class ${roleClassNamePrefix}${classNameSuffix}Widget extends StatelessWidget {
  const ${roleClassNamePrefix}${classNameSuffix}Widget({super.key});

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
  }

  String finalRouterContent = '''
$routerImports

final router = GoRouter(
  initialLocation: '/corporate_head_office/founder_ceo/dashboard',
  routes: [
$routerRoutes
  ],
);
''';

  File('lib/core/app_router.dart').writeAsStringSync(finalRouterContent);
  print('Scaffolded EXACTLY 360 Distinct UI Files mapped natively inside 7 Departments (36 Roles)!');
}

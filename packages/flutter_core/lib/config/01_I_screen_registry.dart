// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';

class KpiConfig {
  final String title;
  final String value;
  final String deltaSuffix;
  final IconData icon;
  final Color iconColor;

  const KpiConfig({
    required this.title,
    required this.value,
    required this.deltaSuffix,
    required this.icon,
    required this.iconColor,
  });

  factory KpiConfig.fromJson(Map<String, dynamic> json) {
    return KpiConfig(
      title: json['title'] as String? ?? 'Stat',
      value: json['value'] as String? ?? '0',
      deltaSuffix: json['deltaSuffix'] as String? ?? '',
      icon: _getIconData(json['icon'] as String?),
      iconColor: _getColor(json['iconColor'] as String?),
    );
  }

  static IconData _getIconData(String? name) {
    switch (name) {
      case 'users':
        return LucideIcons.users;
      case 'stethoscope':
        return LucideIcons.stethoscope;
      case 'dollarSign':
        return LucideIcons.dollarSign;
      case 'shieldAlert':
        return LucideIcons.shieldAlert;
      case 'briefcase':
        return LucideIcons.briefcase;
      case 'barChart2':
        return LucideIcons.barChart2;
      case 'heart':
        return LucideIcons.heartPulse;
      case 'clipboardList':
        return LucideIcons.clipboardList;
      case 'userCheck':
        return LucideIcons.userCheck;
      case 'clock':
        return LucideIcons.clock;
      default:
        return LucideIcons.barChart;
    }
  }

  static Color _getColor(String? name) {
    switch (name) {
      case 'blue':
        return Colors.blueAccent;
      case 'teal':
        return Colors.tealAccent;
      case 'green':
        return Colors.greenAccent;
      case 'orange':
        return Colors.orangeAccent;
      case 'purple':
        return Colors.purpleAccent;
      case 'red':
        return Colors.redAccent;
      default:
        return Colors.blueGrey;
    }
  }
}

class DashboardConfig {
  final String title;
  final String subtitle;
  final List<KpiConfig> kpis;

  const DashboardConfig({
    required this.title,
    required this.subtitle,
    required this.kpis,
  });

  factory DashboardConfig.fromJson(Map<String, dynamic> json) {
    return DashboardConfig(
      title: json['title'] as String? ?? 'Dashboard',
      subtitle:
          json['subtitle'] as String? ?? 'Overview metrics and operations.',
      kpis:
          (json['kpis'] as List<dynamic>?)
              ?.map((kpi) => KpiConfig.fromJson(kpi as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

typedef DynamicDashboardBuilder =
    Widget Function(BuildContext context, String role);

/// Central Registry mapping application routes to dynamic dashboard JSON configurations.
class ScreenRegistry {
  static DynamicDashboardBuilder? _dynamicDashboardBuilder;

  /// Injected from the UI layer to prevent circular dependencies.
  static void setDynamicDashboardBuilder(DynamicDashboardBuilder builder) {
    _dynamicDashboardBuilder = builder;
  }

  static Widget buildDynamicDashboard(BuildContext context, String role) {
    if (_dynamicDashboardBuilder != null) {
      return _dynamicDashboardBuilder!(context, role);
    }
    return Center(
      child: Text('Dynamic Dashboard Builder Not Initialized for $role'),
    );
  }

  // We represent the registry as JSON structures so it can easily be backed by an API/Edge Worker later.
  static final Map<String, Map<String, dynamic>> _registryJson = {
    CorporateRoutes.ceoDashboard: {
      'title': 'Global Platform Overview',
      'subtitle':
          'Real-time metrics across all PrimeCare franchise locations and clinical nodes.',
      'kpis': [
        {
          'title': 'Active Patients',
          'value': '14,239',
          'deltaSuffix': '+12% this month',
          'icon': 'users',
          'iconColor': 'blue',
        },
        {
          'title': 'Providers',
          'value': '1,842',
          'deltaSuffix': '+5% this month',
          'icon': 'stethoscope',
          'iconColor': 'teal',
        },
        {
          'title': 'Gross Revenue',
          'value': '\$4.2M',
          'deltaSuffix': '+18% this quarter',
          'icon': 'dollarSign',
          'iconColor': 'green',
        },
        {
          'title': 'Critical Alerts',
          'value': '3',
          'deltaSuffix': '-2 since yesterday',
          'icon': 'shieldAlert',
          'iconColor': 'orange',
        },
      ],
    },
    CorporateRoutes.headOfBusDevDashboard: {
      'title': 'Growth & Acquisition',
      'subtitle':
          'Metrics for franchise conversions and territory penetration.',
      'kpis': [
        {
          'title': 'Franchises',
          'value': '48',
          'deltaSuffix': '+3 this month',
          'icon': 'briefcase',
          'iconColor': 'blue',
        },
        {
          'title': 'Pipeline Value',
          'value': '\$1.1M',
          'deltaSuffix': '+15% MoM',
          'icon': 'barChart2',
          'iconColor': 'purple',
        },
        {
          'title': 'Active Leads',
          'value': '1,204',
          'deltaSuffix': '+24% this week',
          'icon': 'users',
          'iconColor': 'teal',
        },
        {
          'title': 'Win Rate',
          'value': '24%',
          'deltaSuffix': '+2% this quarter',
          'icon': 'userCheck',
          'iconColor': 'green',
        },
      ],
    },
    FranchiseRoutes.franchiseOwnerDashboard: {
      'title': 'Location Headquarters',
      'subtitle': 'Central operational hub for managing franchise performance.',
      'kpis': [
        {
          'title': 'Clients',
          'value': '842',
          'deltaSuffix': '+12 new this week',
          'icon': 'users',
          'iconColor': 'blue',
        },
        {
          'title': 'Staff',
          'value': '45',
          'deltaSuffix': '2 open roles',
          'icon': 'briefcase',
          'iconColor': 'purple',
        },
        {
          'title': 'Monthly Rev.',
          'value': '\$124k',
          'deltaSuffix': '+5% MoM',
          'icon': 'dollarSign',
          'iconColor': 'green',
        },
        {
          'title': 'Utilization',
          'value': '88%',
          'deltaSuffix': 'Optimal range',
          'icon': 'barChart2',
          'iconColor': 'teal',
        },
      ],
    },
    FranchiseRoutes.billingAdminDashboard: {
      'title': 'Billing Administration',
      'subtitle': 'Manage invoices, claims, and reconciliation.',
      'kpis': [
        {
          'title': 'Pending Claims',
          'value': '156',
          'deltaSuffix': '-12% this week',
          'icon': 'clipboardList',
          'iconColor': 'orange',
        },
        {
          'title': 'A/R',
          'value': '\$42k',
          'deltaSuffix': 'Net 30',
          'icon': 'dollarSign',
          'iconColor': 'red',
        },
      ],
    },
    SupportRoutes.customerSupportDashboard: {
      'title': 'Support & QA Diagnostics',
      'subtitle': 'Manage tickets, escalations, and system uptime.',
      'kpis': [
        {
          'title': 'Open Tickets',
          'value': '23',
          'deltaSuffix': '-5 since yesterday',
          'icon': 'clipboardList',
          'iconColor': 'blue',
        },
        {
          'title': 'Avg Resolution',
          'value': '1.2h',
          'deltaSuffix': '-15m this week',
          'icon': 'clock',
          'iconColor': 'green',
        },
        {
          'title': 'Escalations',
          'value': '2',
          'deltaSuffix': 'Require Action',
          'icon': 'shieldAlert',
          'iconColor': 'red',
        },
      ],
    },
    CommonRoutes.clinicDashboard: {
      'title': 'Clinical Floor Operations',
      'subtitle': 'Track active shifts and priority care alerts.',
      'kpis': [
        {
          'title': 'Active Shifts',
          'value': '112',
          'deltaSuffix': 'All locations',
          'icon': 'clock',
          'iconColor': 'teal',
        },
        {
          'title': 'Care Plans Due',
          'value': '8',
          'deltaSuffix': 'Within 48hrs',
          'icon': 'clipboardList',
          'iconColor': 'orange',
        },
        {
          'title': 'Incident Reports',
          'value': '0',
          'deltaSuffix': 'Last 24hrs',
          'icon': 'shieldAlert',
          'iconColor': 'green',
        },
      ],
    },
    CorporateRoutes.complianceManagerDashboard: {
      'title': 'Compliance Governance',
      'subtitle':
          'Track regulatory metrics, policy training, and audit status.',
      'kpis': [
        {
          'title': 'Audits Pending',
          'value': '4',
          'deltaSuffix': 'Due this month',
          'icon': 'shieldAlert',
          'iconColor': 'orange',
        },
        {
          'title': 'Training Compl.',
          'value': '92%',
          'deltaSuffix': '+4% increase',
          'icon': 'userCheck',
          'iconColor': 'green',
        },
        {
          'title': 'Policy Updates',
          'value': '12',
          'deltaSuffix': 'Need review',
          'icon': 'clipboardList',
          'iconColor': 'purple',
        },
      ],
    },
    CommonRoutes.schedulingScreen: {
      'title': 'Institutional Horizon',
      'subtitle':
          'Unified cross-professional staff matrix & appointment control.',
      'kpis': [
        {
          'title': 'Active Staff',
          'value': '48',
          'deltaSuffix': 'Live Status',
          'icon': 'users',
          'iconColor': 'blue',
        },
        {
          'title': 'Pending Intake',
          'value': '12',
          'deltaSuffix': 'Action Required',
          'icon': 'clock',
          'iconColor': 'orange',
        },
      ],
    },
    CommonRoutes.institutionalScheduler: {
      'title': 'Central Command Center',
      'subtitle': 'Real-time multi-staff scheduling & asset optimization hub.',
      'kpis': [
        {
          'title': 'Staff Online',
          'value': '32',
          'deltaSuffix': 'Active Shift',
          'icon': 'users',
          'iconColor': 'blue',
        },
        {
          'title': 'Resource Load',
          'value': '78%',
          'deltaSuffix': 'Peak Usage',
          'icon': 'barChart2',
          'iconColor': 'teal',
        },
        {
          'title': 'Intake Queue',
          'value': '5',
          'deltaSuffix': 'Priority 1',
          'icon': 'clock',
          'iconColor': 'orange',
        },
        {
          'title': 'Maintenance',
          'value': '2',
          'deltaSuffix': 'Active Alerts',
          'icon': 'shieldAlert',
          'iconColor': 'red',
        },
      ],
    },
    CommonRoutes.messagingHub: {
      'title': 'Communication Nexus',
      'subtitle': 'Real-time inter-tenant messaging and collaboration network.',
      'kpis': [
        {
          'title': 'Active Chats',
          'value': '28',
          'deltaSuffix': 'Live now',
          'icon': 'users',
          'iconColor': 'blue',
        },
        {
          'title': 'Unread Alert',
          'value': '5',
          'deltaSuffix': 'Priority',
          'icon': 'shieldAlert',
          'iconColor': 'orange',
        },
        {
          'title': 'Avg Response',
          'value': '4m',
          'deltaSuffix': 'SLA Target',
          'icon': 'clock',
          'iconColor': 'teal',
        },
      ],
    },
  };

  /// Fetch dashboard config for a route. Fallback to a default layout if none configured.
  static DashboardConfig getDashboardForRoute(String route) {
    // Exact match
    if (_registryJson.containsKey(route)) {
      return DashboardConfig.fromJson(_registryJson[route]!);
    }

    // Fallback default dynamic screen
    return DashboardConfig(
      title: 'Dynamic Dashboard Space',
      subtitle:
          'This workspace is actively configured by the PrimeCare Central Registry.',
      kpis: [
        const KpiConfig(
          title: 'Active Metrics',
          value: 'Optimal',
          deltaSuffix: 'System Normal',
          icon: LucideIcons.activity,
          iconColor: Colors.blueAccent,
        ),
      ],
    );
  }
}

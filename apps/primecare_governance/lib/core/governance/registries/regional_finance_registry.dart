import 'package:flutter/material.dart';
import '../screen_metadata.dart';

class RegionalFinanceRegistry {
  static final Map<String, ScreenMetadata> screens = {
    'ONT_FIN_OVERVIEW': const ScreenMetadata(
      id: 'ONT_FIN_OVERVIEW',
      featureName: 'Ontario Financial Overview',
      routePath: '/regional/finance/overview',
      allowedRoles: ['Admin', 'Finance Director'],
      title: 'Ontario Financial Overview',
      icon: Icons.analytics_outlined,
      description: 'High-level financial KPIs for Ontario regional operations.',
      office: 'Regional Finance',
      role: 'Finance Director',
      lifecycleStatus: LifecycleStatus.completed,
      serialNo: 'PC-IMP-0001',
      stitchProject: '5790421608425017338',
    ),
    'ONT_FIN_APPROVALS': const ScreenMetadata(
      id: 'ONT_FIN_APPROVALS',
      featureName: 'Pending Approvals Queue',
      routePath: '/regional/finance/approvals',
      allowedRoles: ['Admin', 'Finance Director'],
      title: 'Pending Approvals Queue',
      icon: Icons.fact_check_outlined,
      description: 'Detail view for auditing and approving regional expenditure.',
      office: 'Regional Finance',
      role: 'Finance Director',
      lifecycleStatus: LifecycleStatus.completed,
      serialNo: 'PC-IMP-0002',
      stitchProject: '5790421608425017338',
    ),
    'ONT_FIN_ROADMAP': const ScreenMetadata(
      id: 'ONT_FIN_ROADMAP',
      featureName: 'Regional Implementation Roadmap',
      routePath: '/regional/finance/roadmap',
      allowedRoles: ['Admin', 'Finance Director'],
      title: 'Regional Implementation Roadmap',
      icon: Icons.map_outlined,
      description: 'Strategic rollout plan for regional financial governance.',
      office: 'Regional Finance',
      role: 'Finance Director',
      lifecycleStatus: LifecycleStatus.completed,
      serialNo: 'PC-IMP-0003',
      stitchProject: '5790421608425017338',
    ),
  };
}

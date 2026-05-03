import 'screen_work_item.dart';

class ScreenWorkRegistry {
  static final List<ScreenWorkItem> pendingList = [];

  static final List<ScreenWorkItem> implementationList = [
    ScreenWorkItem(
      serialNo: 'PC-IMP-0001',
      screenCode: 'ONT-FIN-001',
      title: 'Ontario Financial Overview',
      office: 'Regional Finance',
      module: 'Dashboard',
      action: 'update',
      status: 'implemented',
      priority: 1,
      assignedTo: 'Developer',
      notes: 'Connected route, sidebar, RBAC, API mapping, and responsive layout.',
      stitchProject: '5790421608425017338',
      stitchScreenId: '571ffcbd6940455d97548c532ca511c9',
      routePath: '/regional/finance/overview',
    ),
    ScreenWorkItem(
      serialNo: 'PC-IMP-0002',
      screenCode: 'ONT-FIN-002',
      title: 'Pending Approvals Queue',
      office: 'Regional Finance',
      module: 'Dashboard',
      action: 'update',
      status: 'implemented',
      priority: 1,
      assignedTo: 'Developer',
      notes: 'Connected route, sidebar, RBAC, API mapping, and responsive layout.',
      stitchProject: '5790421608425017338',
      stitchScreenId: '042cdd9fe37746a2b73b7c3e15772637',
      routePath: '/regional/finance/approvals',
    ),
    ScreenWorkItem(
      serialNo: 'PC-IMP-0003',
      screenCode: 'ONT-FIN-003',
      title: 'Regional Implementation Roadmap',
      office: 'Regional Finance',
      module: 'Roadmap',
      action: 'update',
      status: 'implemented',
      priority: 2,
      assignedTo: 'Developer',
      notes: 'Connected route, sidebar, RBAC, API mapping, and responsive layout.',
      stitchProject: '5790421608425017338',
      stitchScreenId: '96f21a13aa514cce89635f3ee2e903c9',
      routePath: '/regional/finance/roadmap',
    ),
  ];
  static final List<ScreenChangeLog> changeLog = [];

  static void moveToImplementation(String serialNo, {String? notes}) {
    final index = pendingList.indexWhere((item) => item.serialNo == serialNo);
    if (index != -1) {
      final item = pendingList.removeAt(index);
      implementationList.add(ScreenWorkItem(
        serialNo: item.serialNo.replaceFirst('PC-PEN', 'PC-IMP'),
        screenCode: item.screenCode,
        title: item.title,
        office: item.office,
        module: item.module,
        action: 'update',
        status: 'implemented',
        priority: item.priority,
        assignedTo: 'Developer',
        notes: notes ?? item.notes,
        stitchProject: item.stitchProject,
        stitchScreenId: item.stitchScreenId,
        routePath: item.routePath,
      ));
    }
  }
}

import 'screen_work_item.dart';

class ScreenWorkRegistry {
  static final List<ScreenWorkItem> pendingList = [
    ScreenWorkItem(
      serialNo: 'PC-PEN-0001',
      screenCode: 'GOV-KNB-001',
      title: 'Kanban board UI Refinement',
      office: 'Corporate Governance',
      module: 'HUD',
      action: 'create',
      status: 'pending',
      priority: 1,
      assignedTo: 'Agent',
      notes: 'Implement drag-and-drop and glassmorphism styling.',
      targetApp: 'primecare_governance',
    ),
    ScreenWorkItem(
      serialNo: 'PC-PEN-0002',
      screenCode: 'GOV-KNB-002',
      title: 'Audit Trigger Integration',
      office: 'Corporate Governance',
      module: 'HUD',
      action: 'update',
      status: 'pending',
      priority: 2,
      assignedTo: 'Agent',
      notes: 'Sync Kanban movements with architectural audits.',
      targetApp: 'primecare_governance',
    ),
  ];

  static final List<ScreenWorkItem> implementationList = [
    ScreenWorkItem(
      serialNo: 'PC-IMP-0001',
      screenCode: 'ONT-FIN-001',
      title: 'Ontario Financial Overview',
      office: 'Regional Finance',
      module: 'Dashboard',
      action: 'update',
      status: 'verified',
      priority: 1,
      assignedTo: 'Developer',
      notes: 'Connected route, sidebar, RBAC, API mapping, and responsive layout.',
      stitchProject: '5790421608425017338',
      stitchScreenId: '571ffcbd6940455d97548c532ca511c9',
      routePath: '/regional/finance/overview',
      targetApp: 'primecare_admin',
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
      targetApp: 'primecare_admin',
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
      targetApp: 'primecare_admin',
    ),
  ];
  static final List<ScreenChangeLog> changeLog = [];

  static void updateStatus(String serialNo, String newStatus, {String? notes}) {
    // Check pending list
    final pendingIndex = pendingList.indexWhere((item) => item.serialNo == serialNo);
    if (pendingIndex != -1) {
      final item = pendingList[pendingIndex];
      if (newStatus == 'implemented' || newStatus == 'verified') {
        final removed = pendingList.removeAt(pendingIndex);
        implementationList.add(ScreenWorkItem(
          serialNo: removed.serialNo.replaceFirst('PC-PEN', 'PC-IMP'),
          screenCode: removed.screenCode,
          title: removed.title,
          office: removed.office,
          module: removed.module,
          action: 'update',
          status: newStatus,
          priority: removed.priority,
          assignedTo: 'Agent',
          notes: notes ?? removed.notes,
          stitchProject: removed.stitchProject,
          stitchScreenId: removed.stitchScreenId,
          routePath: removed.routePath,
          targetApp: removed.targetApp,
          category: removed.category,
        ));
      } else {
        // Just update status in place (though it's already pending)
        // pendingList[pendingIndex] = ... (not needed if it stays in pending)
      }
      return;
    }

    // Check implementation list
    final implIndex = implementationList.indexWhere((item) => item.serialNo == serialNo);
    if (implIndex != -1) {
      final item = implementationList[implIndex];
      implementationList[implIndex] = ScreenWorkItem(
        serialNo: item.serialNo,
        screenCode: item.screenCode,
        title: item.title,
        office: item.office,
        module: item.module,
        action: item.action,
        status: newStatus,
        priority: item.priority,
        assignedTo: item.assignedTo,
        notes: notes ?? item.notes,
        stitchProject: item.stitchProject,
        stitchScreenId: item.stitchScreenId,
        routePath: item.routePath,
        targetApp: item.targetApp,
        category: item.category,
        completedAt: newStatus == 'verified' ? DateTime.now() : item.completedAt,
      );
    }
  }

  static void moveToImplementation(String serialNo, {String? notes}) {
    updateStatus(serialNo, 'implemented', notes: notes);
  }

  static void addItem(ScreenWorkItem item) {
    pendingList.add(item);
  }
}

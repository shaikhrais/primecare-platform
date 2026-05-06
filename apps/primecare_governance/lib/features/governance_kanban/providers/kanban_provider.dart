import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/governance/screen_work_item.dart';
import '../../../core/governance/screen_work_registry.dart';
import '../../../core/governance/governance_provider.dart';

class KanbanState {
  final List<ScreenWorkItem> backlog;
  final List<ScreenWorkItem> inProgress;
  final List<ScreenWorkItem> verified;
  final bool isLoading;

  KanbanState({
    required this.backlog,
    required this.inProgress,
    required this.verified,
    this.isLoading = false,
  });

  KanbanState copyWith({
    List<ScreenWorkItem>? backlog,
    List<ScreenWorkItem>? inProgress,
    List<ScreenWorkItem>? verified,
    bool? isLoading,
  }) {
    return KanbanState(
      backlog: backlog ?? this.backlog,
      inProgress: inProgress ?? this.inProgress,
      verified: verified ?? this.verified,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class KanbanNotifier extends Notifier<KanbanState> {
  @override
  KanbanState build() {
    // Initial state
    final pending = ScreenWorkRegistry.pendingList;
    final implementation = ScreenWorkRegistry.implementationList;

    return KanbanState(
      backlog: pending.where((i) => i.status == 'pending').toList(),
      inProgress: implementation.where((i) => i.status == 'implemented').toList(),
      verified: implementation.where((i) => i.status == 'verified').toList(),
    );
  }

  void refresh() {
    final pending = ScreenWorkRegistry.pendingList;
    final implementation = ScreenWorkRegistry.implementationList;

    state = state.copyWith(
      backlog: pending.where((i) => i.status == 'pending').toList(),
      inProgress: implementation.where((i) => i.status == 'implemented').toList(),
      verified: implementation.where((i) => i.status == 'verified').toList(),
    );
  }

  Future<void> moveItem(String itemId, String newStatus) async {
    state = state.copyWith(isLoading: true);
    
    try {
      // Perform the move in the central registry
      ScreenWorkRegistry.updateStatus(itemId, newStatus);
      
      // Refresh local state
      refresh();
      
      // Notify the governance provider that something changed
      ref.read(governanceProvider.notifier).refresh();
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Initiates a Stitch-powered screen hydration process for a backlog item.
  Future<void> initiateHydration(ScreenWorkItem item) async {
    // Move to 'implemented' to simulate progress
    await moveItem(item.serialNo, 'implemented');
  }

  void addNewItem({required String title, required String app, String? module}) {
    final newItem = ScreenWorkItem(
      serialNo: 'PC-PEN-${DateTime.now().millisecondsSinceEpoch % 10000}',
      screenCode: 'NEW-${DateTime.now().millisecondsSinceEpoch % 1000}',
      title: title,
      office: 'Global',
      module: module ?? 'General',
      action: 'create',
      status: 'pending',
      priority: 2,
      assignedTo: 'Architect',
      notes: 'Manually added via Governance HUD',
      targetApp: app,
    );
    
    ScreenWorkRegistry.addItem(newItem);
    refresh();
    ref.read(governanceProvider.notifier).refresh();
  }
}

final kanbanProvider = NotifierProvider<KanbanNotifier, KanbanState>(() {
  return KanbanNotifier();
});

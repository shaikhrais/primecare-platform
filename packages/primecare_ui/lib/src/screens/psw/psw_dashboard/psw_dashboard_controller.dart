import 'package:primecare_models/primecare_models.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart' as core;

// --- MVC State Model ---
class PswDashboardScreenState extends BaseWorkspaceState<PswDashboardScreenState> {
  final bool isShiftActive;
  final List<core.PswClient> clients;
  final List<core.PswTask> tasks;
  final String shiftDurationRemaining;
  final double shiftProgress;

  const PswDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.title,
    required super.logs,
    required super.hasData,
    required this.isShiftActive,
    required this.clients,
    required this.tasks,
    required this.shiftDurationRemaining,
    required this.shiftProgress,
  });

  @override
  PswDashboardScreenState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
    bool? hasData,
    bool? isShiftActive,
    List<core.PswClient>? clients,
    List<core.PswTask>? tasks,
    String? shiftDurationRemaining,
    double? shiftProgress,
  }) {
    return PswDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
      hasData: hasData ?? this.hasData,
      isShiftActive: isShiftActive ?? this.isShiftActive,
      clients: clients ?? this.clients,
      tasks: tasks ?? this.tasks,
      shiftDurationRemaining: shiftDurationRemaining ?? this.shiftDurationRemaining,
      shiftProgress: shiftProgress ?? this.shiftProgress,
    );
  }

  @override
  PswDashboardScreenState rebuild({required bool isLoading, required String? error,
    required String title, required List<String> logs, required bool hasData}) =>
      copyWith(isLoading: isLoading, error: error, title: title, logs: logs, hasData: hasData);
}

// --- Controller (Notifier) ---
class PswDashboardScreenController extends BaseWorkspaceController<PswDashboardScreenState> {
  final Ref ref;

  PswDashboardScreenController(this.ref)
      : super(
          PswDashboardScreenState(
            isLoading: false,
            title: 'PSW Dashboard'.tr(),
            logs: const [
              'Workspace initialized.',
              'Security clearance sync complete.',
            ],
            hasData: true,
            isShiftActive: false,
            clients: const [],
            tasks: const [],
            shiftDurationRemaining: '8h 00m',
            shiftProgress: 0.0,
          ),
        ) {
    _init();
  }

  Future<void> _init() async {
    await refreshData();
  }



  void toggleShift() {
    final nextState = !state.isShiftActive;
    state = state.copyWith(isShiftActive: nextState);
    addLog(nextState ? 'Clocked IN to shift successfully.' : 'Clocked OUT of shift successfully.');
  }

  void reportIncident(String details) {
    addLog('Incident reported: $details');
  }

  void logVitals(String systolic, String diastolic, String pulse) {
    addLog('Vitals recorded: BP $systolic/$diastolic, Pulse $pulse');
  }

  Future<void> refreshData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      ref.invalidate(core.pswDashboardProvider);
      final res = await ref.read(core.pswDashboardProvider.future);
      res.fold(
        (data) {
          state = state.copyWith(
            isLoading: false,
            hasData: true,
            clients: data.clients,
            tasks: data.tasks,
            shiftDurationRemaining: data.shiftDurationRemaining,
            shiftProgress: data.shiftProgress,
          );
          addLog('Dynamically fetched ${data.clients.length} active client visits.');
        },
        (err) {
          state = state.copyWith(isLoading: false, error: err.toString(), hasData: false);
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString(), hasData: false);
    }
  }
}

// --- Provider ---
final pswDashboardScreenProvider =
    StateNotifierProvider<PswDashboardScreenController, PswDashboardScreenState>((ref) {
  return PswDashboardScreenController(ref);
});

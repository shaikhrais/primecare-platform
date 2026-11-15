import 'package:primecare_models/primecare_models.dart';
/* 
PRIME:SCREEN=psw_help_support
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_NONE
PRIME:API=API_NONE
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=0
PRIME:BLOCKER=Registered Help reader host and access binding pending
PRIME:NEXT_ACTION=Bind the registered API794 reader after access registration
*/
// Governance - Category: view | Purpose: UI Screen component rendering the PswHelpSupportScreen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart' show authProvider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class PswHelpSupportScreenState extends BaseWorkspaceState<PswHelpSupportScreenState> {

  const PswHelpSupportScreenState({
    required super.isLoading,
    super.error,
    required super.title,
    required super.logs,
    required super.hasData,
  });

  @override
  PswHelpSupportScreenState rebuild({required bool isLoading, required String? error,
    required String title, required List<String> logs, required bool hasData}) =>
      PswHelpSupportScreenState(isLoading: isLoading, error: error, title: title, logs: logs, hasData: hasData);
}

// --- Controller (Notifier) ---
class PswHelpSupportScreenController extends BaseWorkspaceController<PswHelpSupportScreenState> {
  final Ref ref;

  PswHelpSupportScreenController(this.ref)
      : super(
          PswHelpSupportScreenState(
            isLoading: false,
            title: 'navigation.items.psw_help_support'.tr(),
            logs: const [],
            hasData: false,
          ),
        ) {
    _init();
  }

  Future<void> _init() async {
    await refreshData();
  }

  Future<void> refreshData() async {
    if (!mounted) return;
    final session = ref.read(authProvider);
    // API794 has no registered native host binding yet. Do not call the
    // unrelated legacy GET or manufacture a successful reading session.
    state = state.copyWith(isLoading: false,
      error: (session.isAuthenticated ? 'workspace.no_data' : 'workspace.forbidden').tr(),
      hasData: false, logs: const []);
  }

  Future<void> runComplianceScan() async {
    if (!mounted) return;
    state = state.copyWith(isLoading: false,
      error: 'workspace.no_action'.tr(), hasData: false, logs: const []);
  }

}

// --- Provider ---
final pswHelpSupportProvider =
    StateNotifierProvider.autoDispose<PswHelpSupportScreenController, PswHelpSupportScreenState>((ref) {
  ref.watch(authProvider.select((session) =>
    (session.isAuthenticated, session.userId, session.tenantId, session.token, session.role)));
  return PswHelpSupportScreenController(ref);
});

// --- View ---
class PswHelpSupportScreen extends GovernedConsumerWidget {
  const PswHelpSupportScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswHelpSupportProvider);
    final theme = context.theme;

    return Cy(
      id: 'psw_help_support-screen',
      child: PrimeWorkspaceScaffold(
        scaffoldKey: const Key('psw_help_support-screen'),
        backgroundColor: theme.colors.background,
        headerColor: theme.colors.surface,
        title: PrimeText(state.title),
        actions: const [],
        body: state.isLoading
          ? const Center(child: PrimeLoadingIndicator())
          : DashboardErrorWidget(
              message: state.error ?? 'workspace.no_data'.tr(),
            ),
      ),
    );
  }
}

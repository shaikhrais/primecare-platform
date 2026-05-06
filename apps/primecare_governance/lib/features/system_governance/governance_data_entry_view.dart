import 'package:primecare_ui/primecare_ui.dart';
import '../../generated/locale_keys.g.dart';

import 'audit_log_view.dart';
import 'role_entry_form.dart';
import 'module_entry_form.dart';
import 'app_entry_form.dart';
import 'api_entry_form.dart';
import 'feature_entry_form.dart';
import 'lifecycle_governance_form.dart';
import 'language_entry_form.dart';

import 'correction_ticket_form.dart';
import 'ticket_list_view.dart';

/// [View] - Orchestrator for all Architectural Data Entry
/// Provides a unified, tabbed interface for managing platform metadata.
class GovernanceDataEntryView extends StatelessWidget {
  const GovernanceDataEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: Colors.transparent, // Allow glassmorphism background
        appBar: AppBar(
          title: Text(LocaleKeys.governance_discovered_forms.tr()),
          backgroundColor: theme.colors.background.withValues(alpha: 0.8),
          elevation: 0,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: theme.colors.primary,
            labelColor: theme.colors.primary,
            unselectedLabelColor: theme.colors.onSurfaceVariant,
            tabs: const [
              Tab(text: 'Roles', icon: Icon(Icons.admin_panel_settings_rounded)),
              Tab(text: 'Modules', icon: Icon(Icons.view_module_rounded)),
              Tab(text: 'Apps', icon: Icon(Icons.apps_rounded)),
              Tab(text: 'Endpoints', icon: Icon(Icons.api_rounded)),
              Tab(text: 'Features', icon: Icon(Icons.toggle_on_rounded)),
              Tab(text: 'Lifecycle', icon: Icon(Icons.published_with_changes_rounded)),
              Tab(text: 'Tickets 🎟', icon: Icon(Icons.confirmation_number_rounded)),
              Tab(text: 'Language', icon: Icon(Icons.translate_rounded)),
              Tab(text: 'Audit', icon: Icon(Icons.history_edu_rounded)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _TabWrapper(child: RoleEntryForm()),
            _TabWrapper(child: ModuleEntryForm()),
            _TabWrapper(child: AppEntryForm()),
            _TabWrapper(child: ApiEntryForm()),
            _TabWrapper(child: FeatureEntryForm()),
            _TabWrapper(child: LifecycleGovernanceForm()),
            _TabWrapper(
              child: Column(
                children: [
                  CorrectionTicketForm(),
                  SizedBox(height: 32),
                  TicketListView(),
                ],
              ),
            ),
            _TabWrapper(child: LanguageEntryForm()),
            _TabWrapper(child: AuditLogView()),
          ],
        ),
      ),
    );
  }
}

class _TabWrapper extends StatelessWidget {
  final Widget child;
  const _TabWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: child,
    );
  }
}

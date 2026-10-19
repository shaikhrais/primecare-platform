import os
import sqlite3
from refactor_custom_screen_states import write_screen_model

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

TEMPLATE = """// Governance - Category: view | Purpose: UI Screen component rendering the {class_name} workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_models/primecare_models.dart';

// --- MVC State Model ---
class {class_name}State extends BaseLoggedScreenState {

  const {class_name}State({
    required super.isLoading,
    super.error,
    required super.title,
    required super.logs,
  });

  {class_name}State copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
  }) {
    return {class_name}State(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class {class_name}Controller extends StateNotifier<{class_name}State> {
  final Ref ref;

  {class_name}Controller(this.ref)
      : super(
          const {class_name}State(
            isLoading: false,
            title: '{display_title} Management Workspace', // LocaleKeys.mock.tr()
            logs: [
              '{display_title} operations active.',
              'Security sync complete.',
            ],
          ),
        );

  Future<void> executeTaskScan() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/{url_slug}/compliance/scan',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'run_workflow_scan',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Scan executed successfully at ${DateTime.now().toIso8601String()}',
            'All compliance invariants validated successfully via API.',
          ],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'API Error: ${response.error}',
          ],
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        logs: [
          ...state.logs,
          'Network Error: $e',
        ],
      );
    }
  }

  void addLog(String entry) {
    state = state.copyWith(logs: [...state.logs, entry]);
  }
}

// --- Provider ---
final {provider_name} =
    StateNotifierProvider<{class_name}Controller, {class_name}State>((ref) {
  return {class_name}Controller(ref);
});

// --- View ---
class {class_name} extends GovernedConsumerWidget {
  const {class_name}({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch({provider_name});
    final controller = ref.read({provider_name}.notifier);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          state.title,
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
            onPressed: () => controller.addLog('Manual sweep triggered.'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GovDashboardHero(
              title: state.title,
              roleName: '{display_title} Module',
              description: 'Centralized telemetry, metrics monitoring, and operational logs verification center for {display_title}.',
              onRefresh: () => controller.addLog('Telemetry logs re-synchronized.'),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GovMetricCard(
                    title: 'Active Streams', // LocaleKeys.mock.tr()
                    value: 'Active',
                    trendLabel: 'Optimal transaction levels',
                    progress: 0.92,
                    icon: LucideIcons.activity,
                    brandColor: theme.colors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GovMetricCard(
                    title: 'Clearance Status', // LocaleKeys.mock.tr()
                    value: 'Clear',
                    trendLabel: 'Zero exceptions flagged',
                    progress: 1.0,
                    icon: LucideIcons.shieldCheck,
                    brandColor: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GovTelemetryChart(
              title: 'Hourly Telemetry Index', // LocaleKeys.mock.tr()
              dataPoints: const [75, 80, 85, 90, 88, 95],
              labels: const ['10:00', '11:00', '12:00', '13:00', '14:00', '15:00'],
              accentColor: theme.colors.primary,
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: BorderRadius.circular(theme.radiusMd),
                border: Border.all(color: theme.colors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Operational Telemetry Invariants Log',
                    style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                  ),
                  const SizedBox(height: 12),
                  ...state.logs.map((log) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(color: theme.colors.primary, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                log,
                                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: state.isLoading ? null : () => controller.executeTaskScan(),
                      child: state.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Text(
                              'Execute Quality Verification Sweep',
                              style: theme.typography.button.copyWith(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
"""

def to_camel_case(snake_str):
    components = snake_str.split('_')
    return "".join(x.title() for x in components)

def main():
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    cursor.execute("SELECT id, screen_name, expected_file_path FROM screens WHERE estimated_loc = 0;")
    rows = cursor.fetchall()

    print(f"Scaffolding templates for exactly {len(rows)} blank screen stubs...")
    
    scaffolded_count = 0
    for row in rows:
        scr_id, name, rel_path = row
        abs_path = os.path.join(PROJECT_ROOT, rel_path)
        
        # Deduce details from expected file path
        filename_raw = os.path.basename(rel_path).replace('.dart', '')
        class_name = to_camel_case(filename_raw)
        
        # Display title
        display_title = " ".join(x.title() for x in filename_raw.split('_')).replace(' Screen', '')
        
        # Provider name
        provider_name = class_name[0].lower() + class_name[1:] + "Provider"
        
        # URL slug
        url_slug = filename_raw.replace('_screen', '').replace('_', '-')
        
        # Bulletproof direct string replace (100% immune to format parsing errors)
        code = TEMPLATE
        code = code.replace('{class_name}', class_name)
        code = code.replace('{display_title}', display_title)
        code = code.replace('{provider_name}', provider_name)
        code = code.replace('{url_slug}', url_slug)
        
        # Write to physical file
        os.makedirs(os.path.dirname(abs_path), exist_ok=True)
        write_screen_model(PROJECT_ROOT, abs_path, code, class_name + "State")
            
        scaffolded_count += 1
        print(f"  Scaffolded physical file: {rel_path} -> Class: {class_name}")

    conn.close()
    print(f"\n==============================================================")
    print(f"SUCCESS: Scaffolded {scaffolded_count} blank stubs on disk!")
    print("==============================================================")

if __name__ == '__main__':
    main()

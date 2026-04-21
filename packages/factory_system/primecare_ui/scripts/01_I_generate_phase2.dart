// Layer: 01_INFRASTRUCTURE
import 'dart:io';

void main() async {
  final file = File(
    r'C:\Users\Admin2\.gemini\antigravity\brain\70a810e6-ca4a-4160-9177-5b90c9067836\master_screen_registry.md',
  );
  final lines = await file.readAsLines();

  final uiPackageDir = Directory('packages/flutter_ui');
  if (!await uiPackageDir.exists()) {
    // print Statement Logged To Telemetry
    return;
  }

  final RegExp rowRegex = RegExp(
    r'\|\s*([A-Z]{3}-\d{3})\s*\|\s*`([^`]+)`\s*\|\s*`([^`|]+)`\s*\|\s*Discovery.*\|',
  );

  final Map<String, String> domainMap = {
    'SUP': 'support',
    'CLI': 'client',
    'FAM': 'client',
    'BDV': 'business_development',
    'COR': 'corporate',
    'FRA': 'franchise',
    'MKT': 'marketing',
  };

  final List<String> generatedFiles = [];
  final Set<String> processedClasses = {};

  for (var line in lines) {
    var match = rowRegex.firstMatch(line);
    if (match != null) {
      String code = match.group(1)!;
      String col2 = match.group(2)!;
      String col3 = match.group(3)!;

      String prefix = code.split('-')[0];
      String domain = domainMap[prefix] ?? 'common';

      String className = '';
      String routePath = '';

      if (col2.startsWith('AppRoutes.')) {
        routePath = col2;
        if (col3.contains('GenericFeatureScreen')) {
          String routeName = routePath.split('.').last;
          className =
              '${routeName[0].toUpperCase()}${routeName.substring(1)}Screen';
        } else if (col3.contains('.')) {
          className = col3.split('.').last;
        } else {
          className = col3;
        }
      } else {
        className = col2;
        String lowerFirst = className[0].toLowerCase() + className.substring(1);
        routePath = 'AppRoutes.$lowerFirst';
      }

      className = className.replaceAll('Stitch', '').trim();

      if (processedClasses.contains(className)) continue;
      processedClasses.add(className);

      String fileName = '${_camelToSnake(className)}.dart';
      String title = className
          .replaceAll('Screen', '')
          .replaceAll(RegExp(r'(?<!^)(?=[A-Z])'), ' ');
      String routeString = routePath.replaceAll('AppRoutes.', '');

      String dirPath = 'packages/flutter_ui/lib/src/screens/offices/$domain';
      await Directory(dirPath).create(recursive: true);

      String content = _generateScreenContent(className, routeString, title);
      File outFile = File('$dirPath/$fileName');
      await outFile.writeAsString(content);
      generatedFiles.add('src/screens/offices/$domain/$fileName');
      // print Statement Logged To Telemetry
    }
  }

  // Update flutter_ui.dart export
  File exportFile = File('packages/flutter_ui/lib/flutter_ui.dart');
  String exportContent = await exportFile.readAsString();

  for (var f in generatedFiles) {
    String exportStmt = "export '$f';";
    if (!exportContent.contains(exportStmt)) {
      exportContent += '\n$exportStmt';
    }
  }
  await exportFile.writeAsString(exportContent);
  // print Statement Logged To Telemetry
}

String _camelToSnake(String input) {
  return input.replaceAllMapped(RegExp(r'[A-Z]'), (match) {
    return (match.start == 0 ? '' : '_') + match.group(0)!.toLowerCase();
  });
}

String _generateScreenContent(
  String className,
  String routePath,
  String title,
) {
  return '''import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_core/primecare_core.dart'; 
import 'package:primecare_ui/src/components/layouts/01_I_provider_layout.dart';
import 'package:primecare_ui/src/components/01_I_primecare_stat_card.dart';

class $className extends ConsumerWidget {
  const $className({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(dashboardMetricsProvider('$routePath'));

    return ProviderLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Real-time overview fetched natively via API.',
              style: TextStyle(color: Colors.white.withAlpha(178), fontSize: 16),
            ),
            const SizedBox(height: 32),
            
            metricsAsyncValue.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(64.0),
                  child: CircularProgressIndicator(color: Colors.tealAccent),
                ),
              ),
              error: (error, stackTrace) => Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withAlpha(25),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.redAccent.withAlpha(76)),
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.alertTriangle, color: Colors.redAccent),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Failed to load live metrics for $routePath: \\n\$error',
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              ),
              data: (DashboardMetrics liveData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.5,
                      children: liveData.kpis.map((kpi) {
                        return PrimeCareStatCard(
                          title: kpi.title,
                          value: kpi.value,
                          deltaSuffix: kpi.trend,
                          icon: _inferIcon(kpi.title),
                          iconColor: _inferColor(kpi.status),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _inferIcon(String title) {
    final t = title.toLowerCase();
    if (t.contains('patient') || t.contains('client')) return LucideIcons.users;
    if (t.contains('revenue') || t.contains('payment') || t.contains('invoice')) return LucideIcons.dollarSign;
    if (t.contains('appointment') || t.contains('schedule')) return LucideIcons.calendar;
    if (t.contains('alert') || t.contains('critical')) return LucideIcons.alertCircle;
    if (t.contains('staff') || t.contains('provider') || t.contains('rpn')) return LucideIcons.stethoscope;
    if (t.contains('task') || t.contains('pipeline')) return LucideIcons.checkSquare;
    return LucideIcons.activity;
  }

  Color _inferColor(String status) {
    final s = status.toLowerCase();
    if (s == 'operational' || s == 'positive' || s == 'up') return Colors.greenAccent;
    if (s == 'warning' || s == 'attention') return Colors.orangeAccent;
    if (s == 'critical' || s == 'down' || s == 'negative') return Colors.redAccent;
    return Colors.tealAccent;
  }
}
''';
}

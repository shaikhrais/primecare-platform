import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/services/deployment_sync_service.dart';
import '../../../../core/database/governance_database.dart';

// State providers for interactive filtering and drilldown
final selectedDeploymentProvider = StateProvider<String?>((ref) => null);
final selectedScreenIndexProvider = StateProvider<int>((ref) => 0);
final languageSimulationProvider = StateProvider<String>((ref) => 'en');
final screenSearchQueryProvider = StateProvider<String>((ref) => '');

// Localized translation values loader provider
final localizationBundleProvider = FutureProvider<Map<String, Set<String>>>((ref) async {
  final Map<String, Set<String>> bundles = {
    'en': {},
    'es': {},
    'fr': {},
  };

  for (final lang in ['en', 'es', 'fr']) {
    try {
      final String jsonStr = await rootBundle.loadString('assets/translations/$lang.json');
      final Map<String, dynamic> data = jsonDecode(jsonStr);
      
      void flatten(Map<String, dynamic> map) {
        map.forEach((k, v) {
          if (v is Map<String, dynamic>) {
            flatten(v);
          } else if (v is String) {
            bundles[lang]!.add(v.toLowerCase().trim());
          }
        });
      }
      flatten(data);
    } catch (_) {
      // Fallback in case translations are not found
    }
  }
  return bundles;
});

class ScreenStatusScreen extends ConsumerWidget {
  const ScreenStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deploymentsState = ref.watch(localDeploymentsProvider);
    final search = ref.watch(screenSearchQueryProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
            ],
          ),
        ),
        child: SafeArea(
          child: deploymentsState.when(
            data: (deployments) {
              if (deployments.isEmpty) {
                return const Center(
                  child: EmptyState(
                    title: 'No SQLite Deployment Data found',
                    subtitle: 'Run post-deployment E2E scans to seed data.',
                    icon: LucideIcons.database,
                  ),
                );
              }

              // Auto-select first deployment if none selected
              final selectedDepId = ref.watch(selectedDeploymentProvider) ?? deployments.first.id;
              final selectedDep = deployments.firstWhere(
                (d) => d.id == selectedDepId,
                orElse: () => deployments.first,
              );

              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- LEFT COLUMN: Screens & App List ---
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Theme.of(context).dividerColor.withOpacity(0.12),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLeftHeader(context, ref, deployments, selectedDepId),
                          _buildSearchField(context, ref, search),
                          Expanded(
                            child: Consumer(
                              builder: (context, ref, child) {
                                final screensState = ref.watch(localScreenDetailsProvider(selectedDepId));
                                return screensState.when(
                                  data: (screens) {
                                    final filtered = screens.where((s) =>
                                        s.screenName.toLowerCase().contains(search.toLowerCase()) ||
                                        (s.labels ?? '').toLowerCase().contains(search.toLowerCase())
                                    ).toList();

                                    if (filtered.isEmpty) {
                                      return const Center(
                                        child: Text('No screens matched search filter.'),
                                      );
                                    }

                                    return ListView.builder(
                                      itemCount: filtered.length,
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      itemBuilder: (context, index) {
                                        final screen = filtered[index];
                                        final selectedIndex = ref.watch(selectedScreenIndexProvider);
                                        final isSelected = selectedIndex == index;

                                        final List<dynamic> labels = jsonDecode(screen.labels ?? '[]');
                                        final List<dynamic> textElements = jsonDecode(screen.textElements ?? '[]');
                                        
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Card(
                                            elevation: isSelected ? 4 : 0.5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              side: BorderSide(
                                                color: isSelected
                                                    ? Theme.of(context).colorScheme.primary
                                                    : Colors.transparent,
                                                width: 1.5,
                                              ),
                                            ),
                                            child: ListTile(
                                              selected: isSelected,
                                              onTap: () {
                                                ref.read(selectedScreenIndexProvider.notifier).state = index;
                                              },
                                              leading: CircleAvatar(
                                                backgroundColor: isSelected
                                                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                                                    : Theme.of(context).colorScheme.secondary.withOpacity(0.06),
                                                child: Icon(
                                                  LucideIcons.monitor,
                                                  size: 18,
                                                  color: isSelected
                                                      ? Theme.of(context).colorScheme.primary
                                                      : Theme.of(context).colorScheme.secondary,
                                                ),
                                              ),
                                              title: Text(
                                                screen.screenName,
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              subtitle: Text(
                                                '${labels.length} Buttons | ${textElements.length} Text Blocks',
                                                style: Theme.of(context).textTheme.bodySmall,
                                              ),
                                              trailing: Icon(
                                                LucideIcons.chevronRight,
                                                size: 16,
                                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  loading: () => const Center(child: CircularProgressIndicator()),
                                  error: (err, _) => Center(child: Text('Error: $err')),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- RIGHT COLUMN: Deep Details tab bar & compliance analysis ---
                  Expanded(
                    flex: 6,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final screensState = ref.watch(localScreenDetailsProvider(selectedDepId));
                        return screensState.when(
                          data: (screens) {
                            if (screens.isEmpty) {
                              return const Center(child: Text('No screen detail logs loaded.'));
                            }
                            final activeIndex = ref.watch(selectedScreenIndexProvider);
                            // Bounds safety check
                            final safeIndex = activeIndex >= screens.length ? 0 : activeIndex;
                            final activeScreen = screens[safeIndex];

                            return _buildDetailPane(context, ref, selectedDep, activeScreen);
                          },
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (err, _) => Center(child: Text('Error: $err')),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Synchronizing deep screen scans in local SQLite database...'),
                ],
              ),
            ),
            error: (error, stack) => Center(child: Text('Error loading features: $error')),
          ),
        ),
      ),
    );
  }

  Widget _buildLeftHeader(BuildContext context, WidgetRef ref, List<PlatformDeployment> deployments, String? selectedDepId) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.shieldAlert, color: Colors.indigo, size: 28),
              const SizedBox(width: 8),
              Text(
                'Platform UI Governance',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Offline SQLite Registry Scrapes & i18n Auditing',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: selectedDepId,
            decoration: InputDecoration(
              labelText: 'Target Application Module',
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            items: deployments.map((d) {
              return DropdownMenuItem<String>(
                value: d.id,
                child: Text(d.appName.replaceAll('_', ' ').toUpperCase()),
              );
            }).toList(),
            onChanged: (val) {
              ref.read(selectedDeploymentProvider.notifier).state = val;
              ref.read(selectedScreenIndexProvider.notifier).state = 0;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context, WidgetRef ref, String query) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, bottom: 12),
      child: TextFormField(
        initialValue: query,
        onChanged: (val) => ref.read(screenSearchQueryProvider.notifier).state = val,
        decoration: InputDecoration(
          hintText: 'Search screen name or labels...',
          prefixIcon: const Icon(LucideIcons.search, size: 18),
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Theme.of(context).cardColor,
        ),
      ),
    );
  }

  Widget _buildDetailPane(BuildContext context, WidgetRef ref, PlatformDeployment dep, PlatformScreenDetail screen) {
    final List<String> labels = List<String>.from(jsonDecode(screen.labels ?? '[]'));
    final List<String> textElements = List<String>.from(jsonDecode(screen.textElements ?? '[]'));
    final List<String> components = List<String>.from(jsonDecode(screen.components ?? '[]'));
    final Map<String, dynamic> rawMetrics = jsonDecode(screen.rawMetrics ?? '{}');

    final int buttonsCount = rawMetrics['buttonsCount'] ?? 0;
    final bool riverpodWired = rawMetrics['riverpodWired'] ?? false;
    final bool hasController = rawMetrics['hasController'] ?? false;

    return DefaultTabController(
      length: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Screen Header details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      screen.screenName,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Module: ${dep.appName.toUpperCase()}  |  Language: ${screen.language.toUpperCase()}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: dep.verified
                        ? Colors.emerald.withOpacity(0.12)
                        : Colors.orange.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        dep.verified ? LucideIcons.checkCircle : LucideIcons.alertTriangle,
                        color: dep.verified ? Colors.emerald : Colors.orange,
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        dep.verified ? 'VERIFIED' : 'PENDING',
                        style: TextStyle(
                          color: dep.verified ? Colors.emerald : Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Quick Stats Row
            Row(
              children: [
                _buildQuickStatCard(context, '$buttonsCount', 'Interactive Buttons', LucideIcons.mousePointerClick, Colors.blue),
                const SizedBox(width: 12),
                _buildQuickStatCard(
                  context,
                  riverpodWired ? 'ACTIVE' : 'NONE',
                  'Riverpod Bindings',
                  LucideIcons.refreshCw,
                  riverpodWired ? Colors.purple : Colors.grey,
                ),
                const SizedBox(width: 12),
                _buildQuickStatCard(
                  context,
                  hasController ? 'WIRED' : 'EMPTY',
                  'Controller Service',
                  LucideIcons.cpu,
                  hasController ? Colors.indigo : Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Tab bar
            const TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: [
                Tab(text: 'Buttons & Labels'),
                Tab(text: 'Text Strings'),
                Tab(text: 'Child Components'),
                Tab(text: 'i18n Compliance'),
              ],
            ),
            const SizedBox(height: 16),

            // Tab content
            Expanded(
              child: TabBarView(
                children: [
                  // Tab 1: Buttons
                  _buildListTab(
                    context,
                    labels,
                    'No action labels crawled in this screen code.',
                    LucideIcons.mousePointerClick,
                    Colors.blue,
                  ),
                  // Tab 2: Text Strings
                  _buildListTab(
                    context,
                    textElements,
                    'No general text literals scraped in this screen code.',
                    LucideIcons.text,
                    Colors.green,
                  ),
                  // Tab 3: Child Components
                  _buildListTab(
                    context,
                    components,
                    'No custom child components identified.',
                    LucideIcons.package,
                    Colors.purple,
                  ),
                  // Tab 4: i18n compliance tester
                  _buildI18nComplianceTab(context, ref, textElements),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatCard(BuildContext context, String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: color.withOpacity(0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: color.withOpacity(0.15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: color),
                    ),
                    Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTab(BuildContext context, List<String> items, String emptyMessage, IconData icon, Color color) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Theme.of(context).disabledColor, size: 48),
            const SizedBox(height: 12),
            Text(emptyMessage),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0.2,
          margin: const EdgeInsets.only(bottom: 6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: color, size: 16),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    items[index],
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildI18nComplianceTab(BuildContext context, WidgetRef ref, List<String> elements) {
    if (elements.isEmpty) {
      return const Center(child: Text('No strings available for translation compliance checking.'));
    }

    final localizationBundleState = ref.watch(localizationBundleProvider);
    final activeLang = ref.watch(languageSimulationProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Lang Selection row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Dynamic Language Tester:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                _buildLangButton(ref, 'en', '🇺🇸 English', activeLang),
                const SizedBox(width: 8),
                _buildLangButton(ref, 'es', '🇪🇸 Spanish', activeLang),
                const SizedBox(width: 8),
                _buildLangButton(ref, 'fr', '🇫🇷 French', activeLang),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Compliance output list
        Expanded(
          child: localizationBundleState.when(
            data: (bundles) {
              final activeSet = bundles[activeLang] ?? {};
              
              return ListView.builder(
                itemCount: elements.length,
                itemBuilder: (context, index) {
                  final str = elements[index];
                  final cleanStr = str.toLowerCase().trim();
                  // Check compliance: does it exist in our flat localization set?
                  final bool isLocalized = activeSet.contains(cleanStr);

                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: isLocalized
                            ? Colors.emerald.withOpacity(0.2)
                            : Colors.orange.withOpacity(0.2),
                      ),
                    ),
                    color: isLocalized
                        ? Colors.emerald.withOpacity(0.02)
                        : Colors.orange.withOpacity(0.02),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(
                            isLocalized ? LucideIcons.checkCircle : LucideIcons.alertCircle,
                            color: isLocalized ? Colors.emerald : Colors.orange,
                            size: 16,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  str,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  isLocalized
                                      ? '✅ Compliant: Verified match in translations bundle.'
                                      : '⚠️ Literal Text: Hardcoded string detected. Add to translations.',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isLocalized ? Colors.emerald : Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('Error checking bundles: $err')),
          ),
        ),
      ],
    );
  }

  Widget _buildLangButton(WidgetRef ref, String langCode, String label, String active) {
    final bool isSelected = active == langCode;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          ref.read(languageSimulationProvider.notifier).state = langCode;
        }
      },
    );
  }
}

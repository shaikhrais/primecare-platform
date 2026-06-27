import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_ui/primecare_ui.dart';

/// Admin screen representing the Role Screen Carousel system.
class AdminRoleCarouselScreen extends ConsumerStatefulWidget {
  const AdminRoleCarouselScreen({super.key});

  @override
  ConsumerState<AdminRoleCarouselScreen> createState() => _AdminRoleCarouselScreenState();
}

class _AdminRoleCarouselScreenState extends ConsumerState<AdminRoleCarouselScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedRoleFilter = 'All'; // 'All', or specific roleKey
  bool _onlyIncomplete = false;
  bool _onlyProductionReady = false;
  bool _onlyFalseProgress = false;

  List<ScreenHealthStatus> _allScreens = [];
  bool _isLoading = false;

  // Map to hold ScrollControllers for each role horizontal list
  final Map<String, ScrollController> _scrollControllers = {};

  @override
  void initState() {
    super.initState();
    _loadScreens();
  }

  void _loadScreens() {
    setState(() {
      _isLoading = true;
    });
    try {
      final screens = loadAllScreensFromDb();
      setState(() {
        _allScreens = screens;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading screens for Role Carousel: $e');
      setState(() {
        _allScreens = screenHealthRegistry.values.toList();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    for (final controller in _scrollControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  ScrollController _getScrollController(String roleKey) {
    if (!_scrollControllers.containsKey(roleKey)) {
      _scrollControllers[roleKey] = ScrollController();
    }
    return _scrollControllers[roleKey]!;
  }

  void _scrollCarousel(String roleKey, bool next) {
    final controller = _getScrollController(roleKey);
    if (controller.hasClients) {
      final offset = controller.offset;
      final maxScroll = controller.position.maxScrollExtent;
      const cardWidth = 350.0 + 16.0; // Card width + spacing
      double target = next ? offset + cardWidth : offset - cardWidth;
      target = target.clamp(0.0, maxScroll);
      controller.animateTo(
        target,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Apply Search and Filters
    final filteredScreens = _allScreens.where((screen) {
      final query = _searchQuery.toLowerCase().trim();
      final matchesQuery = query.isEmpty ||
          screen.screenName.toLowerCase().contains(query) ||
          screen.routePath.toLowerCase().contains(query) ||
          (screen.roleName?.toLowerCase().contains(query) ?? false) ||
          (screen.roleKey?.toLowerCase().contains(query) ?? false);

      final matchesRole = _selectedRoleFilter == 'All' || screen.roleKey == _selectedRoleFilter;

      final matchesIncomplete = !_onlyIncomplete || (!screen.productionReady || screen.progressPercent < 100);
      final matchesProdReady = !_onlyProductionReady || screen.productionReady;
      final matchesFalseProgress = !_onlyFalseProgress || screen.falseProgress;

      return matchesQuery && matchesRole && matchesIncomplete && matchesProdReady && matchesFalseProgress;
    }).toList();

    // Group filtered screens by Role
    final Map<String, List<ScreenHealthStatus>> groupedScreens = {};
    final Map<String, String> roleNames = {};
    final Map<String, String> roleCategories = {};

    for (final screen in filteredScreens) {
      final rkey = screen.roleKey ?? 'unassigned';
      final rname = screen.roleName ?? 'Unassigned Roles';
      final rcat = screen.roleCategory ?? 'common';

      roleNames[rkey] = rname;
      roleCategories[rkey] = rcat;

      if (!groupedScreens.containsKey(rkey)) {
        groupedScreens[rkey] = [];
      }
      groupedScreens[rkey]!.add(screen);
    }

    // Sort roles by total screens in descending order
    final sortedRoleKeys = groupedScreens.keys.toList()
      ..sort((a, b) => groupedScreens[b]!.length.compareTo(groupedScreens[a]!.length));

    // Get list of unique roles for dropdown
    final Map<String, String> allRolesList = {};
    for (final s in _allScreens) {
      if (s.roleKey != null && s.roleName != null) {
        allRolesList[s.roleKey!] = s.roleName!;
      }
    }
    final sortedAllRoles = allRolesList.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    // Calculate Top KPI stats (on all screens or filtered screens? The prompt says "For every role calculate..." and "Show KPI summary cards at top of page". We show overall registry KPI summaries)
    final totalScreensCount = _allScreens.length;
    final prodReadyCount = _allScreens.where((s) => s.productionReady).length;
    final incompleteCount = _allScreens.where((s) => !s.productionReady || s.progressPercent < 100).length;
    final falseProgressCount = _allScreens.where((s) => s.falseProgress).length;
    final zeroInteractionCount = _allScreens.where((s) => s.screenBodyTotalInteractions == 0).length;
    final avgProgress = totalScreensCount > 0
        ? _allScreens.fold<int>(0, (sum, s) => sum + s.progressPercent) / totalScreensCount
        : 0.0;
    final avgInteractive = totalScreensCount > 0
        ? _allScreens.fold<int>(0, (sum, s) => sum + s.screenBodyTotalInteractions) / totalScreensCount
        : 0.0;
    final needingReviewCount = _allScreens.where((s) => s.needsReview).length;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header title
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Role Screen Carousel Audits',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Browse and audit high-fidelity user roles, screen completion metrics, and documentation alignment.',
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: _loadScreens,
                  icon: const Icon(LucideIcons.refreshCw, size: 16),
                  label: const Text('Reload Database'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),

          // Part 3: KPI Dashboard summary panels
          _buildKpiHeader(
            theme,
            isDark: isDark,
            total: totalScreensCount,
            prodReady: prodReadyCount,
            incomplete: incompleteCount,
            falseProgress: falseProgressCount,
            zeroInteraction: zeroInteractionCount,
            avgProgress: avgProgress,
            avgInteractive: avgInteractive,
            needingReview: needingReviewCount,
          ),

          // Filters Bar
          _buildFilterBar(theme, sortedAllRoles),

          // Main Carousels List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredScreens.isEmpty
                    ? _buildEmptyState(theme)
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        itemCount: sortedRoleKeys.length,
                        itemBuilder: (context, index) {
                          final rkey = sortedRoleKeys[index];
                          final screensInRole = groupedScreens[rkey]!;
                          final rname = roleNames[rkey]!;
                          final rcat = roleCategories[rkey]!;

                          return _buildRoleCarouselSection(
                            theme,
                            isDark: isDark,
                            roleKey: rkey,
                            roleName: rname,
                            roleCategory: rcat,
                            screens: screensInRole,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpiHeader(
    ThemeData theme, {
    required bool isDark,
    required int total,
    required int prodReady,
    required int incomplete,
    required int falseProgress,
    required int zeroInteraction,
    required double avgProgress,
    required double avgInteractive,
    required int needingReview,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 1000;
          final cardWidth = isNarrow
              ? (constraints.maxWidth - 24) / 2
              : (constraints.maxWidth - 48) / 4;

          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildKpiCard(
                theme,
                title: 'Total Screens / Roles',
                value: '$total / ${150}',
                subtitle: 'Assigned and classified',
                icon: LucideIcons.layers,
                color: theme.primaryColor,
                width: cardWidth,
              ),
              _buildKpiCard(
                theme,
                title: 'Production Ready vs Incomplete',
                value: '$prodReady / $incomplete',
                subtitle: 'SLA target: 100% ready',
                icon: LucideIcons.checkCircle2,
                color: Colors.green,
                width: cardWidth,
              ),
              _buildKpiCard(
                theme,
                title: 'False Progress / Zero Interaction',
                value: '$falseProgress / $zeroInteraction',
                subtitle: 'Action required now',
                icon: LucideIcons.alertTriangle,
                color: Colors.red,
                width: cardWidth,
              ),
              _buildKpiCard(
                theme,
                title: 'Avg Progress / Interactive Objects',
                value: '${avgProgress.toStringAsFixed(1)}% / ${avgInteractive.toStringAsFixed(1)}',
                subtitle: 'Needing Review: $needingReview screens',
                icon: LucideIcons.activity,
                color: Colors.amber,
                width: cardWidth,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildKpiCard(
    ThemeData theme, {
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
    required double width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.hintColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.hintColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(ThemeData theme, List<MapEntry<String, String>> sortedAllRoles) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  // Search Input
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search roles, screens, or route paths...',
                        prefixIcon: const Icon(LucideIcons.search, size: 16),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(LucideIcons.x, size: 14),
                                onPressed: () {
                                  setState(() {
                                    _searchController.clear();
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: theme.scaffoldBackgroundColor.withValues(alpha: 0.5),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Role Dropdown
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedRoleFilter,
                          icon: const Icon(LucideIcons.chevronDown, size: 14),
                          isExpanded: true,
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedRoleFilter = newValue;
                              });
                            }
                          },
                          items: [
                            const DropdownMenuItem<String>(
                              value: 'All',
                              child: Text('All Roles Filter'),
                            ),
                            ...sortedAllRoles.map((entry) {
                              return DropdownMenuItem<String>(
                                value: entry.key,
                                child: Text(entry.value),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Filter checkboxes
              Row(
                children: [
                  Checkbox(
                    value: _onlyIncomplete,
                    onChanged: (val) {
                      setState(() {
                        _onlyIncomplete = val ?? false;
                      });
                    },
                  ),
                  const Text('Incomplete Screens Only'),
                  const SizedBox(width: 20),
                  Checkbox(
                    value: _onlyProductionReady,
                    onChanged: (val) {
                      setState(() {
                        _onlyProductionReady = val ?? false;
                      });
                    },
                  ),
                  const Text('Production Ready Only'),
                  const SizedBox(width: 20),
                  Checkbox(
                    value: _onlyFalseProgress,
                    onChanged: (val) {
                      setState(() {
                        _onlyFalseProgress = val ?? false;
                      });
                    },
                  ),
                  const Text('False Progress Only'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCarouselSection(
    ThemeData theme, {
    required bool isDark,
    required String roleKey,
    required String roleName,
    required String roleCategory,
    required List<ScreenHealthStatus> screens,
  }) {
    // Calculate completions for this role
    final total = screens.length;
    final prodReady = screens.where((s) => s.productionReady).length;
    final avgProg = total > 0
        ? screens.fold<int>(0, (sum, s) => sum + s.progressPercent) / total
        : 0.0;

    final controller = _getScrollController(roleKey);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section Title Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            roleName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: theme.dividerColor.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              roleCategory.toUpperCase(),
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: theme.hintColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Screens: $total | Production Ready: $prodReady | Avg Progress: ${avgProg.toStringAsFixed(1)}%',
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
                      ),
                    ],
                  ),
                ),
                // Slider Controls buttons
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(LucideIcons.chevronLeft),
                      onPressed: () => _scrollCarousel(roleKey, false),
                    ),
                    IconButton(
                      icon: const Icon(LucideIcons.chevronRight),
                      onPressed: () => _scrollCarousel(roleKey, true),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Horizontal Carousel list view of screen cards
          SizedBox(
            height: 380,
            child: ListView.builder(
              controller: controller,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              itemCount: screens.length,
              itemBuilder: (context, index) {
                final screen = screens[index];
                return _buildScreenCarouselCard(theme, isDark, screen);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenCarouselCard(ThemeData theme, bool isDark, ScreenHealthStatus screen) {
    final statusColor = screen.hardFail
        ? Colors.red
        : (screen.productionReady
            ? Colors.green
            : (screen.isPlaceholder ? Colors.red : Colors.amber));

    return Container(
      width: 350,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: screen.productionReady
              ? Colors.green.withValues(alpha: 0.3)
              : theme.dividerColor.withValues(alpha: 0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Screen header
            Row(
              children: [
                Expanded(
                  child: Text(
                    screen.screenName,
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    screen.hardFail
                        ? 'FAILED'
                        : (screen.productionReady ? 'PROD READY' : (screen.isPlaceholder ? 'STUB' : 'IN_DEV')),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            
            // Route info
            Text(
              screen.routePath,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
                fontSize: 11,
                color: theme.hintColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),

            const Divider(),
            const SizedBox(height: 8),

            // Metadata grid / info items
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMetaTextItem(theme, 'Component File', screen.componentFile),
                    _buildMetaTextItem(theme, 'Visual Status', screen.visualStatus ?? 'N/A'),
                    _buildMetaTextItem(theme, 'Progress', '${screen.progressPercent}%'),
                    _buildMetaTextItem(theme, 'Screen Body Interactions', '${screen.screenBodyTotalInteractions} (Btn: ${screen.screenBodyButtonCount}, Form: ${screen.screenBodyFormCount}, Filter: ${screen.screenBodyFilterCount}, Table: ${screen.screenBodyTableActionCount}, Card: ${screen.screenBodyClickableCardCount})'),
                    _buildMetaTextItem(theme, 'Global Navigation Count', '${screen.globalNavigationCount}'),
                    _buildMetaTextItem(theme, 'Interaction Status', screen.meaningfulInteractionStatus),
                    _buildMetaTextItem(theme, 'False Progress Stub', screen.falseProgress ? 'YES' : 'NO'),
                    _buildMetaTextItem(theme, 'Business Ready', screen.businessReady ? 'YES' : 'NO'),
                    _buildMetaTextItem(theme, 'Business Score', '${screen.businessWorkflowScore}'),
                    _buildMetaTextItem(theme, 'Role Expectation Score', '${screen.roleExpectationScore}'),
                    _buildMetaTextItem(theme, 'Missing Business Features', screen.missingBusinessFeatures ?? 'None'),
                    _buildMetaTextItem(theme, 'Hard Fail Workflow Audit', screen.hardFail ? 'YES - FAILED ROLE EXPECTATIONS' : 'NO'),
                    _buildMetaTextItem(theme, 'Screen Purpose', screen.screenPurpose ?? 'N/A'),
                    _buildMetaTextItem(theme, 'Primary User Goal', screen.primaryUserGoal ?? 'N/A'),
                    _buildMetaTextItem(theme, 'Expected User Actions', screen.expectedUserActions ?? 'N/A'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 10),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      try {
                        GoRouter.of(context).go(screen.routePath);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Cannot navigate: $e'), backgroundColor: Colors.red),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
                      foregroundColor: theme.primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('OPEN SCREEN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(LucideIcons.copy, size: 16),
                  tooltip: 'Copy File Path',
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: screen.componentFile));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Copied component file path to clipboard: ${screen.componentFile.split("/").last}')),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(LucideIcons.heart, size: 16),
                  tooltip: 'View Screen Health Details',
                  onPressed: () => _showHealthDetailsDialog(theme, screen),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaTextItem(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(color: theme.hintColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: theme.textTheme.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _showHealthDetailsDialog(ThemeData theme, ScreenHealthStatus screen) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(LucideIcons.heart, color: Colors.red),
              const SizedBox(width: 8),
              Text('${screen.screenName} Health'),
            ],
          ),
          content: SizedBox(
            width: 450,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDetailRow(theme, 'Route Path', screen.routePath),
                  _buildDetailRow(theme, 'Component File', screen.componentFile),
                  _buildDetailRow(theme, 'Progress', '${screen.progressPercent}% (Stage ${screen.currentStage})'),
                  _buildDetailRow(theme, 'Production Ready', screen.productionReady ? 'YES' : 'NO'),
                  _buildDetailRow(theme, 'False Progress Stub', screen.falseProgress ? 'YES' : 'NO'),
                  _buildDetailRow(theme, 'Business Ready', screen.businessReady ? 'YES' : 'NO'),
                  _buildDetailRow(theme, 'Business Score', '${screen.businessWorkflowScore}'),
                  _buildDetailRow(theme, 'Role Expectation Score', '${screen.roleExpectationScore}'),
                  _buildDetailRow(theme, 'Missing Business Features', screen.missingBusinessFeatures ?? 'None'),
                  _buildDetailRow(theme, 'Hard Fail Workflow Audit', screen.hardFail ? 'YES - FAILED ROLE EXPECTATIONS' : 'NO'),
                  _buildDetailRow(theme, 'Screen Body Interactions', 'Total: ${screen.screenBodyTotalInteractions} (Buttons: ${screen.screenBodyButtonCount}, Forms: ${screen.screenBodyFormCount}, Filters: ${screen.screenBodyFilterCount}, Tables: ${screen.screenBodyTableActionCount}, Cards: ${screen.screenBodyClickableCardCount})'),
                  _buildDetailRow(theme, 'Global Navigation Count', '${screen.globalNavigationCount}'),
                  _buildDetailRow(theme, 'Interaction Status', screen.meaningfulInteractionStatus),
                  _buildDetailRow(theme, 'Interactive Objects', 'Total: ${screen.totalInteractiveObjects} (Buttons: ${screen.buttonCount}, Fields: ${screen.formFieldCount}, Tables/Actions: ${screen.tableActionCount})'),
                  _buildDetailRow(theme, 'Screen Purpose', screen.screenPurpose ?? 'N/A'),
                  _buildDetailRow(theme, 'Primary User Goal', screen.primaryUserGoal ?? 'N/A'),
                  _buildDetailRow(theme, 'Expected User Actions', screen.expectedUserActions ?? 'N/A'),
                  _buildDetailRow(theme, 'Business Reason', screen.businessReason ?? 'N/A'),
                  const SizedBox(height: 12),
                  const Text('Missing Implementation Items:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  if (screen.missingItems.isEmpty)
                    const Text('None! Screen is fully production-ready.')
                  else
                    ...screen.missingItems.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Row(
                            children: [
                              const Icon(Icons.close, color: Colors.red, size: 14),
                              const SizedBox(width: 6),
                              Expanded(child: Text(item, style: const TextStyle(fontSize: 12))),
                            ],
                          ),
                        )),
                  const SizedBox(height: 12),
                  _buildDetailRow(theme, 'Next Suggested Action', screen.nextAction.isNotEmpty ? screen.nextAction : 'None'),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: theme.textTheme.bodyMedium,
          children: [
            TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(LucideIcons.inbox, size: 48, color: Colors.grey),
          const SizedBox(height: 12),
          Text(
            'No screens matched your criteria.',
            style: theme.textTheme.titleMedium?.copyWith(color: theme.hintColor),
          ),
        ],
      ),
    );
  }
}

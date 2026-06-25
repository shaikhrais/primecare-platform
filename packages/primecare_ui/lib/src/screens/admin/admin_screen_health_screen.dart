import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_ui/primecare_ui.dart';

/// Admin screen showing self-diagnosis health statuses for all registered screens.
class AdminScreenHealthScreen extends ConsumerStatefulWidget {
  const AdminScreenHealthScreen({super.key});

  @override
  ConsumerState<AdminScreenHealthScreen> createState() => _AdminScreenHealthScreenState();
}

class _AdminScreenHealthScreenState extends ConsumerState<AdminScreenHealthScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _statusFilter = 'All'; // 'All', 'Production', 'Development', 'Placeholder'
  String _diagnosisFilter = 'All Diagnosis'; // 'All Diagnosis', 'REPLIED_OK', 'NO_REPLY', 'ERROR', 'PARTIAL_REPLY', 'NOT_TESTED'
  int? _stageFilter;
  
  List<ScreenHealthStatus> _allScreens = [];
  bool _isLoading = false;

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
      debugPrint("Error loading screens: $e");
      setState(() {
        _allScreens = screenHealthRegistry.values.toList();
        _isLoading = false;
      });
    }
  }

  Future<void> _runAllScreenTests() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 24),
            Expanded(child: Text("Running diagnostic tests on all screens...")),
          ],
        ),
      ),
    );

    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      final updated = testAllScreenReplies();
      Navigator.of(context).pop();
      setState(() {
        _allScreens = updated;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Completed diagnostic tests on ${updated.length} screens.')),
      );
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error running tests: $e'), backgroundColor: Colors.red),
      );
    }
  }

  void _testSingleScreen(String routePath) {
    try {
      final updated = testSingleScreenReply(routePath);
      setState(() {
        final idx = _allScreens.indexWhere((s) => s.routePath == routePath);
        if (idx != -1) {
          _allScreens[idx] = updated;
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Diagnostics test completed for ${updated.screenName}: ${updated.diagnosisReplyStatus}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  void _toggleDiagnosisEnabled(String routePath, bool enabled) {
    try {
      setDiagnosisEnabled(routePath, enabled);
      setState(() {
        final idx = _allScreens.indexWhere((s) => s.routePath == routePath);
        if (idx != -1) {
          final health = _allScreens[idx];
          _allScreens[idx] = ScreenHealthStatus(
            screenName: health.screenName,
            routePath: health.routePath,
            componentFile: health.componentFile,
            currentStage: health.currentStage,
            progressPercent: health.progressPercent,
            isPlaceholder: health.isPlaceholder,
            hasRealUi: health.hasRealUi,
            hasButtons: health.hasButtons,
            hasForms: health.hasForms,
            hasTables: health.hasTables,
            hasApiCalls: health.hasApiCalls,
            hasDbConnection: health.hasDbConnection,
            hasValidation: health.hasValidation,
            hasErrorHandling: health.hasErrorHandling,
            hasLoadingState: health.hasLoadingState,
            hasEmptyState: health.hasEmptyState,
            isProductionReady: health.isProductionReady,
            missingItems: health.missingItems,
            nextAction: health.nextAction,
            lastCheckedAt: health.lastCheckedAt,
            diagnosisEnabled: enabled,
            diagnosisReplyStatus: health.diagnosisReplyStatus,
            diagnosisLastQuestion: health.diagnosisLastQuestion,
            diagnosisLastAnswer: health.diagnosisLastAnswer,
            diagnosisLastCheckedAt: health.diagnosisLastCheckedAt,
            diagnosisError: health.diagnosisError,
          );
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update: $e'), backgroundColor: Colors.red),
      );
    }
  }

  String _formatTimestamp(String timestamp) {
    try {
      final dt = DateTime.parse(timestamp);
      return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} "
          "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    } catch (_) {
      return timestamp;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Apply Search and Filters
    final filteredScreens = _allScreens.where((screen) {
      final query = _searchQuery.toLowerCase().trim();
      final matchesQuery = query.isEmpty ||
          screen.screenName.toLowerCase().contains(query) ||
          screen.routePath.toLowerCase().contains(query) ||
          screen.componentFile.toLowerCase().contains(query);

      final matchesStatus = _statusFilter == 'All' ||
          (_statusFilter == 'Production' && screen.isProductionReady) ||
          (_statusFilter == 'Development' && !screen.isProductionReady && !screen.isPlaceholder) ||
          (_statusFilter == 'Placeholder' && screen.isPlaceholder);

      final matchesStage = _stageFilter == null || screen.currentStage == _stageFilter;

      final matchesDiagnosis = _diagnosisFilter == 'All Diagnosis' ||
          screen.diagnosisReplyStatus == _diagnosisFilter;

      return matchesQuery && matchesStatus && matchesStage && matchesDiagnosis;
    }).toList();

    // Compute summary stats
    final totalCount = _allScreens.length;
    final productionCount = _allScreens.where((s) => s.isProductionReady).length;
    final placeholderCount = _allScreens.where((s) => s.isPlaceholder).length;
    final developmentCount = totalCount - productionCount - placeholderCount;
    final avgProgress = totalCount > 0
        ? (_allScreens.fold<int>(0, (sum, s) => sum + s.progressPercent) / totalCount)
        : 0.0;

    // Compute Diagnostics stats
    final enabledCount = _allScreens.where((s) => s.diagnosisEnabled).length;
    final repliedOkCount = _allScreens.where((s) => s.diagnosisReplyStatus == 'REPLIED_OK').length;
    final noReplyCount = _allScreens.where((s) => s.diagnosisReplyStatus == 'NO_REPLY').length;
    final errorCount = _allScreens.where((s) => s.diagnosisReplyStatus == 'ERROR').length;
    final partialReplyCount = _allScreens.where((s) => s.diagnosisReplyStatus == 'PARTIAL_REPLY').length;
    final notTestedCount = _allScreens.where((s) => s.diagnosisReplyStatus == 'NOT_TESTED').length;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Description and Navigation
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Self-Diagnosis Verification Registry',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Verify and test runtime responses and telemetry checks for all screens.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.hintColor,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    try {
                      GoRouter.of(context).go('/admin/role-screen-carousel');
                    } catch (e) {
                      debugPrint('Navigation error: $e');
                    }
                  },
                  icon: const Icon(LucideIcons.layers, size: 16),
                  label: const Text('View Role Carousel'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
          // Header / Stats cards
          _buildStatsHeader(
            theme,
            totalCount: totalCount,
            productionCount: productionCount,
            developmentCount: developmentCount,
            placeholderCount: placeholderCount,
            avgProgress: avgProgress,
          ),
          
          // Diagnostics Stats
          _buildDiagnosticsStats(
            theme,
            totalCount: totalCount,
            enabledCount: enabledCount,
            repliedOkCount: repliedOkCount,
            noReplyCount: noReplyCount,
            errorCount: errorCount,
            partialReplyCount: partialReplyCount,
            notTestedCount: notTestedCount,
          ),
          
          // Search & Filter Bar
          _buildFilterBar(theme),

          // Main virtualized list of screens
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredScreens.isEmpty
                    ? _buildEmptyState(theme)
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        itemCount: filteredScreens.length,
                        itemBuilder: (context, index) {
                          final screen = filteredScreens[index];
                          return _buildScreenHealthCard(theme, screen);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsHeader(
    ThemeData theme, {
    required int totalCount,
    required int productionCount,
    required int developmentCount,
    required int placeholderCount,
    required double avgProgress,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 800;
          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildStatCard(
                theme,
                title: 'Total Registry Screens',
                value: totalCount.toString(),
                icon: LucideIcons.layers,
                color: theme.primaryColor,
                width: isNarrow ? (constraints.maxWidth - 16) / 2 : (constraints.maxWidth - 48) / 4,
              ),
              _buildStatCard(
                theme,
                title: 'Production Ready',
                value: productionCount.toString(),
                subtitle: totalCount > 0 ? '${((productionCount / totalCount) * 100).toStringAsFixed(1)}% of total' : '0%',
                icon: LucideIcons.checkCircle2,
                color: Colors.green,
                width: isNarrow ? (constraints.maxWidth - 16) / 2 : (constraints.maxWidth - 48) / 4,
              ),
              _buildStatCard(
                theme,
                title: 'In Active Development',
                value: developmentCount.toString(),
                icon: LucideIcons.gitPullRequest,
                color: Colors.amber,
                width: isNarrow ? (constraints.maxWidth - 16) / 2 : (constraints.maxWidth - 48) / 4,
              ),
              _buildStatCard(
                theme,
                title: 'Remaining Placeholders',
                value: placeholderCount.toString(),
                subtitle: 'Capped at Stage 2',
                icon: LucideIcons.helpCircle,
                color: Colors.red,
                width: isNarrow ? (constraints.maxWidth - 16) / 2 : (constraints.maxWidth - 48) / 4,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDiagnosticsStats(
    ThemeData theme, {
    required int totalCount,
    required int enabledCount,
    required int repliedOkCount,
    required int noReplyCount,
    required int errorCount,
    required int partialReplyCount,
    required int notTestedCount,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 900;
          final cardWidth = isNarrow 
              ? (constraints.maxWidth - 32) / 3 
              : (constraints.maxWidth - 80) / 6;
          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildStatCard(
                theme,
                title: 'Diag Enabled',
                value: enabledCount.toString(),
                icon: LucideIcons.toggleRight,
                color: Colors.indigo,
                width: cardWidth,
              ),
              _buildStatCard(
                theme,
                title: 'Replied OK',
                value: repliedOkCount.toString(),
                icon: LucideIcons.messageSquare,
                color: Colors.green,
                width: cardWidth,
              ),
              _buildStatCard(
                theme,
                title: 'No Reply',
                value: noReplyCount.toString(),
                icon: LucideIcons.messageSquare,
                color: Colors.orange,
                width: cardWidth,
              ),
              _buildStatCard(
                theme,
                title: 'Error',
                value: errorCount.toString(),
                icon: LucideIcons.alertTriangle,
                color: Colors.red,
                width: cardWidth,
              ),
              _buildStatCard(
                theme,
                title: 'Partial Reply',
                value: partialReplyCount.toString(),
                icon: LucideIcons.helpCircle,
                color: Colors.purple,
                width: cardWidth,
              ),
              _buildStatCard(
                theme,
                title: 'Not Tested',
                value: notTestedCount.toString(),
                icon: LucideIcons.clock,
                color: Colors.grey,
                width: cardWidth,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
    ThemeData theme, {
    required String title,
    required String value,
    String? subtitle,
    required IconData icon,
    required Color color,
    required double width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
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
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.hintColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Search Input
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search screen name or route path...',
                    prefixIcon: const Icon(LucideIcons.search, size: 18),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(LucideIcons.x, size: 16),
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
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              
              // Status Filter
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _statusFilter,
                      icon: const Icon(LucideIcons.chevronDown, size: 16),
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _statusFilter = newValue;
                          });
                        }
                      },
                      items: <String>['All', 'Production', 'Development', 'Placeholder']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text('$value Status'),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Diagnostics Filter
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _diagnosisFilter,
                      icon: const Icon(LucideIcons.chevronDown, size: 16),
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _diagnosisFilter = newValue;
                          });
                        }
                      },
                      items: <String>[
                        'All Diagnosis',
                        'REPLIED_OK',
                        'NO_REPLY',
                        'ERROR',
                        'PARTIAL_REPLY',
                        'NOT_TESTED'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value == 'All Diagnosis' ? 'All Diagnosis' : 'Reply: $value'),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Action Button: Test All
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _isLoading ? null : () => _runAllScreenTests(),
                icon: const Icon(LucideIcons.playCircle, size: 18),
                label: const Text('Test All Replies'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenHealthCard(ThemeData theme, ScreenHealthStatus screen) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: screen.isProductionReady
              ? Colors.green.withValues(alpha: 0.15)
              : theme.dividerColor.withValues(alpha: 0.08),
          width: screen.isProductionReady ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.01),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          screen.screenName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        _buildStatusPill(screen),
                        const SizedBox(width: 8),
                        _buildDiagnosisReplyStatusPill(screen.diagnosisReplyStatus),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      screen.routePath,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: 'monospace',
                        color: theme.hintColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Progress Circular Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getProgressColor(screen.progressPercent).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.activity,
                      size: 14,
                      color: _getProgressColor(screen.progressPercent),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${screen.progressPercent}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: _getProgressColor(screen.progressPercent),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // New Diagnosis Details Section
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.dividerColor.withValues(alpha: 0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(LucideIcons.shieldCheck, size: 16, color: Colors.blueGrey),
                        const SizedBox(width: 8),
                        Text(
                          'Self-Diagnosis Verification',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Enabled: ',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
                        ),
                        SizedBox(
                          height: 24,
                          child: Switch(
                            value: screen.diagnosisEnabled,
                            onChanged: (bool value) {
                              _toggleDiagnosisEnabled(screen.routePath, value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (screen.diagnosisLastCheckedAt != null) ...[
                  Text(
                    'Last checked: ${_formatTimestamp(screen.diagnosisLastCheckedAt!)}',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
                  ),
                  const SizedBox(height: 8),
                ],
                if (screen.diagnosisLastQuestion != null) ...[
                  Text(
                    'Q: ${screen.diagnosisLastQuestion}',
                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
                if (screen.diagnosisLastAnswer != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'A: ${screen.diagnosisLastAnswer}',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
                  ),
                ],
                if (screen.diagnosisError != null && screen.diagnosisError!.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    'Error: ${screen.diagnosisError}',
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.red),
                  ),
                ],
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),

          // Detail metrics row
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 700;
              return isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildMissingList(theme, screen.missingItems)),
                        const SizedBox(width: 24),
                        Expanded(child: _buildNextActionCard(theme, screen.nextAction)),
                        const SizedBox(width: 16),
                        _buildAskAreYouOkButton(context, screen),
                        const SizedBox(width: 8),
                        _buildAskScreenButton(context, screen),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildMissingList(theme, screen.missingItems),
                        const SizedBox(height: 12),
                        _buildNextActionCard(theme, screen.nextAction),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(child: _buildAskAreYouOkButton(context, screen)),
                            const SizedBox(width: 8),
                            Expanded(child: _buildAskScreenButton(context, screen)),
                          ],
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPill(ScreenHealthStatus screen) {
    final bool isReady = screen.isProductionReady;
    final bool isPlaceholder = screen.isPlaceholder;

    Color bg = Colors.amber.withValues(alpha: 0.12);
    Color border = Colors.amber.withValues(alpha: 0.3);
    Color text = Colors.amber.shade800;
    String label = 'DEVELOPMENT';

    if (isReady) {
      bg = Colors.green.withValues(alpha: 0.12);
      border = Colors.green.withValues(alpha: 0.3);
      text = Colors.green.shade800;
      label = 'PRODUCTION READY';
    } else if (isPlaceholder) {
      bg = Colors.red.withValues(alpha: 0.12);
      border = Colors.red.withValues(alpha: 0.3);
      text = Colors.red.shade800;
      label = 'PLACEHOLDER';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: text,
        ),
      ),
    );
  }

  Widget _buildDiagnosisReplyStatusPill(String status) {
    Color bg = Colors.grey.withValues(alpha: 0.12);
    Color border = Colors.grey.withValues(alpha: 0.3);
    Color text = Colors.grey.shade800;

    switch (status) {
      case 'REPLIED_OK':
        bg = Colors.green.withValues(alpha: 0.12);
        border = Colors.green.withValues(alpha: 0.3);
        text = Colors.green.shade800;
        break;
      case 'ERROR':
        bg = Colors.red.withValues(alpha: 0.12);
        border = Colors.red.withValues(alpha: 0.3);
        text = Colors.red.shade800;
        break;
      case 'NO_REPLY':
        bg = Colors.orange.withValues(alpha: 0.12);
        border = Colors.orange.withValues(alpha: 0.3);
        text = Colors.orange.shade800;
        break;
      case 'PARTIAL_REPLY':
        bg = Colors.purple.withValues(alpha: 0.12);
        border = Colors.purple.withValues(alpha: 0.3);
        text = Colors.purple.shade800;
        break;
      case 'NOT_TESTED':
      default:
        bg = Colors.blueGrey.withValues(alpha: 0.12);
        border = Colors.blueGrey.withValues(alpha: 0.3);
        text = Colors.blueGrey.shade800;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: text,
        ),
      ),
    );
  }

  Widget _buildAskAreYouOkButton(BuildContext context, ScreenHealthStatus screen) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green.withValues(alpha: 0.1),
        foregroundColor: Colors.green.shade700,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: !screen.diagnosisEnabled ? null : () {
        _testSingleScreen(screen.routePath);
      },
      icon: const Icon(LucideIcons.checkSquare, size: 16),
      label: const Text('Ask Are You OK?'),
    );
  }

  Widget _buildMissingList(ThemeData theme, List<String> missing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MISSING WORK ITEMS',
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            color: theme.hintColor,
          ),
        ),
        const SizedBox(height: 8),
        if (missing.isEmpty)
          Row(
            children: [
              const Icon(LucideIcons.checkCircle, color: Colors.green, size: 14),
              const SizedBox(width: 6),
              Text(
                'Complete. Ready for deployment.',
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.green.shade700),
              ),
            ],
          )
        else
          ...missing.take(3).map(
                (m) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      const Icon(LucideIcons.minusCircle, color: Colors.amber, size: 14),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          m,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        if (missing.length > 3)
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              '+ ${missing.length - 3} more items',
              style: theme.textTheme.labelSmall?.copyWith(color: theme.hintColor),
            ),
          ),
      ],
    );
  }

  Widget _buildNextActionCard(ThemeData theme, String action) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NEXT DEV ACTION',
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            color: theme.hintColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: theme.dividerColor.withValues(alpha: 0.05)),
          ),
          child: Text(
            action.isEmpty ? 'Proceed to next stage.' : action,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAskScreenButton(BuildContext context, ScreenHealthStatus screen) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
        foregroundColor: theme.primaryColor,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        _showAskScreenDialog(context, screen);
      },
      icon: const Icon(LucideIcons.messageSquare, size: 16),
      label: const Text('Ask Screen'),
    );
  }

  void _showAskScreenDialog(BuildContext context, ScreenHealthStatus screen) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _AskScreenBottomSheet(screen: screen);
      },
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.searchX, size: 64, color: theme.hintColor),
          const SizedBox(height: 16),
          Text(
            'No matching screens found',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.hintColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Refine your query or filters and try again.',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          ),
        ],
      ),
    );
  }

  Color _getProgressColor(int percent) {
    if (percent >= 100) return Colors.green;
    if (percent >= 60) return const Color(0xFF004AC6);
    if (percent >= 30) return Colors.amber;
    return Colors.red;
  }
}

/// Dynamic Q&A modal sheet dialog where user can chat with the screen
class _AskScreenBottomSheet extends StatefulWidget {
  final ScreenHealthStatus screen;

  const _AskScreenBottomSheet({required this.screen});

  @override
  State<_AskScreenBottomSheet> createState() => _AskScreenBottomSheetState();
}

class _AskScreenBottomSheetState extends State<_AskScreenBottomSheet> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _questionController = TextEditingController();

  final List<String> _suggestedQuestions = [
    'Are you OK?',
    'What is missing?',
    'Are you production ready?',
    'Do you have API?',
    'Do you have DB connection?',
    'Do you still use mock data?',
  ];

  @override
  void initState() {
    super.initState();
    // Add welcome message from screen
    _messages.add({
      'sender': 'screen',
      'text': 'Hello! I am the ${widget.screen.screenName}. Ask me anything about my status, implementation progress, or dependencies.',
    });
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  void _sendQuestion(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'sender': 'user',
        'text': text,
      });
      _questionController.clear();
    });

    // Simulate reply from askScreen helper
    Future.delayed(const Duration(milliseconds: 300), () {
      final answer = askScreen(widget.screen.routePath, text);
      if (mounted) {
        setState(() {
          _messages.add({
            'sender': 'screen',
            'text': answer,
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.75,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header handle
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
                  child: Icon(LucideIcons.messageSquare, color: theme.primaryColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Diagnostics Chat',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.screen.screenName,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.hintColor,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.x),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const Divider(),

          // Chat messages list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['sender'] == 'user';
                return _buildChatBubble(theme, isUser: isUser, text: msg['text'] ?? '');
              },
            ),
          ),

          // Suggested Questions Chips
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _suggestedQuestions
                  .map(
                    (q) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ActionChip(
                        label: Text(q),
                        labelStyle: theme.textTheme.labelMedium?.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        backgroundColor: theme.primaryColor.withValues(alpha: 0.05),
                        side: BorderSide(color: theme.primaryColor.withValues(alpha: 0.15)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        onPressed: () => _sendQuestion(q),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          const SizedBox(height: 12),

          // Input field row
          Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, mediaQuery.viewInsets.bottom + 24),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _questionController,
                    decoration: InputDecoration(
                      hintText: 'Type your question...',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      filled: true,
                      fillColor: theme.dividerColor.withValues(alpha: 0.03),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
                      ),
                    ),
                    onSubmitted: (val) => _sendQuestion(val),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: IconButton(
                    icon: const Icon(LucideIcons.send, color: Colors.white),
                    onPressed: () => _sendQuestion(_questionController.text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ThemeData theme, {required bool isUser, required String text}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: const BoxConstraints(maxWidth: 450),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUser
              ? theme.primaryColor
              : theme.dividerColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 16),
          ),
          border: isUser
              ? null
              : Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : theme.textTheme.bodyLarge?.color,
            fontSize: 14,
            height: 1.4,
            fontWeight: isUser ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

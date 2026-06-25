import 'package:primecare_ui/primecare_ui.dart';

/// Admin screen representing the Reality Check auditing dashboard.
class AdminRealityCheckScreen extends ConsumerStatefulWidget {
  const AdminRealityCheckScreen({super.key});

  @override
  ConsumerState<AdminRealityCheckScreen> createState() => _AdminRealityCheckScreenState();
}

class _AdminRealityCheckScreenState extends ConsumerState<AdminRealityCheckScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _realityFilter = 'All'; // 'All', 'Zero Interaction', 'Low Interaction', 'Unclear Purpose', 'No User Value', 'False Progress'
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
      debugPrint('Error loading screens for Reality Check: $e');
      setState(() {
        _allScreens = screenHealthRegistry.values.toList();
        _isLoading = false;
      });
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
          (screen.screenPurpose?.toLowerCase().contains(query) ?? false);

      bool matchesFilter = true;
      if (_realityFilter == 'Zero Interaction') {
        matchesFilter = screen.totalInteractiveObjects == 0;
      } else if (_realityFilter == 'Low Interaction') {
        matchesFilter = screen.totalInteractiveObjects < 3 && screen.totalInteractiveObjects > 0;
      } else if (_realityFilter == 'Unclear Purpose') {
        matchesFilter = screen.screenPurposeStatus == 'UNCLEAR_PURPOSE';
      } else if (_realityFilter == 'No User Value') {
        matchesFilter = screen.screenPurposeStatus == 'NO_USER_VALUE';
      } else if (_realityFilter == 'False Progress') {
        matchesFilter = screen.falseProgress;
      }

      return matchesQuery && matchesFilter;
    }).toList();

    // Compute Metrics
    final totalCount = _allScreens.length;
    final zeroInteractionCount = _allScreens.where((s) => s.totalInteractiveObjects == 0).length;
    final lowInteractionCount = _allScreens.where((s) => s.totalInteractiveObjects < 3 && s.totalInteractiveObjects > 0).length;
    final clearPurposeCount = _allScreens.where((s) => s.screenPurposeStatus == 'CLEAR_PURPOSE').length;
    final unclearPurposeCount = _allScreens.where((s) => s.screenPurposeStatus == 'UNCLEAR_PURPOSE').length;
    final noUserValueCount = _allScreens.where((s) => s.screenPurposeStatus == 'NO_USER_VALUE').length;
    final falseProgressCount = _allScreens.where((s) => s.falseProgress).length;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header description
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reality Check Dashboard',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Every screen must have a clear USER PURPOSE and INTERACTION to justify its existence on the platform.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.hintColor,
                  ),
                ),
              ],
            ),
          ),

          // KPI Grid
          _buildKpiGrid(
            theme,
            totalCount: totalCount,
            zeroCount: zeroInteractionCount,
            lowCount: lowInteractionCount,
            clearCount: clearPurposeCount,
            unclearCount: unclearPurposeCount,
            noUserValueCount: noUserValueCount,
            falseCount: falseProgressCount,
          ),

          // Search and Filters bar
          _buildFilterBar(theme),

          // Main Screen List
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
                          return _buildRealityCheckCard(theme, screen);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpiGrid(
    ThemeData theme, {
    required int totalCount,
    required int zeroCount,
    required int lowCount,
    required int clearCount,
    required int unclearCount,
    required int noUserValueCount,
    required int falseCount,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 900;
          final cardWidth = isNarrow 
              ? (constraints.maxWidth - 32) / 3 
              : (constraints.maxWidth - 96) / 7;

          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildStatCard(
                theme,
                title: 'Total Screens',
                value: totalCount.toString(),
                icon: LucideIcons.layers,
                color: theme.primaryColor,
                width: cardWidth,
              ),
              _buildStatCard(
                theme,
                title: 'Zero Inter.',
                value: zeroCount.toString(),
                icon: LucideIcons.mousePointer,
                color: Colors.red,
                width: cardWidth,
              ),
              _buildStatCard(
                theme,
                title: 'Low Inter.',
                value: lowCount.toString(),
                icon: LucideIcons.activity,
                color: Colors.orange,
                width: cardWidth,
              ),
              _buildStatCard(
                theme,
                title: 'Clear Purpose',
                value: clearCount.toString(),
                icon: LucideIcons.shieldCheck,
                color: Colors.green,
                width: cardWidth,
              ),
              _buildStatCard(
                theme,
                title: 'Unclear Purp.',
                value: unclearCount.toString(),
                icon: LucideIcons.helpCircle,
                color: Colors.amber,
                width: cardWidth,
              ),
              _buildStatCard(
                theme,
                title: 'No User Value',
                value: noUserValueCount.toString(),
                icon: LucideIcons.trash2,
                color: Colors.red.shade800,
                width: cardWidth,
              ),
              _buildStatCard(
                theme,
                title: 'False Progress',
                value: falseCount.toString(),
                icon: LucideIcons.alertOctagon,
                color: Colors.purple,
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
    required IconData icon,
    required Color color,
    required double width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.hintColor,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
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
              // Search field
              Expanded(
                flex: 4,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search route, name, or purpose...',
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
                  ),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),

              // Filter Dropdown
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _realityFilter,
                      icon: const Icon(LucideIcons.chevronDown, size: 16),
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _realityFilter = newValue;
                          });
                        }
                      },
                      items: <String>[
                        'All',
                        'Zero Interaction',
                        'Low Interaction',
                        'Unclear Purpose',
                        'No User Value',
                        'False Progress'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text('$value Filter'),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Reload button
              IconButton(
                icon: const Icon(LucideIcons.refreshCw),
                onPressed: _loadScreens,
                tooltip: 'Reload database check metrics',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRealityCheckCard(ThemeData theme, ScreenHealthStatus screen) {
    final bool isZero = screen.totalInteractiveObjects == 0;
    final bool isLow = screen.totalInteractiveObjects < 3 && screen.totalInteractiveObjects > 0;
    final bool isReview = screen.needsReview;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isZero
              ? Colors.red.withValues(alpha: 0.15)
              : isLow
                  ? Colors.orange.withValues(alpha: 0.15)
                  : theme.dividerColor.withValues(alpha: 0.08),
          width: isReview ? 1.5 : 1,
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
          // Route and Title Header
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
                        _buildPurposeStatusPill(screen.screenPurposeStatus),
                        if (isReview) ...[
                          const SizedBox(width: 8),
                          _buildWarningPill(),
                        ],
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

              // Total Interactive Objects Counter Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: (isZero ? Colors.red : isLow ? Colors.orange : Colors.green).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.mousePointer,
                      size: 14,
                      color: isZero ? Colors.red : isLow ? Colors.orange : Colors.green,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${screen.totalInteractiveObjects} items',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: isZero ? Colors.red : isLow ? Colors.orange : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),

          // Interactivity Object Count Table
          _buildInteractiveCounters(theme, screen),

          const SizedBox(height: 12),

          // Screen Purpose & Value Descriptions
          _buildPurposeDetails(theme, screen),

          // Alert banner if Zero/Low Interactivity
          if (isZero) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.alertTriangle, color: Colors.red, size: 18),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'ZERO INTERACTION ALERT: Screen has no transactional value. Verify and add actions or consolidate route.',
                      style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ] else if (isLow) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.helpCircle, color: Colors.orange, size: 18),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'LOW INTERACTION WARNING: Review screen value. Less than 3 interactive objects found.',
                      style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInteractiveCounters(ThemeData theme, ScreenHealthStatus s) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        _buildCounterLabel(theme, 'Buttons', s.buttonCount),
        _buildCounterLabel(theme, 'Forms', s.formFieldCount),
        _buildCounterLabel(theme, 'Links', s.linkCount),
        _buildCounterLabel(theme, 'Table Actions', s.tableActionCount),
        _buildCounterLabel(theme, 'Filters', s.filterCount),
        _buildCounterLabel(theme, 'Navigation', s.navigationActionCount),
      ],
    );
  }

  Widget _buildCounterLabel(ThemeData theme, String label, int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.05)),
      ),
      child: Text(
        '$label: $count',
        style: theme.textTheme.labelMedium?.copyWith(
          fontWeight: count > 0 ? FontWeight.bold : FontWeight.normal,
          color: count > 0 ? theme.primaryColor : theme.hintColor,
        ),
      ),
    );
  }

  Widget _buildPurposeDetails(ThemeData theme, ScreenHealthStatus s) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPurposeField(theme, 'Screen Purpose', s.screenPurpose ?? 'Unchecked'),
          const SizedBox(height: 6),
          _buildPurposeField(theme, 'Primary User Goal', s.primaryUserGoal ?? 'Unchecked'),
          const SizedBox(height: 6),
          _buildPurposeField(theme, 'Expected Actions', s.expectedUserActions ?? 'Unchecked'),
          const SizedBox(height: 6),
          _buildPurposeField(theme, 'Business Reason', s.businessReason ?? 'Unchecked'),
        ],
      ),
    );
  }

  Widget _buildPurposeField(ThemeData theme, String fieldName, String fieldValue) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            fieldName,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor.withValues(alpha: 0.8),
            ),
          ),
        ),
        Expanded(
          child: Text(
            fieldValue,
            style: theme.textTheme.bodySmall?.copyWith(color: theme.textTheme.bodyMedium?.color),
          ),
        ),
      ],
    );
  }

  Widget _buildPurposeStatusPill(String status) {
    Color bg = Colors.grey.withValues(alpha: 0.12);
    Color border = Colors.grey.withValues(alpha: 0.3);
    Color text = Colors.grey.shade800;

    switch (status) {
      case 'CLEAR_PURPOSE':
        bg = Colors.green.withValues(alpha: 0.12);
        border = Colors.green.withValues(alpha: 0.3);
        text = Colors.green.shade800;
        break;
      case 'UNCLEAR_PURPOSE':
        bg = Colors.amber.withValues(alpha: 0.12);
        border = Colors.amber.withValues(alpha: 0.3);
        text = Colors.amber.shade800;
        break;
      case 'DUPLICATE_PURPOSE':
        bg = Colors.purple.withValues(alpha: 0.12);
        border = Colors.purple.withValues(alpha: 0.3);
        text = Colors.purple.shade800;
        break;
      case 'NO_USER_VALUE':
      default:
        bg = Colors.red.withValues(alpha: 0.12);
        border = Colors.red.withValues(alpha: 0.3);
        text = Colors.red.shade800;
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
        status.replaceAll('_', ' '),
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: text,
        ),
      ),
    );
  }

  Widget _buildWarningPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: const Text(
        'NEEDS REVIEW',
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
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
}

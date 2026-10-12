import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/theme/theme_contrast.dart';

class AdminScreenshotGalleryScreen extends ConsumerStatefulWidget {
  const AdminScreenshotGalleryScreen({super.key});

  @override
  ConsumerState<AdminScreenshotGalleryScreen> createState() => _AdminScreenshotGalleryScreenState();
}

class _AdminScreenshotGalleryScreenState extends ConsumerState<AdminScreenshotGalleryScreen> {
  List<ScreenHealthStatus> _allScreens = [];
  bool _isLoading = false;
  
  // Filtering states
  String _selectedRole = 'All';
  bool _productionReadyOnly = false;
  bool _failedRenderOnly = false;
  bool _incompleteUiOnly = false;
  
  final String _projectRoot = r"C:\Users\Admin2\Documents\GitHub\primecare-platform";

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
      debugPrint('Error loading screens for Gallery: $e');
      setState(() {
        _allScreens = [];
        _isLoading = false;
      });
    }
  }

  Future<void> _openFile(String relativePath) async {
    final cleanPath = relativePath
        .replaceAll('package:primecare_ui', 'packages/primecare_ui/lib')
        .replaceAll('package:primecare_corporate', 'apps/primecare_corporate/lib');
        
    final absolutePath = osPath(cleanPath);
    final file = File(absolutePath);
    if (await file.exists()) {
      try {
        final uri = Uri.file(absolutePath);
        await launchUrl(uri);
      } catch (e) {
        debugPrint('Could not open file: $e');
      }
    }
  }

  String osPath(String path) {
    if (path.startsWith('C:') || path.startsWith('c:')) {
      return path;
    }
    return '$_projectRoot\\${path.replaceAll('/', '\\')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Extract roles for filter list
    final roles = ['All', ..._allScreens
        .map((s) => s.roleKey ?? '')
        .where((r) => r.isNotEmpty)
        .toSet()
        .toList()];

    // Apply filters
    final filtered = _allScreens.where((screen) {
      // Role filter
      if (_selectedRole != 'All' && screen.roleKey != _selectedRole) {
        return false;
      }
      // Production ready filter
      if (_productionReadyOnly && !screen.productionReady) {
        return false;
      }
      // Failed render filter
      if (_failedRenderOnly && screen.renderSuccess) {
        return false;
      }
      // Incomplete UI filter
      if (_incompleteUiOnly && screen.currentStage >= 6) {
        return false;
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [readableThemeForeground(theme.colorScheme.surface, theme.colorScheme.primary), readableThemeForeground(theme.colorScheme.surface, theme.colorScheme.primary)],
              ).createShader(bounds),
              child: const Icon(LucideIcons.image, size: 28, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Text(
              'Visual Verification Gallery',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: theme.colorScheme.onSurface,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.refreshCw),
            onPressed: _loadScreens,
            tooltip: 'Reload database screens',
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Filter Panel
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(
                right: BorderSide(
                  color: theme.colorScheme.outline,
                ),
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FILTERS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                    letterSpacing: 1.5,
                    fontSize: (theme.textTheme.bodyMedium?.fontSize ?? 14) * 12 / 14,
                  ),
                ),
                const SizedBox(height: 24),
                // Role dropdown
                Text(
                  'Role Category',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(context.theme.radiusDefault),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedRole,
                      isExpanded: true,
                      dropdownColor: theme.colorScheme.surface,
                      items: roles.map((role) {
                        return DropdownMenuItem<String>(
                          value: role,
                          child: Text(role.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _selectedRole = val;
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Switches
                _buildFilterSwitch(
                  label: 'Production Ready Only',
                  value: _productionReadyOnly,
                  onChanged: (val) {
                    setState(() {
                      _productionReadyOnly = val;
                    });
                  },
                ),
                _buildFilterSwitch(
                  label: 'Failed Render Only',
                  value: _failedRenderOnly,
                  onChanged: (val) {
                    setState(() {
                      _failedRenderOnly = val;
                    });
                  },
                ),
                _buildFilterSwitch(
                  label: 'Incomplete UI Only',
                  value: _incompleteUiOnly,
                  onChanged: (val) {
                    setState(() {
                      _incompleteUiOnly = val;
                    });
                  },
                ),
                const Spacer(),
                // Stats Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(context.theme.radiusDefault),
                    border: Border.all(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STATISTICS',
                        style: TextStyle(
                          fontSize: (theme.textTheme.bodyMedium?.fontSize ?? 14) * 11 / 14,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildStatRow('Total Screens', '${_allScreens.length}'),
                      _buildStatRow('Matched Filters', '${filtered.length}'),
                      _buildStatRow('Render Success', '${_allScreens.where((s) => s.renderSuccess).length}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Main Gallery Grid
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : filtered.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LucideIcons.searchX, size: 64, color: theme.colorScheme.onSurfaceVariant),
                            const SizedBox(height: 16),
                            Text(
                              'No matching screenshots found.',
                              style: TextStyle(
                                fontSize: (theme.textTheme.bodyMedium?.fontSize ?? 14) * 16 / 14,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(32),
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 450,
                          mainAxisSpacing: 32,
                          crossAxisSpacing: 32,
                          childAspectRatio: 0.82,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final screen = filtered[index];
                          return _buildScreenshotCard(context, screen, isDark);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSwitch({required String label, required bool value, required ValueChanged<bool> onChanged}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: (theme.textTheme.bodyMedium?.fontSize ?? 14) * 14 / 14,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String val) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 12)),
          Text(val, style: TextStyle(color: theme.colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildScreenshotCard(BuildContext context, ScreenHealthStatus screen, bool isDark) {
    final theme = Theme.of(context);
    final hasImage = screen.screenshotPath != null && screen.screenshotPath!.isNotEmpty;
    final absoluteImgPath = hasImage ? osPath(screen.screenshotPath!) : '';
    final imageFile = File(absoluteImgPath);
    final fileExists = imageFile.existsSync();

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(context.theme.radiusDefault),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: .15),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: theme.colorScheme.outline,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.theme.radiusDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Preview Header
            Expanded(
              child: Container(
                color: theme.colorScheme.surfaceContainer,
                child: fileExists
                    ? Image.file(
                        imageFile,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              screen.renderSuccess ? LucideIcons.image : LucideIcons.alertTriangle,
                              size: 48,
                              color: screen.renderSuccess ? theme.colorScheme.onSurfaceVariant : Colors.red[400],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              screen.renderSuccess ? 'Preview Image Loading' : 'Rendering Failed',
                              style: TextStyle(
                                color: screen.renderSuccess ? theme.colorScheme.onSurfaceVariant : Colors.red[400],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (screen.renderError != null && screen.renderError!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Text(
                                  screen.renderError!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: (theme.textTheme.bodyMedium?.fontSize ?? 14) * 10 / 14, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          ],
                        ),
                      ),
              ),
            ),
            // Info Body
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          screen.screenName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: (theme.textTheme.bodyMedium?.fontSize ?? 14) * 16 / 14,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      // Visual Quality Score Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.teal.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(context.theme.radiusDefault),
                        ),
                        child: Text(
                          'VISUAL_${screen.visualQualityScore}',
                          style: TextStyle(
                            color: Colors.tealAccent,
                            fontSize: (theme.textTheme.bodyMedium?.fontSize ?? 14) * 10 / 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    screen.routePath,
                    style: TextStyle(
                      fontSize: (theme.textTheme.bodyMedium?.fontSize ?? 14) * 11 / 14,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'File: ${screen.componentFile}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: (theme.textTheme.bodyMedium?.fontSize ?? 14) * 10 / 14,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Metadata Badges
                  Row(
                    children: [
                      _buildStatusChip(
                        label: screen.productionReady ? 'PROD READY' : 'INCOMPLETE',
                        color: screen.productionReady ? Colors.green : Colors.amber,
                      ),
                      const SizedBox(width: 8),
                      _buildStatusChip(
                        label: screen.hardFail ? 'NEEDS REDESIGN' : 'STABLE',
                        color: screen.hardFail ? Colors.red : Colors.blue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Actions Row
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: ElevatedButton.icon(
                      icon: const Icon(LucideIcons.externalLink, size: 14),
                      label: Text('Open Source File'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(context.theme.radiusDefault),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () => _openFile(screen.componentFile),
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

  Widget _buildStatusChip({required String label, required Color color}) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.theme.radiusDefault),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: readableThemeForeground(Color.alphaBlend(color.withValues(alpha: .1), theme.colorScheme.surface), color),
          fontSize: (theme.textTheme.bodyMedium?.fontSize ?? 14) * 9 / 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

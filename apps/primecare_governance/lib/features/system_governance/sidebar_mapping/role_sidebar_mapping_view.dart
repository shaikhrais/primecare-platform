import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/governance/role_impersonation_provider.dart';
import '../../../../core/governance/governance_provider.dart';
import '../../../../core/governance/screen_metadata.dart' as meta;

class RoleSidebarMappingView extends GovernedConsumerStatefulWidget {
  const RoleSidebarMappingView({super.key});

  @override
  ConsumerState<RoleSidebarMappingView> createState() =>
      _RoleSidebarMappingViewState();
}

class _RoleSidebarMappingViewState
    extends GovernedConsumerState<RoleSidebarMappingView> {
  String? _selectedOffice;
  String? _selectedRole;
  meta.ScreenMetadata? _selectedPreviewScreen;

  @override
  Widget buildScreen(BuildContext context) {
    final theme = context.theme;
    final govState = ref.watch(governanceProvider);
    final allScreens = govState.allScreens;

    // Group screens by office and role
    final Map<String, Map<String, List<meta.ScreenMetadata>>>
    officeRoleMapping = {};
    for (var screen in allScreens.values) {
      final office = screen.office;
      final role = screen.role;
      officeRoleMapping
          .putIfAbsent(office, () => {})
          .putIfAbsent(role, () => [])
          .add(screen);
    }

    // Set initial selection if none
    if (_selectedOffice == null && officeRoleMapping.isNotEmpty) {
      _selectedOffice = officeRoleMapping.keys.first;
      if (officeRoleMapping[_selectedOffice!]!.isNotEmpty) {
        _selectedRole = officeRoleMapping[_selectedOffice!]!.keys.first;
      }
    }

    return Container(
      color: theme.colors.surfaceContainerLowest,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Sidebar: Offices & Roles Selection
          Container(
            width: 320,
            decoration: BoxDecoration(
              color: theme.colors.surface,
              border: Border(
                right: BorderSide(color: theme.colors.outlineVariant),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(2, 0),
                ),
              ],
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                  child: Text(
                    'governance.sidebar_mapping.offices_and_roles'.tr(),
                    style: theme.typography.bodySmall.copyWith(
                      color: theme.colors.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                ...officeRoleMapping.keys.map((office) {
                  final bool isOfficeSelected = office == _selectedOffice;
                  return Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2,
                      ),
                      child: ExpansionTile(
                        initiallyExpanded: office == _selectedOffice,
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(theme.radiusLg),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(theme.radiusLg),
                        ),
                        backgroundColor: isOfficeSelected
                            ? theme.colors.primary.withValues(alpha: 0.02)
                            : null,
                        leading: Icon(
                          LucideIcons.building2,
                          size: 20,
                          color: isOfficeSelected
                              ? theme.colors.primary
                              : theme.colors.onSurfaceVariant,
                        ),
                        title: Text(
                          office.toUpperCase(),
                          style: theme.typography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: isOfficeSelected
                                ? theme.colors.primary
                                : theme.colors.onSurface,
                          ),
                        ),
                        children: officeRoleMapping[office]!.keys.map((role) {
                          final isSelected =
                              office == _selectedOffice &&
                              role == _selectedRole;
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 32,
                              right: 8,
                              bottom: 4,
                            ),
                            child: ListTile(
                              dense: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  theme.radiusMd,
                                ),
                              ),
                              leading: Icon(
                                LucideIcons.user,
                                size: 16,
                                color: isSelected
                                    ? theme.colors.primary
                                    : theme.colors.onSurfaceVariant,
                              ),
                              title: Text(
                                role,
                                style: theme.typography.bodyMedium.copyWith(
                                  color: isSelected
                                      ? theme.colors.primary
                                      : theme.colors.onSurfaceVariant,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              selected: isSelected,
                              selectedTileColor: theme.colors.primary
                                  .withValues(alpha: 0.1),
                              hoverColor: theme.colors.primary.withValues(
                                alpha: 0.05,
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedOffice = office;
                                  _selectedRole = role;
                                  _selectedPreviewScreen = null;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          // Right Content: Sidebar Preview
          Expanded(
            child: _selectedOffice == null || _selectedRole == null
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LucideIcons.layoutTemplate,
                          size: 64,
                          color: theme.colors.outline,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'governance.sidebar_mapping.select_office_role'.tr(),
                          style: theme.typography.bodyLarge,
                        ),
                      ],
                    ),
                  )
                : _buildSidebarPreview(
                    context,
                    theme,
                    _selectedOffice!,
                    _selectedRole!,
                    officeRoleMapping,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarPreview(
    BuildContext context,
    PrimeThemeData theme,
    String office,
    String role,
    Map<String, Map<String, List<meta.ScreenMetadata>>> mapping,
  ) {
    final screens = mapping[office]![role] ?? [];

    // Group by featureName (charter) to simulate sections in a sidebar
    final Map<String, List<meta.ScreenMetadata>> byFeature = {};
    for (var s in screens) {
      final feature = s.featureName;
      byFeature.putIfAbsent(feature, () => []).add(s);
    }

    return Container(
      color: theme.colors.surfaceContainerLowest,
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(theme.radiusLg),
                ),
                child: Icon(
                  LucideIcons.layoutTemplate,
                  color: theme.colors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'governance.sidebar_mapping.sidebar_preview'.tr(),
                      style: theme.typography.h2,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Office: ${office.toUpperCase()}  •  Role: $role',
                      style: theme.typography.bodyLarge.copyWith(
                        color: theme.colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              PrimeButton.primary(
                label: 'governance.sidebar_mapping.impersonate_role'.tr(),
                icon: LucideIcons.userCheck,
                onPressed: () {
                  ref
                      .read(roleImpersonationProvider.notifier)
                      .impersonate(role);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'governance.sidebar_mapping.viewing_platform_as'.tr(
                          args: [role],
                        ),
                      ),
                      backgroundColor: theme.colors.primary,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Render a simulated application frame
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(theme.radiusXl),
                border: Border.all(
                  color: theme.colors.outlineVariant,
                  width: 2,
                ),
                boxShadow: theme.shadowsSurface2,
              ),
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: [
                  // Simulated Sidebar
                  Container(
                    width: 280,
                    color: theme.colors.surface,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Brand Header
                        Container(
                          height: 64,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: theme.colors.outlineVariant,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                LucideIcons.activity,
                                color: theme.colors.primary,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'PrimeCare',
                                style: theme.typography.h3.copyWith(
                                  color: theme.colors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // User Profile Mock
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: theme.colors.primary
                                    .withValues(alpha: 0.1),
                                child: Text(
                                  role.isNotEmpty
                                      ? role.substring(0, 1).toUpperCase()
                                      : '?',
                                  style: TextStyle(
                                    color: theme.colors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      role,
                                      style: theme.typography.bodyMedium
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      office,
                                      style: theme.typography.bodySmall
                                          .copyWith(
                                            color:
                                                theme.colors.onSurfaceVariant,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Sidebar Content
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            children: [
                              ...byFeature.keys.map((feature) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        24,
                                        16,
                                        24,
                                        8,
                                      ),
                                      child: Text(
                                        feature.toUpperCase(),
                                        style: TextStyle(
                                          color: theme.colors.onSurfaceVariant,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ),
                                    ...byFeature[feature]!.map((screen) {
                                      final isSelected =
                                          _selectedPreviewScreen?.id ==
                                          screen.id;
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 2,
                                        ),
                                        child: ListTile(
                                          dense: true,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              theme.radiusMd,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 16,
                                              ),
                                          leading: Icon(
                                            screen.icon ??
                                                LucideIcons.circleDot,
                                            size: 16,
                                            color: isSelected
                                                ? theme.colors.primary
                                                : theme.colors.onSurfaceVariant,
                                          ),
                                          title: Text(
                                            screen.title,
                                            style: theme.typography.bodyMedium
                                                .copyWith(
                                                  color: isSelected
                                                      ? theme.colors.primary
                                                      : theme.colors.onSurface,
                                                  fontWeight: isSelected
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          selected: isSelected,
                                          selectedTileColor: theme
                                              .colors
                                              .primary
                                              .withValues(alpha: 0.1),
                                          hoverColor: theme.colors.primary
                                              .withValues(alpha: 0.05),
                                          onTap: () {
                                            setState(() {
                                              _selectedPreviewScreen = screen;
                                            });
                                          },
                                        ),
                                      );
                                    }),
                                    const SizedBox(height: 8),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Simulated Content Area
                  Expanded(
                    child: Container(
                      color: theme.colors.surfaceContainerLowest,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Fake Top Bar
                          Container(
                            height: 64,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            decoration: BoxDecoration(
                              color: theme.colors.surface,
                              border: Border(
                                bottom: BorderSide(
                                  color: theme.colors.outlineVariant,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  LucideIcons.menu,
                                  color: theme.colors.onSurfaceVariant,
                                ),
                                const Spacer(),
                                Icon(
                                  LucideIcons.bell,
                                  color: theme.colors.onSurfaceVariant,
                                  size: 20,
                                ),
                                const SizedBox(width: 16),
                                Icon(
                                  LucideIcons.search,
                                  color: theme.colors.onSurfaceVariant,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                          // Fake Page Content
                          Expanded(
                            child: _selectedPreviewScreen == null
                                ? Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          LucideIcons.mousePointerClick,
                                          size: 48,
                                          color: theme.colors.outline,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'governance.sidebar_mapping.select_screen_prompt'
                                              .tr(),
                                          style: theme.typography.bodyLarge
                                              .copyWith(
                                                color: theme
                                                    .colors
                                                    .onSurfaceVariant,
                                              ),
                                        ),
                                      ],
                                    ),
                                  )
                                : _buildScreenStatusPreview(
                                    theme,
                                    _selectedPreviewScreen!,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenStatusPreview(
    PrimeThemeData theme,
    meta.ScreenMetadata screen,
  ) {
    final status = screen.isRenderOk ? 'IMPLEMENTED' : 'DECLARED';

    Color statusColor;
    IconData statusIcon;
    if (screen.isRenderOk) {
      statusColor = Colors.green;
      statusIcon = LucideIcons.checkCircle;
    } else if (screen.isVirtual) {
      statusColor = Colors.orange;
      statusIcon = LucideIcons.alertTriangle;
    } else {
      statusColor = theme.colors.error;
      statusIcon = LucideIcons.xCircle;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(theme.radiusLg),
                ),
                child: Icon(statusIcon, color: statusColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(screen.title, style: theme.typography.h1),
                    const SizedBox(height: 4),
                    Text(
                      '${'governance.sidebar_mapping.status_label'.tr()} ${('governance.sidebar_mapping.status.${status.toLowerCase()}').tr()}',
                      style: theme.typography.bodyLarge.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          Text(
            'governance.sidebar_mapping.platform_component_status'.tr(),
            style: theme.typography.h3,
          ),
          const SizedBox(height: 16),
          _buildComponentStatusGrid(theme, screen),

          const SizedBox(height: 32),
          Text(
            'governance.sidebar_mapping.screen_details'.tr(),
            style: theme.typography.h3,
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: theme.colors.surface,
              borderRadius: BorderRadius.circular(theme.radiusLg),
              border: Border.all(color: theme.colors.outlineVariant),
            ),
            child: Column(
              children: [
                _buildDetailRow(
                  theme,
                  'governance.sidebar_mapping.identifier'.tr(),
                  screen.id,
                ),
                Divider(height: 1, color: theme.colors.outlineVariant),
                _buildDetailRow(
                  theme,
                  'governance.sidebar_mapping.route_path'.tr(),
                  screen.routePath,
                ),
                Divider(height: 1, color: theme.colors.outlineVariant),
                _buildDetailRow(
                  theme,
                  'governance.sidebar_mapping.feature_name'.tr(),
                  screen.featureName,
                ),
                Divider(height: 1, color: theme.colors.outlineVariant),
                _buildDetailRow(
                  theme,
                  'governance.sidebar_mapping.story_points'.tr(),
                  screen.storyPoints.toString(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: PrimeButton.secondary(
              label: 'governance.sidebar_mapping.open_live_screen'.tr(),
              icon: LucideIcons.externalLink,
              onPressed: () {
                context.go(screen.routePath);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentStatusGrid(
    PrimeThemeData theme,
    meta.ScreenMetadata screen,
  ) {
    return GridView.extent(
      maxCrossAxisExtent: 250,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildComponentCard(
          theme,
          'governance.sidebar_mapping.sidebar_nav'.tr(),
          'IMPLEMENTED',
          LucideIcons.layoutPanelLeft,
        ),
        _buildComponentCard(
          theme,
          'governance.sidebar_mapping.platform_top_bar'.tr(),
          'IMPLEMENTED',
          LucideIcons.layoutPanelTop,
        ),
        _buildComponentCard(
          theme,
          'governance.sidebar_mapping.main_content'.tr(),
          screen.isRenderOk ? 'IMPLEMENTED' : 'DECLARED',
          LucideIcons.layout,
        ),
      ],
    );
  }

  Widget _buildComponentCard(
    PrimeThemeData theme,
    String name,
    String status,
    IconData icon,
  ) {
    Color statusColor;
    switch (status.toUpperCase()) {
      case 'IMPLEMENTED':
        statusColor = Colors.green;
        break;
      case 'DECLARED':
        statusColor = theme.colors.primary;
        break;
      case 'NOT_IMPLEMENTED':
        statusColor = theme.colors.error;
        break;
      case 'STUBBED':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = theme.colors.onSurfaceVariant;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusLg),
        border: Border.all(color: theme.colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: theme.colors.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: theme.typography.labelSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(theme.radiusXs),
            ),
            child: Text(
              ('governance.sidebar_mapping.status.${status.toLowerCase()}')
                  .tr(),
              style: theme.typography.bodySmall.copyWith(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(PrimeThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Text(
            label,
            style: theme.typography.bodyMedium.copyWith(
              color: theme.colors.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: theme.typography.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

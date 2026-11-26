import 'package:primecare_theme/theme/portal_section_theme.dart';
import 'package:primecare_assets/original_assets/prime_original_asset.dart';
import 'package:primecare_theme/theme/prime_account_trigger_focus_frame.dart';
import 'package:primecare_theme/theme/prime_shell_metrics.dart';
import 'package:primecare_theme/theme/prime_toolbar_account_frame.dart';
import 'package:primecare_theme/theme/theme_center_options.dart';
import 'package:primecare_theme/workspace/portal_workspace.dart';
import 'package:primecare_preferences/providers/persistence_providers.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeDrawer, PrimeListTile, PrimePopupMenuButton;
import 'package:primecare_theme/theme/theme_contrast.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeAppBar;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeSnackBar;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeScaffold;
import 'package:primecare_theme/theme/theme_center_theme_data.dart';
// Governance - Category: view | Purpose: Layer: 01_INFRASTRUCTURE The central Governance Layout for all PrimeCare portals. It automatically pulls sidebar and ...
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeText;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeIcon;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeTextButton;
import 'package:flutter/material.dart';
import 'package:primecare_theme/theme/app_theme.dart';
import 'package:primecare_theme_preferences/theme/theme_settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:primecare_platform_domain/models/domain_governance.dart';
import 'package:primecare_screen_intents/models/screen.dart';
import 'package:primecare_portal_state/models/governance_role.dart';
import 'package:primecare_models/src/models/platform_role.dart';
import 'package:primecare_aura/aura_behavioral_telemetry.dart';
import 'package:primecare_models/src/models/auth_state.dart';
import 'package:primecare_application_shortcuts/security/shortcuts/quick_access_manager.dart';
import 'package:primecare_layout/config/screen_breakpoints.dart';
import 'package:primecare_layout/config/adaptive_scaling_config.dart';

import 'package:lucide_icons_flutter/lucide_icons.dart';

/// The central Governance Layout for all PrimeCare portals.
/// It automatically pulls sidebar and top-bar data from the [PlatformApplication]
/// based on the [activeRole], ensuring layout consistency and "Zero-Trust" routing paths.
abstract class GovernanceMasterLayoutBase extends ConsumerWidget {
  final PlatformApplication application;
  final PlatformRole activeRole;
  final Widget child;

  const GovernanceMasterLayoutBase({
    super.key,
    required this.application,
    required this.activeRole,
    required this.child,
  });
  ThemeSettingsState watchSettings(WidgetRef ref);
  AuthState watchAccount(WidgetRef ref);
  GovernanceRoleBase roleBinding();
  Widget settingsDrawer(String defaultPreset);
  String watchLanguage(WidgetRef ref);
  Future<void> setLanguage(WidgetRef ref, String language);
  Widget toolbarTextScale(Color foreground);
  String saveTooltip(BuildContext context);
  void logout(WidgetRef ref);

  String _localizedResource(BuildContext context, String key, String fallback) {
    if (EasyLocalization.of(context) == null) return fallback;
    final value = context.tr(key);
    return value == key ? fallback : value;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigation = <MapEntry<PlatformModule, List<PrimeCareScreen>>>[];
    for (final module in application.getAuthorizedModules(activeRole)) {
      final screens = module.screens.where(
        (screen) => screen.requiredRole == null || screen.requiredRole == activeRole,
      ).toList();
      if (screens.isNotEmpty) navigation.add(MapEntry(module, screens));
    }
    final tenant = application.tenant;
    final tier = ScreenBreakpoints.getTier(MediaQuery.of(context).size.width);
    final isHandheld = MediaQuery.sizeOf(context).width <= 1024;
    final shellBarHeight = PrimeShellMetrics.barHeight(MediaQuery.sizeOf(context).width);

    // Sync Governance Context to Telemetry
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(auraBehavioralTelemetryProvider)
          .updateGovernanceContext(tenant: tenant, role: activeRole);
    });

    final settings = watchSettings(ref);

    final theme=applyPortalSectionThemes(applyPersonalThemeData(tenant.branding,settings.theme), settings.sectionThemes);

    final themeColors = theme.extension<GovernanceThemeColors>();

    // Dynamic top bar colors
    final configuredTopbarBg = themeColors?.topbarBackground ?? theme.scaffoldBackgroundColor;
    final toolbarSettings = settings.sectionThemes['toolbar'] ?? settings.theme;

    Widget buildHorizontalNav(ThemeData navbarTheme) {
      final colors = navbarTheme.extension<GovernanceThemeColors>();
      final background = colors?.sidebarBackground ?? navbarTheme.scaffoldBackgroundColor;
      final foreground = readableThemeForeground(
        background,
        colors?.sidebarTextColor ?? navbarTheme.colorScheme.onSurface,
      );
      return Container(
        decoration: PrimeShellMetrics.horizontalNavigationDecoration(
          navbarTheme,
          background: background,
          divider: colors?.sidebarDividerColor,
        ),
        child: PrimeHorizontalChrome(
          background: background,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const PrimeOriginalAsset(
                          'brand-mark-concept',
                          width: PrimeShellMetrics.sidebarLogoExtent,
                          height: PrimeShellMetrics.sidebarLogoExtent,
                        ),
                        const SizedBox(width: PrimeShellMetrics.sidebarGap),
                        Flexible(
                          child: PrimeText(
                            tenant.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: PrimeShellMetrics.sidebarTextStyle(
                              navbarTheme,
                              family: settings.theme.fontFamily,
                              scale: settings.theme.fontScale,
                              color: foreground,
                              brand: true,
                            ),
                          ),
                        ),
                      ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: PrimePortalTheme(
                    data: PrimeShellMetrics.navigationInteractionTheme(
                      navbarTheme,
                      readableThemeForeground(background, navbarTheme.colorScheme.onSurface),
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: navigation.length,
                        itemBuilder: (context, index) {
                          final MapEntry(key: module, value: screens) = navigation[index];
                          final screen = screens.length == 1 ? screens.single : null;
                          final selected = screen != null &&
                              GoRouter.maybeOf(context)?.routeInformationProvider.value.uri.path == screen.route;
                          final selectedBackground = navbarTheme.colorScheme.secondary;
                          final labelColor = selected
                              ? readableThemeForeground(selectedBackground, navbarTheme.colorScheme.onSecondary)
                              : foreground;
                          return Padding(
                            padding: PrimeShellMetrics.horizontalNavigationItemPadding,
                            child: Center(
                              child: SizedBox(
                                height: PrimeShellMetrics.horizontalNavigationRowHeight,
                                child: screen != null ? Semantics(
                                  container: true,
                                  link: true,
                                  selected: selected,
                                  child: Center(
                                    widthFactor: 1,
                                    child: PrimeTextButton(
                                      style: PrimeShellMetrics.horizontalDestinationStyle(
                                        foreground: labelColor,
                                        selectedBackground: selected ? selectedBackground : null,
                                        brightness: navbarTheme.brightness,
                                      ),
                                      onPressed: () => context.go(screen.route),
                                      child: PrimePortalNavigationLabel(
                                        icon: screen.icon ?? module.icon,
                                        label: screen.title,
                                        color: labelColor,
                                        showExpand: false,
                                      ),
                                    ),
                                  ),
                                ) : PrimePopupMenuButton<String>(
                                  borderRadius: PrimeShellMetrics.navigationItemRadius,
                                  tooltip: module.name,
                                  onSelected: (route) => context.go(route),
                                  itemBuilder: (context) => [
                                    for (final screen in screens)
                                      PopupMenuItem(
                                        value: screen.route,
                                        child: PrimeText(screen.title),
                                      ),
                                  ],
                                  child: PrimePortalNavigationLabel(
                                    icon: module.icon,
                                    label: module.name,
                                    color: foreground,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ),
      );
    }

    final defaultPreset = tenant.tenantId == 'primecare_clinic' ? 'navyTealPalette' : 'default';

    final auth = watchAccount(ref);
    final preferences = ref.watch(sharedPreferencesProvider);
    return PortalWorkspace(
      defaultNavigationWidth: PrimeShellMetrics.expandedNavigationWidth,
      key: ValueKey('${auth.isAuthenticated}:${auth.tenantId}:${auth.userId}:${activeRole.name}:${application.name}:${preferences != null}'),
      scope: WorkspaceScope(
        tenant: auth.tenantId ?? tenant.tenantId,
        user: auth.userId ?? 'guest',
        role: activeRole.name,
        dataset: application.name,
      ),
      preferences: hasThemeAccount(auth) && preferences != null
          ? SharedWorkspacePreferences(preferences) : null,
      legacyLayoutStyle: settings.layoutStyle.name,
      builder: (context, workspace) => PrimePortalTheme(
      data: theme,
      customScrollbars: settings.customScrollbars,
      child: QuickAccessBoundary(
        userRole: roleBinding(),
        currentOffice: 'CORPORATE',
        child: Directionality(
          textDirection: settings.direction,
          child: Semantics(
            label: 'data-cy:app-shell',
            container: true,
            child: KeyedSubtree(
              key: const Key('app-shell'),
              child: PrimeScaffold(
                drawerScrimColor: PrimeShellMetrics.drawerScrimColor,
                endDrawer: settingsDrawer(defaultPreset),
                drawer: isHandheld || workspace.current.navigation == 'hidden'
                    ? _buildSidebar(
                        context,
                        ref,
                        portalSectionTheme(theme, 'navbar'),
                        navigation,
                        tenant,
                        tier,
                        settings,
                        collapsed: false,
                        isDrawer: true,
                      )
                    : null,
                body: PrimeWorkspaceRecovery(show: workspace.current.toolbar == 'hidden', child: PrimeWorkspaceLayout(
                  controller: workspace,
                  navbarStyle: settings.navbarStyle,
                  navigationVisible: !isHandheld,
                  navigationVisualWidth:
                      workspace.current.navigationWidth == PrimeShellMetrics.foldedNavigationMarker
                          ? PrimeShellMetrics.foldedNavigationWidth
                          : null,
                  horizontalNavigationExtent: PrimeShellMetrics.horizontalNavbarHeight,
                  toolbarExtent: PrimeShellMetrics.toolbarExtent(MediaQuery.sizeOf(context).width,horizontal:['top','bottom'].contains(workspace.current.navigation)||workspace.current.navigation=='hidden'&&settings.layoutStyle==LayoutStyle.horizontal),
                  footerExtent: PrimeShellMetrics.footerExtent(MediaQuery.sizeOf(context).width),
                  navigation: PrimePortalTheme(data: portalSectionTheme(theme, 'navbar'), child: ['top', 'bottom'].contains(workspace.current.navigation)
                      ? Builder(builder: (context) => buildHorizontalNav(Theme.of(context)))
                      : _buildSidebar(
                          context, ref, portalSectionTheme(theme, 'navbar'),
                          navigation, tenant, tier, settings,
                          collapsed: workspace.current.navigationWidth ==
                              PrimeShellMetrics.foldedNavigationMarker,
                          onTrailingSide: workspace.current.navigation == 'right',
                        )),
                  toolbar: PrimePortalTheme(data: portalSectionTheme(theme, 'toolbar'), child: PrimeShellBarFrame(bordered:['top','bottom'].contains(workspace.current.navigation)||workspace.current.navigation=='hidden'&&settings.layoutStyle==LayoutStyle.horizontal,child: Builder(builder: (context) {
                  final theme = Theme.of(context);
                  final position = workspace.current.navigation;
                  final horizontal = position == 'top' || position == 'bottom';
                  final topbarBg = PrimeShellMetrics.toolbarSurface(
                    theme,
                    configuredTopbarBg,
                    horizontal: horizontal ||
                        position == 'hidden' && settings.layoutStyle == LayoutStyle.horizontal,
                    hasBackgroundOverride: toolbarSettings.colors.containsKey('topbar'),
                  );
                  final topbarTextColor = readableThemeForeground(
                    topbarBg, themeColors?.topbarTextColor ?? theme.colorScheme.onSurface,
                  );
                  final topbarIconColor = readableThemeForeground(
                    topbarBg, themeColors?.topbarIconColor ?? theme.primaryColor,
                  );
                  final toolbar = PreferredSize(
                  preferredSize: Size.fromHeight(shellBarHeight),
                  child: Semantics(
                    label: 'data-cy:app-topbar',
                    container: true,
                    child: KeyedSubtree(
                      key: const Key('app-topbar'),
                      child: PrimeAppBar(
                        toolbarHeight: shellBarHeight,
                        primary: false,
                        elevation: 0,
                        clipBehavior: horizontal && !isHandheld ? Clip.none : null,
                        leadingWidth: !isHandheld && position == 'left'
                            ? PrimeShellMetrics.sidebarToggleLeadingWidth
                            : null,
                        leading: isHandheld
                            ? PrimeSidebarDrawerButton(foreground: topbarIconColor)
                            : position == 'left'
                                ? PrimeSidebarFoldButton(controller: workspace, foreground: topbarIconColor)
                                : null,
                        backgroundColor: topbarBg,
                        surfaceTintColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0),
                        iconTheme: IconThemeData(color: topbarIconColor),
                        title: null,
                        actions: [
                          Semantics(
                            label: 'data-cy:topbar-language-switcher',
                            container: true,
                            child: KeyedSubtree(
                              key: const Key('topbar-language-switcher'),
                              child: PrimePopupMenuButton<String>(
                                offset: const Offset(0, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: theme.dividerColor),
                                ),
                                tooltip: 'Change Language',
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      PrimeOriginalAsset(
                                        switch (watchLanguage(ref)) {
                                          'fr' => 'language-flag-fr-fr',
                                          'es' => 'language-flag-es-es',
                                          _ => 'language-flag-en-us',
                                        },
                                        width: 20,
                                        height: 14,
                                        palette: PrimeShellMetrics.languageFlagPalette(watchLanguage(ref)),
                                      ),
                                      const SizedBox(width: 6),
                                      PrimeText(
                                        watchLanguage(ref).toUpperCase(),
                                        style: theme.textTheme.labelMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: topbarTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onSelected: (lang) async {
                                  await setLanguage(ref,lang);
                                  if (context.mounted) {
                                    await context.setLocale(Locale(lang));
                                  }
                                },
                                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: 'en',
                                    child: Semantics(
                                      label: 'data-cy:topbar-language-option-en',
                                      container: false,
                                      child: KeyedSubtree(
                                        key: const Key('topbar-language-option-en'),
                                        child: PrimeText('English (EN)', style: theme.textTheme.bodyMedium),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'fr',
                                    child: Semantics(
                                      label: 'data-cy:topbar-language-option-fr',
                                      container: false,
                                      child: KeyedSubtree(
                                        key: const Key('topbar-language-option-fr'),
                                        child: PrimeText('Français (FR)', style: theme.textTheme.bodyMedium),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'es',
                                    child: Semantics(
                                      label: 'data-cy:topbar-language-option-es',
                                      container: false,
                                      child: KeyedSubtree(
                                        key: const Key('topbar-language-option-es'),
                                        child: PrimeText('Español (ES)', style: theme.textTheme.bodyMedium),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (!isHandheld)
                            toolbarTextScale(topbarIconColor),
                          if (horizontal && !isHandheld)
                            PortalLayoutSaveButton(tooltip: saveTooltip(context)),
                          if (horizontal || isHandheld || position == 'hidden') ...[
                            const SizedBox(width: 8),
                            _buildAccountMenu(
                              context, ref, theme,
                              textColor: topbarTextColor,
                              iconColor: topbarIconColor,
                              preferredFamily: settings.theme.fontFamily,
                              preferredScale: settings.theme.fontScale,
                              compact: isHandheld,
                              mobile: isHandheld,
                              horizontalToolbar: horizontal && !isHandheld,
                              triggerSurface: topbarBg,
                            ),
                            if (!horizontal) const SizedBox(width: 8),
                          ],
                          if (!isHandheld && position == 'right')
                            PrimeSidebarFoldButton(controller: workspace, foreground: topbarIconColor),
                        ],
                      ),
                    ),
                  ),
                );
                  return horizontal && !isHandheld
                      ? PrimeHorizontalChrome(background: topbarBg, child: toolbar)
                      : toolbar;
                  })),
                  ),
                  footer: PrimePortalTheme(data: portalSectionTheme(theme, 'footer'), child: const PrimeShellBarFrame(top:true,child:PortalLayoutFooter())),
                  main: Semantics(
                    label: 'data-cy:app-content-slot',
                    container: true,
                    child: KeyedSubtree(key: const Key('app-content-slot'),
                      child: AppShellBoundary(child: child)),
                  ),
                  panels: const {},
                )),
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildAccountMenu(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme, {
    required Color textColor,
    required Color iconColor,
    required String preferredFamily,
    required double preferredScale,
    required bool compact,
    bool sidebar = false,
    bool mobile = false,
    bool horizontalToolbar = false,
    bool trailing = false,
    double? leadingDrawerViewportWidth,
    Color? avatarSurface,
    Color? triggerSurface,
  }) {
    final semanticsId = sidebar ? 'sidebar-user-menu' : 'topbar-user-menu',
        logoutId = sidebar ? 'sidebar-logout-button' : 'topbar-logout-button',
        account = watchAccount(ref);
    final avatar = CircleAvatar(
      radius: sidebar
          ? PrimeShellMetrics.sidebarAccountAvatarRadius
          : horizontalToolbar
              ? PrimeShellMetrics.horizontalToolbarAccountAvatarRadius
              : PrimeShellMetrics.toolbarAccountAvatarRadius,
      backgroundColor: PrimeShellMetrics.accountAvatarBackground(
        theme,
        surface: avatarSurface,
      ),
      child: PrimeText(
        activeRole.displayName.characters.first.toUpperCase(),
        style: PrimeShellMetrics.toolbarAccountAvatarTextStyle(
          theme,
          textColor,
          family: preferredFamily,
          scale: preferredScale,
        ),
      ),
    );
    const horizontalAvatarExtent =
        2 * PrimeShellMetrics.horizontalToolbarAccountAvatarRadius;
    final triggerRadius = sidebar
        ? PrimeShellMetrics.sidebarAccountRadius
        : horizontalToolbar
        ? PrimeShellMetrics.horizontalToolbarAccountRadius
        : PrimeShellMetrics.toolbarAccountRadius;
    final trigger = sidebar
        ? SizedBox(
            height: PrimeShellMetrics.sidebarAccountButtonHeight(compact),
            child: Padding(
              padding: PrimeShellMetrics.sidebarAccountPadding(compact),
              child: Row(
                mainAxisAlignment: compact
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  avatar,
                  if (!compact) ...[
                    const SizedBox(width: PrimeShellMetrics.sidebarAccountGap),
                    Expanded(
                      child: PrimeText(
                        activeRole.displayName,
                        overflow: TextOverflow.ellipsis,
                        style: PrimeShellMetrics.toolbarAccountRoleTextStyle(
                          theme,
                          textColor,
                          family: preferredFamily,
                          scale: preferredScale,
                          dense: false,
                        ),
                      ),
                    ),
                    PrimeIcon(
                      LucideIcons.info,
                      size: PrimeShellMetrics.sidebarAccountInfoExtent,
                      color: iconColor,
                    ),
                    const SizedBox(
                      width: PrimeShellMetrics.sidebarAccountActionGap,
                    ),
                    PrimeIcon(
                      LucideIcons.chevronUp,
                      size: PrimeShellMetrics.sidebarAccountArrowExtent,
                      color: iconColor,
                    ),
                  ],
                ],
              ),
            ),
          )
        : SizedBox(
            height: PrimeShellMetrics.toolbarAccountHeight,
            child: PrimeToolbarAccountFrame(
              radius: triggerRadius,
              child: Padding(
                padding: horizontalToolbar
                    ? PrimeShellMetrics.horizontalToolbarAccountPadding
                    : PrimeShellMetrics.toolbarAccountPadding,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (horizontalToolbar)
                      SizedBox(
                        width: horizontalAvatarExtent,
                        child: OverflowBox(
                          minHeight: horizontalAvatarExtent,
                          maxHeight: horizontalAvatarExtent,
                          child: avatar,
                        ),
                      )
                    else
                      avatar,
                    if (!compact) ...[
                      const SizedBox(width: 6),
                      PrimeText(
                        activeRole.displayName,
                        style: PrimeShellMetrics.toolbarAccountRoleTextStyle(
                          theme,
                          textColor,
                          family: preferredFamily,
                          scale: preferredScale,
                          dense: true,
                          horizontalToolbar: horizontalToolbar,
                        ),
                      ),
                      const SizedBox(width: 6),
                      PrimeIcon(
                        LucideIcons.info,
                        size: PrimeShellMetrics.accountInfoExtent,
                        color: iconColor,
                      ),
                      const SizedBox(width: 8),
                    ],
                    PrimeIcon(
                      LucideIcons.chevronDown,
                      size: 13,
                      color: iconColor,
                    ),
                  ],
                ),
              ),
            ),
          );
    const tooltip = 'User Functions';
    final menuItemHeight = PrimeShellMetrics.accountMenuItemHeight(
      mobile: mobile,
      viewportWidth: MediaQuery.sizeOf(context).width,
    );
    void selectAccountAction(String value) {
      if (value == 'maintenance') context.go('/maintenance/configuration');
      if (value == 'logout') logout(ref);
    }

    List<PopupMenuEntry<String>> buildAccountItems(BuildContext context) =>
        <PopupMenuEntry<String>>[
          // A cross-role action requires an explicit user-authorized role list.
          // This shell only receives the active role, so it must not invent grants.
          if (['ceo', 'maintenance'].contains(account.role))
            PrimeAccountMenuItem<String>(
              menuTheme: theme,
              padding: PrimeShellMetrics.accountMenuItemPadding,
              height: menuItemHeight,
              value: 'maintenance',
              child: const PrimeText('IT maintenance'),
            ),
          PrimeAccountMenuItem<String>(
            menuTheme: theme,
            padding: PrimeShellMetrics.accountMenuItemPadding,
            height: menuItemHeight,
            value: 'logout',
            child: Semantics(
              label: 'data-cy:$logoutId',
              container: false,
              child: KeyedSubtree(
                key: Key(logoutId),
                child: Row(
                  children: [
                    PrimeIcon(
                      LucideIcons.squareArrowRight,
                      size: PrimeShellMetrics.accountMenuIconExtent,
                      color: iconColor,
                    ),
                    const SizedBox(width: PrimeShellMetrics.accountMenuIconGap),
                    PrimeText(
                      _localizedResource(
                        context,
                        'workspace.sign_out',
                        'Sign out',
                      ),
                      style: PrimeShellMetrics.accountSignOutTextStyle(
                        theme,
                        theme.colorScheme.onSurface,
                        family: preferredFamily,
                        scale: preferredScale,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ];
    final wideLeadingDrawer =
        leadingDrawerViewportWidth != null &&
        leadingDrawerViewportWidth >= PrimeShellMetrics.compactAccountMenuBreakpoint;
    final button = wideLeadingDrawer
        ? PrimeWideDrawerAccountMenu(
            radius: triggerRadius,
            brightness: theme.brightness,
            tooltip: tooltip,
            onSelected: selectAccountAction,
            itemBuilder: buildAccountItems,
            child: trigger,
          )
        : PrimePopupMenuButton<String>(
            borderRadius: triggerRadius,
            position: sidebar ? PopupMenuPosition.over : PopupMenuPosition.under,
            offset: PrimeShellMetrics.accountMenuOffset(
              sidebar: sidebar,
              compact: compact,
              mobile: mobile,
              trailing: trailing,
              leadingDrawerViewportWidth: leadingDrawerViewportWidth,
            ),
            menuPadding: PrimeShellMetrics.accountMenuPadding,
            constraints: PrimeShellMetrics.accountMenuConstraints,
            shape: PrimeShellMetrics.accountMenuShape,
            clipBehavior: Clip.antiAlias,
            elevation: PrimeShellMetrics.accountMenuElevationFor(theme.brightness),
            shadowColor: PrimeShellMetrics.accountMenuShadowFor(theme.brightness),
            surfaceTintColor: PrimeShellMetrics.transparentInteractionInk,
            tooltip: tooltip,
            child: trigger,
            onSelected: selectAccountAction,
            itemBuilder: buildAccountItems,
          );
    return Semantics(
      label: 'data-cy:$semanticsId',
      container: true,
      child: Padding(
        padding: sidebar
            ? PrimeShellMetrics.sidebarAccountOuterPadding(compact)
            : PrimeShellMetrics.toolbarAccountMargin,
        child: KeyedSubtree(
          key: Key(semanticsId),
          child: PrimeAccountTriggerFocusFrame(
            radius: triggerRadius,
            surface: triggerSurface ?? avatarSurface ?? theme.scaffoldBackgroundColor,
            child: button,
          ),
        ),
      ),
    );
  }

  Widget _buildSidebar(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
    List<MapEntry<PlatformModule, List<PrimeCareScreen>>> navigation,
    PlatformTenant tenant,
    ResolutionTier tier,
    ThemeSettingsState settings, {
    bool collapsed = false,
    bool isDrawer = false,
    bool tabContent = false,
    bool onTrailingSide = false,
  }) {
    const brandMark = PrimeOriginalAsset(
      'brand-mark-concept',
      width: PrimeShellMetrics.sidebarLogoExtent,
      height: PrimeShellMetrics.sidebarLogoExtent,
    );
    final themeColors = theme.extension<GovernanceThemeColors>();
    final sidebarBg = themeColors?.sidebarBackground ?? theme.scaffoldBackgroundColor;
    final defaultSidebarTextColor = readableThemeForeground(sidebarBg, theme.colorScheme.onSurface);
    final defaultSidebarIconColor = readableThemeForeground(sidebarBg, theme.iconTheme.color ?? theme.primaryColor);
    final sidebarTextColor = themeColors?.sidebarTextColor ?? defaultSidebarTextColor;
    final sidebarIconColor = themeColors?.sidebarIconColor ?? defaultSidebarIconColor;
    if(settings.navigationStyle == 'tabbed' && !isDrawer && !tabContent && navigation.isNotEmpty) {
      String route='';try {route=GoRouterState.of(context).uri.path;} catch (_) {}
      final selected=navigation.indexWhere((group)=>group.value.any((screen)=>screen.route==route));
      return PrimeTabbedNavigation(
        initialIndex:selected<0?0:selected,
        railHeader: const SizedBox(
          height: PrimeShellMetrics.foldedHeaderExtent,
          child: Center(child: brandMark),
        ),
        foldedRailFooter: Align(
          alignment: AlignmentDirectional.centerStart,
          child: SizedBox(
            width: PrimeShellMetrics.foldedNavigationContentWidth,
            child: _buildAccountMenu(
              context, ref, theme,
              textColor: sidebarTextColor,
              iconColor: sidebarIconColor,
              preferredFamily: settings.theme.fontFamily,
              preferredScale: settings.theme.fontScale,
              compact: true,
              sidebar: true,
              trailing: onTrailingSide,
              avatarSurface: sidebarBg,
            ),
          ),
        ),
        tabs:[
        for(final group in navigation)PrimeNavigationTab(label:group.key.name,icon:group.key.icon,
          content:_buildSidebar(context,ref,theme,[group],tenant,tier,settings,tabContent:true,onTrailingSide:onTrailingSide),
          entries:[for(final screen in group.value)
            PrimeNavigationEntry(screen.title,()=>context.go(screen.route))]),
      ]);
    }
    final sloganColor = readableThemeForeground(sidebarBg, theme.colorScheme.onSurfaceVariant);
    final contrastInk = readableThemeForeground(sidebarBg, theme.colorScheme.onSurface);
    final sidebarSelectedTileColor = PrimeShellMetrics.sidebarSelectionFill(
      background: sidebarBg,
      foreground: contrastInk,
      brightness: theme.brightness,
    );
    final sidebarSelectedTextColor = readableThemeForeground(
      sidebarSelectedTileColor, themeColors?.sidebarSelectedTextColor ?? sidebarTextColor,
    );
    final sidebarSelectedIconColor = readableThemeForeground(
      sidebarSelectedTileColor, themeColors?.sidebarSelectedIconColor ?? sidebarIconColor,
    );
    final sidebarDividerColor = themeColors?.sidebarDividerColor ?? theme.dividerColor.withValues(alpha: 0.05);

    final sidebarWidth = collapsed
        ? PrimeShellMetrics.foldedNavigationWidth
        : AdaptiveScalingConfig.getSidebarWidth(tier);

    final sidebarContent = Semantics(
      label: 'data-cy:app-sidebar',
      container: true,
      child: KeyedSubtree(
        key: const Key('app-sidebar'),
        child: Container(
          width: sidebarWidth,
          decoration: PrimeShellMetrics.sidebarDecoration(
            background: sidebarBg,
            divider: isDrawer ? null : sidebarDividerColor,
            onTrailingSide: onTrailingSide,
            direction: settings.direction,
          ),
          // Keep row ink above the opaque sidebar decoration.
          child: Material(type:MaterialType.transparency,child:Column(children:[
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: collapsed
                    ? PrimeShellMetrics.foldedHeaderExtent
                    : PrimeShellMetrics.barHeight(MediaQuery.sizeOf(context).width),
              ),child:Padding(
              padding:PrimeShellMetrics.sidebarHeaderPadding(collapsed),child:Row(mainAxisAlignment:collapsed?MainAxisAlignment.center:MainAxisAlignment.start,children:[
                brandMark,
                if(!collapsed)...[const SizedBox(width:PrimeShellMetrics.sidebarGap),Expanded(child:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,children:[
                  PrimeText(tenant.name,maxLines:1,overflow:TextOverflow.ellipsis,
                    style:PrimeShellMetrics.sidebarTextStyle(theme,family:settings.theme.fontFamily,scale:settings.theme.fontScale,color:sidebarTextColor,brand:true)),
                  const SizedBox(height:PrimeShellMetrics.sidebarBrandLineGap),
                  PrimeText(themeCenterOption(context,'brand.slogan'),maxLines:1,overflow:TextOverflow.ellipsis,
                    style:PrimeShellMetrics.sidebarTextStyle(theme,family:settings.theme.fontFamily,scale:settings.theme.fontScale,color:sloganColor,slogan:true)),
                ]))],
              ]))),
            if (collapsed) const SizedBox(height: PrimeShellMetrics.foldedNavigationTopGap),
            Expanded(child:ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: navigation.length,
            itemBuilder: (context, index) {
              final MapEntry(key: module, value: screens) = navigation[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(navigation.length>1)Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: collapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
                      children: [
                        PrimeIcon(
                          module.icon,
                          size: 18,
                          color: sidebarIconColor.withValues(alpha: 0.8),
                        ),
                        if (!collapsed) ...[
                          const SizedBox(width: 12),
                          Expanded(
                            child: PrimeText(
                              module.name.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelSmall?.copyWith(
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                                color: sidebarTextColor.withValues(alpha: 0.6),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  ...screens.map((screen) {

                    String currentRoute = '';
                    try {
                      currentRoute = GoRouterState.of(context).uri.path;
                    } catch (_) {
                      currentRoute = '';
                    }

                    final isSelected = currentRoute == screen.route;
                    final icon = PrimeIcon(
                      screen.icon ?? LucideIcons.circle,
                      size: PrimeShellMetrics.sidebarIconExtent,
                      color: isSelected ? sidebarSelectedIconColor : sidebarIconColor,
                    );
                    return Padding(
                      padding: collapsed
                          ? PrimeShellMetrics.foldedRowPadding
                          : PrimeShellMetrics.sidebarRowPadding,
                      child: _PrimeSidebarDestination(
                        theme: theme,
                        folded: collapsed,
                        dense: true,
                        minTileHeight:PrimeShellMetrics.sidebarRowHeight,minVerticalPadding:0,minLeadingWidth:PrimeShellMetrics.sidebarIconExtent,horizontalTitleGap:PrimeShellMetrics.sidebarGap,
                        contentPadding: PrimeShellMetrics.sidebarRowContentPadding(collapsed),
                        selected: isSelected,
                        selectedTileColor: sidebarSelectedTileColor,
                        hoverColor: PrimeShellMetrics.navigationHoverInk(contrastInk),
                        focusColor: PrimeShellMetrics.navigationFocusInk(contrastInk),
                        leading: collapsed ? null : icon,
                        title: collapsed
                            ? Semantics(
                                label: screen.title,
                                child: Tooltip(
                                  message: screen.title,
                                  excludeFromSemantics: true,
                                  child: Center(child: icon),
                                ),
                              )
                            : PrimeText(
                                screen.title,
                                overflow: TextOverflow.ellipsis,
                                style: PrimeShellMetrics.sidebarTextStyle(theme,family:settings.theme.fontFamily,scale:settings.theme.fontScale,color:isSelected?sidebarSelectedTextColor:sidebarTextColor,selected:isSelected),
                              ),
                        onTap: () {
                          ref
                              .read(auraBehavioralTelemetryProvider)
                              .updateGovernanceContext(
                                tenant: tenant,
                                role: activeRole,
                                module: module,
                              );

                          if (isDrawer) {
                            Navigator.of(context).pop();
                          }

                          if (screen.requiredRole == null ||
                              screen.requiredRole == activeRole) {
                            context.go(screen.route);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              PrimeSnackBar(
                                content: PrimeText(
                                  tr('governance.unauthorized_access'),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                ],
              );
            },
          )),
          _buildAccountMenu(
            context, ref, theme,
            textColor: sidebarTextColor,
            iconColor: sidebarIconColor,
            preferredFamily: settings.theme.fontFamily,
            preferredScale: settings.theme.fontScale,
            compact: collapsed,
            sidebar: true,
            mobile: isDrawer,
            trailing: onTrailingSide,
            avatarSurface: sidebarBg,
            leadingDrawerViewportWidth: isDrawer && settings.direction == TextDirection.ltr
                ? MediaQuery.sizeOf(context).width
                : null,
          ),
          ])),
        ),
      ),
    );

    if (isDrawer) {
      return PrimeMobileDrawerFrame(
        child: PrimeDrawer(
          width: PrimeShellMetrics.mobileDrawerWidth,
          backgroundColor: sidebarBg,
          surfaceTintColor: PrimeShellMetrics.transparentInteractionInk,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: sidebarContent,
        ),
      );
    }
    return sidebarContent;
  }
}

class _PrimeSidebarDestination extends StatefulWidget {
  const _PrimeSidebarDestination({
    required this.theme,
    required this.folded,
    required this.dense,
    required this.minTileHeight,
    required this.minVerticalPadding,
    required this.minLeadingWidth,
    required this.horizontalTitleGap,
    required this.contentPadding,
    required this.selected,
    required this.selectedTileColor,
    required this.hoverColor,
    required this.focusColor,
    required this.leading,
    required this.title,
    required this.onTap,
  });

  final ThemeData theme;
  final bool folded;
  final bool dense;
  final double minTileHeight;
  final double minVerticalPadding;
  final double minLeadingWidth;
  final double horizontalTitleGap;
  final EdgeInsetsGeometry contentPadding;
  final bool selected;
  final Color selectedTileColor;
  final Color hoverColor;
  final Color focusColor;
  final Widget? leading;
  final Widget title;
  final VoidCallback onTap;

  @override
  State<_PrimeSidebarDestination> createState() =>
      _PrimeSidebarDestinationState();
}

class _PrimeSidebarDestinationState extends State<_PrimeSidebarDestination> {
  bool _keyboardFocused = false;

  @override
  Widget build(BuildContext context) => PrimeListTile(
    dense: widget.dense,
    minTileHeight: widget.minTileHeight,
    minVerticalPadding: widget.minVerticalPadding,
    minLeadingWidth: widget.minLeadingWidth,
    horizontalTitleGap: widget.horizontalTitleGap,
    contentPadding: widget.contentPadding,
    shape: PrimeShellMetrics.sidebarDestinationShape(
      widget.theme,
      folded: widget.folded,
      keyboardFocused: _keyboardFocused,
    ),
    selected: widget.selected,
    selectedTileColor: widget.selectedTileColor,
    hoverColor: widget.selected
        ? PrimeShellMetrics.transparentInteractionInk
        : widget.hoverColor,
    focusColor: widget.selected
        ? PrimeShellMetrics.transparentInteractionInk
        : widget.focusColor,
    leading: widget.leading,
    title: widget.title,
    onFocusChange: (focused) {
      if (_keyboardFocused == focused) return;
      setState(() => _keyboardFocused = focused);
    },
    onTap: widget.onTap,
  );
}


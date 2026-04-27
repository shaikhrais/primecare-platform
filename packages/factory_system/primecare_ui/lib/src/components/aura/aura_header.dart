import 'package:primecare_ui/primecare_ui.dart';
import 'dart:ui';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AuraHeader extends ConsumerStatefulWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final bool showActions;
  final Widget? customLeft;
  final Widget? customCenter;
  final Widget? customRight;

  const AuraHeader({
    super.key,
    this.actions,
    this.showActions = true,
    this.customLeft,
    this.customCenter,
    this.customRight,
  });

  @override
  ConsumerState<AuraHeader> createState() => _AuraHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(72.0);
}

class _AuraHeaderState extends ConsumerState<AuraHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _searchController;
  late Animation<double> _searchWidth;
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _searchController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _searchWidth = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _searchController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final layout = ref.watch(layoutProvider);
    final theme = Theme.of(context);
    final scale = layout.scaleFactor;
    final isMobile = layout.tier == ResolutionTier.mob;
    final isTablet = layout.tier == ResolutionTier.tab;
    final auraTheme = AuraRoleTheme.resolve(ref);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.7),
            border: Border(
              bottom: BorderSide(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2),
                width: 1 * scale,
              ),
            ),
          ),
          child: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            toolbarHeight: 72.0 * scale,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            title: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 24 * scale,
              ),
              child: Row(
                children: [
                  // Left: Aura Logo & Branding
                  widget.customLeft ??
                      _buildLeftSection(
                        context,
                        theme,
                        layout,
                        scale,
                        isMobile,
                        auraTheme,
                      ),

                  // Center: Search (Animated Expansion)
                  if (!isMobile && !isTablet)
                    Expanded(
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _searchWidth,
                          builder: (context, child) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    (300 + (200 * _searchWidth.value)) * scale,
                              ),
                              child:
                                  widget.customCenter ??
                                  _buildAuraSearchBox(
                                    theme,
                                    layout,
                                    scale,
                                    auraTheme,
                                  ),
                            );
                          },
                        ),
                      ),
                    )
                  else
                    const Spacer(),

                  // Right: Intelligence Pulse & Profile
                  if (widget.showActions)
                    widget.customRight ??
                        _buildRightSection(
                          context,
                          theme,
                          layout,
                          scale,
                          isMobile,
                          auraTheme,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeftSection(
    BuildContext context,
    ThemeData theme,
    LayoutConfig layout,
    double scale,
    bool isMobile,
    AuraRoleTheme auraTheme,
  ) {
    return Row(
      children: [
        if (isMobile) ...[
          _buildAuraIconButton(
            context,
            LucideIcons.menu,
            scale,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          SizedBox(width: 8 * scale),
        ],
        Row(
          children: [
            if (!isMobile) ...[
              _buildAuraIconButton(
                context,
                layout.isExtended ? LucideIcons.chevronLeft : LucideIcons.menu,
                scale,
                onPressed: () {
                  final current = ref.read(sidebarModeProvider);
                  ref
                      .read(sidebarOverrideProvider.notifier)
                      .setMode(
                        current == SidebarMode.extended
                            ? SidebarMode.minimal
                            : SidebarMode.extended,
                      );
                },
              ),
              SizedBox(width: 20 * scale),
            ],
            // Aura Logo Container
            Container(
              width: 44 * scale,
              height: 44 * scale,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14 * scale),
                gradient: LinearGradient(
                  colors: auraTheme.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: auraTheme.accentColor.withValues(alpha: 0.4),
                    blurRadius: 12 * scale,
                    offset: Offset(0, 4 * scale),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      'P',
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w900,
                        fontSize: 20 * scale,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                  // Glow overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14 * scale),
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.2),
                            Colors.transparent,
                          ],
                          center: const Alignment(-0.3, -0.3),
                          radius: 0.8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (!isMobile) ...[
              SizedBox(width: 14 * scale),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        theme.colorScheme.onSurface,
                        theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ],
                    ).createShader(bounds),
                    child: Text(
                      'PrimeCare',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20 * scale,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                  ),
                  Text(
                    auraTheme.auraLabel,
                    style: theme.textTheme.labelSmall?.copyWith(
                      letterSpacing: 1.2 * scale,
                      fontSize: 10 * scale,
                      color: auraTheme.accentColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildAuraSearchBox(
    ThemeData theme,
    LayoutConfig layout,
    double scale,
    AuraRoleTheme auraTheme,
  ) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() => _isSearchFocused = hasFocus);
        if (hasFocus) {
          _searchController.forward();
        } else {
          _searchController.reverse();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 48 * scale,
        decoration: BoxDecoration(
          color: _isSearchFocused
              ? theme.colorScheme.surface
              : theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.4,
                ),
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(
            color: _isSearchFocused
                ? auraTheme.accentColor.withValues(alpha: 0.5)
                : theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
            width: _isSearchFocused ? 2 : 1,
          ),
          boxShadow: _isSearchFocused
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    blurRadius: 15 * scale,
                    spreadRadius: 2 * scale,
                  ),
                ]
              : [],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'aura.search_hint'.tr(),
            hintStyle: TextStyle(
              fontSize: 14 * scale,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
            ),
            prefixIcon: Icon(
              LucideIcons.sparkles,
              size: 18 * scale,
              color: _isSearchFocused
                  ? auraTheme.accentColor
                  : theme.colorScheme.onSurfaceVariant,
            ),
            suffixIcon: _isSearchFocused
                ? Icon(
                    LucideIcons.command,
                    size: 14 * scale,
                    color: theme.colorScheme.onSurfaceVariant,
                  )
                : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 12 * scale),
          ),
        ),
      ),
    );
  }

  Widget _buildRightSection(
    BuildContext context,
    ThemeData theme,
    LayoutConfig layout,
    double scale,
    bool isMobile,
    AuraRoleTheme auraTheme,
  ) {
    return Row(
      children: [
        if (widget.actions != null) ...widget.actions!,
        if (!isMobile) ...[
          _buildAuraIconButton(context, LucideIcons.layers, scale),
          SizedBox(width: 12 * scale),
          _buildAuraIconButton(context, LucideIcons.activity, scale),
          SizedBox(width: 12 * scale),
        ],
        _buildIntelligencePulse(theme, scale, auraTheme),
        SizedBox(width: 16 * scale),
        _buildProfileBox(context, theme, scale, isMobile, auraTheme),
      ],
    );
  }

  Widget _buildIntelligencePulse(
    ThemeData theme,
    double scale,
    AuraRoleTheme auraTheme,
  ) {
    final activeAnomaly = ref.watch(auraActiveAnomalyProvider);
    final pulseEvent = ref.watch(auraPulseProvider).value;

    // Determine pulse intensity and color based on telemetry
    Color pulseColor = auraTheme.pulseColor;
    Duration pulseDuration = const Duration(seconds: 2);

    if (activeAnomaly != null) {
      if (activeAnomaly.impact == InsightImpact.alert) {
        pulseColor = theme.colorScheme.error;
        pulseDuration = const Duration(milliseconds: 600);
      } else if (activeAnomaly.impact == InsightImpact.caution) {
        pulseColor = Colors.orange;
        pulseDuration = const Duration(milliseconds: 1200);
      }
    } else if (pulseEvent != null &&
        pulseEvent.impact == InsightImpact.positive) {
      pulseColor = Colors.greenAccent;
      pulseDuration = const Duration(seconds: 1);
    }

    return Stack(
      children: [
        _buildAuraIconButton(
          context,
          activeAnomaly != null ? LucideIcons.zap : LucideIcons.zap,
          scale,
          onPressed: () => _showAuraBriefing(context, scale),
        ),
        Positioned(
          top: 8 * scale,
          right: 8 * scale,
          child: _PulseIndicator(
            color: pulseColor,
            scale: scale,
            duration: pulseDuration,
          ),
        ),
      ],
    );
  }

  void _showAuraBriefing(BuildContext context, double scale) {
    AuraBriefingPanel.show(context);
  }

  Widget _buildAuraIconButton(
    BuildContext context,
    IconData icon,
    double scale, {
    VoidCallback? onPressed,
  }) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed ?? () {},
        borderRadius: BorderRadius.circular(14 * scale),
        child: Container(
          width: 44 * scale,
          height: 44 * scale,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.3,
            ),
            borderRadius: BorderRadius.circular(14 * scale),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2),
            ),
          ),
          child: Icon(
            icon,
            size: 18 * scale,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileBox(
    BuildContext context,
    ThemeData theme,
    double scale,
    bool isMobile,
    AuraRoleTheme auraTheme,
  ) {
    final authState = ref.watch(authProvider);
    final userName = authState.userName ?? 'User';
    final role = authState.role ?? 'Platform Admin';
    final initials = userName.isNotEmpty
        ? userName.substring(0, 1).toUpperCase()
        : 'U';

    return InkWell(
      onTap: () => _showAuraMenu(context, scale),
      borderRadius: BorderRadius.circular(16 * scale),
      child: Container(
        padding: EdgeInsets.all(4 * scale),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.3,
          ),
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36 * scale,
              height: 36 * scale,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: auraTheme.primaryGradient,
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  initials,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14 * scale,
                  ),
                ),
              ),
            ),
            if (!isMobile) ...[
              SizedBox(width: 10 * scale),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 13 * scale,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    role.toUpperCase(),
                    style: TextStyle(
                      fontSize: 9 * scale,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      color: auraTheme.accentColor.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8 * scale),
              Icon(
                LucideIcons.chevronDown,
                size: 14 * scale,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: 4 * scale),
            ],
          ],
        ),
      ),
    );
  }

  void _showAuraMenu(BuildContext context, double scale) {
    final theme = Theme.of(context);
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(1000, 72 * scale, 24 * scale, 0),
      elevation: 20,
      color: theme.colorScheme.surface.withValues(alpha: 0.95),
      surfaceTintColor: theme.colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16 * scale),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2),
        ),
      ),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'profile',
          child: Row(
            children: [
              Icon(LucideIcons.user, size: 18 * scale),
              SizedBox(width: 12 * scale),
              Text('aura.profile'.tr()),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'settings',
          child: Row(
            children: [
              Icon(LucideIcons.settings, size: 18 * scale),
              SizedBox(width: 12 * scale),
              Text('aura.system_preferences'.tr()),
            ],
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(
                LucideIcons.logOut,
                size: 18 * scale,
                color: theme.colorScheme.error,
              ),
              SizedBox(width: 12 * scale),
              Text(
                'aura.sign_out'.tr(),
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (!context.mounted) return;
      if (value == 'profile') context.push(CommonRoutes.globalProfile);
      if (value == 'logout') _handleLogout(context, scale);
    });
  }

  void _handleLogout(BuildContext context, double scale) {
    showDialog<void>(
      context: context,
      builder: (ctx) {
        final theme = Theme.of(ctx);
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            backgroundColor: theme.colorScheme.surface,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20 * scale),
              side: BorderSide(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2),
              ),
            ),
            title: Text(
              'aura.confirm_departure'.tr(),
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 20 * scale,
              ),
            ),
            content: Text('aura.exit_message'.tr()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('aura.stay'.tr()),
              ),
              PrimeCareButton(
                label: 'aura.exit_session'.tr(),
                type: PrimeCareButtonType.danger,
                onPressed: () {
                  Navigator.pop(ctx);
                  ref.read(authProvider.notifier).logout();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PulseIndicator extends StatefulWidget {
  final Color color;
  final double scale;
  final Duration duration;

  const _PulseIndicator({
    required this.color,
    required this.scale,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<_PulseIndicator> createState() => _PulseIndicatorState();
}

class _PulseIndicatorState extends State<_PulseIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void didUpdateWidget(_PulseIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      if (!_controller.isAnimating) {
        _controller.repeat();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 8 * widget.scale,
          height: 8 * widget.scale,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(
                  alpha: 0.6 * (1 - _controller.value),
                ),
                blurRadius: 8 * widget.scale * _controller.value,
                spreadRadius: 4 * widget.scale * _controller.value,
              ),
            ],
          ),
        );
      },
    );
  }
}

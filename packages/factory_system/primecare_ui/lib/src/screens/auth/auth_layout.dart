import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AuthLayout extends StatefulWidget {
  final Widget child;
  final String heroTitle;
  final String heroSubtitle;

  const AuthLayout({
    super.key,
    required this.child,
    required this.heroTitle,
    required this.heroSubtitle,
  });

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  // null represents 'Native' - letting the real device constraints dictate.
  double? _overriddenWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Slate 100
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final effectiveWidth = _overriddenWidth ?? constraints.maxWidth;

              final isMobile = effectiveWidth < 600;
              final isTablet = effectiveWidth >= 600 && effectiveWidth < 900;

              Widget layoutOutput;
              if (isMobile || isTablet) {
                layoutOutput = SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildHeroSection(
                        context,
                        height: isMobile ? 240 : 300,
                        isCompact: isMobile,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 24.0 : 64.0,
                          vertical: 32.0,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 450),
                            child: widget.child,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                // Desktop Split Layout
                layoutOutput = Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: _buildHeroSection(context, isCompact: false),
                    ),
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 40,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 450),
                            child: widget.child,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              // Apply the artificial box constraint if overwritten.
              if (_overriddenWidth != null) {
                return Center(
                  child: Container(
                    width: _overriddenWidth,
                    height: constraints
                        .maxHeight, // Keep fullscreen height for prototype
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: PrimeCareColors.slate400.shade100,
                        width: 2,
                      ),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 20),
                      ],
                    ),
                    child: ClipRRect(child: layoutOutput),
                  ),
                );
              }

              return layoutOutput;
            },
          ),

          // Debug / Layout Controllers Area
          Positioned(
            top: 16,
            right: 16,
            child: Row(
              children: [
                // Screen Size Controller
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: PrimeCareColors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ToggleButtons(
                    borderRadius: BorderRadius.circular(20),
                    constraints: const BoxConstraints(
                      minHeight: 40,
                      minWidth: 40,
                    ),
                    isSelected: [
                      _overriddenWidth == 390, // Mobile
                      _overriddenWidth == 800, // Tablet
                      _overriddenWidth == null, // Native/Desktop
                    ],
                    onPressed: (index) {
                      setState(() {
                        if (index == 0) _overriddenWidth = 390;
                        if (index == 1) _overriddenWidth = 800;
                        if (index == 2) _overriddenWidth = null;
                      });
                    },
                    children: const [
                      Icon(
                        Icons.phone_iphone,
                        size: 20,
                        color: Color(0xFF006948),
                      ),
                      Icon(
                        Icons.tablet_mac,
                        size: 20,
                        color: Color(0xFF006948),
                      ),
                      Icon(
                        Icons.desktop_windows,
                        size: 20,
                        color: Color(0xFF006948),
                      ),
                    ],
                  ),
                ),

                // Language Switcher
                Container(
                  decoration: BoxDecoration(
                    color: PrimeCareColors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: PopupMenuButton<String>(
                    tooltip: 'Change Language',
                    offset: const Offset(0, 48),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.language,
                            color: Color(0xFF006948),
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'auth.language_system'.tr(),
                            style: const TextStyle(
                              color: Color(0xFF006948),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                    onSelected: (String result) {
                      if (result == 'EN') context.setLocale(const Locale('en'));
                      if (result == 'FR') context.setLocale(const Locale('fr'));
                      if (result == 'ES') context.setLocale(const Locale('es'));

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Language changed to $result')),
                      );
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'EN',
                            child: Text('English'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'FR',
                            child: Text('Français'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'ES',
                            child: Text('Español'),
                          ),
                        ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(
    BuildContext context, {
    double? height,
    bool isCompact = false,
  }) {
    return Container(
      height: height ?? double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)], // Slate 900 to 800
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.all(isCompact ? 32.0 : 64.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.shieldCheck,
                color: const Color(0xFF38BDF8),
                size: isCompact ? 32 : 48,
              ),
              const SizedBox(width: 16),
              Text(
                'PrimeCare',
                style: GoogleFonts.outfit(
                  fontSize: isCompact ? 24 : 32,
                  fontWeight: FontWeight.bold,
                  color: PrimeCareColors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            widget.heroTitle,
            style: GoogleFonts.outfit(
              fontSize: isCompact ? 36 : 64,
              fontWeight: FontWeight.w800,
              color: PrimeCareColors.white,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            widget.heroSubtitle,
            style: GoogleFonts.inter(
              fontSize: isCompact ? 16 : 20,
              color: PrimeCareColors.white.withValues(alpha: 0.6),
              height: 1.5,
            ),
          ),
          const Spacer(),
          if (!isCompact)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF38BDF8).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF38BDF8).withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    LucideIcons.lock,
                    color: Color(0xFF38BDF8),
                    size: 16,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'auth.security_notice_short'.tr(),
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: PrimeCareColors.white,
                        ),
                      ),
                      Text(
                        'auth.encryption_active'.tr(),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: PrimeCareColors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class AuthInputDecoration {
  static InputDecoration get(String label, IconData icon, {String? hintText}) {
    return InputDecoration(
      labelText: label,
      hintText: hintText,
      labelStyle: const TextStyle(
        color: Color(0xFF64748B),
        fontFamily: 'Inter',
      ), // Slate 500
      prefixIcon: Icon(icon, color: const Color(0xFF94A3B8)), // Slate 400
      filled: true,
      fillColor: PrimeCareColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFCBD5E1), // Slate 300
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF38BDF8), // Sky Blue
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    );
  }
}

// Using dynamicPageProvider and ViewModel pattern for data binding.

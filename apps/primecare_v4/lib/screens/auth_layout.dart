import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/theme/app_theme.dart';
import '../../office/components/glass_surface.dart';

class AuthLayout extends StatefulWidget {
  final Widget child;
  final String heroTitle;
  final String heroSubtitle;

  const AuthLayout({
    Key? key,
    required this.child,
    required this.heroTitle,
    required this.heroSubtitle,
  }) : super(key: key);

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  // null represents 'Native' - letting the real device constraints dictate.
  double? _overriddenWidth; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      _buildHeroSection(context, height: isMobile ? 240 : 300, isCompact: isMobile),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 24.0 : 64.0, 
                          vertical: 32.0
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
                      flex: 1,
                      child: _buildHeroSection(context, isCompact: false),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
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
                    height: constraints.maxHeight, // Keep fullscreen height for prototype
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey.shade100, width: 2),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 20)],
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
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                    ]
                  ),
                  child: ToggleButtons(
                    borderRadius: BorderRadius.circular(20),
                    constraints: const BoxConstraints(minHeight: 40, minWidth: 40),
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
                      Icon(Icons.phone_iphone, size: 20, color: Color(0xFF006948)),
                      Icon(Icons.tablet_mac, size: 20, color: Color(0xFF006948)),
                      Icon(Icons.desktop_windows, size: 20, color: Color(0xFF006948)),
                    ],
                  ),
                ),

                // Language Switcher
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                    ]
                  ),
                  child: PopupMenuButton<String>(
                    tooltip: 'Change Language',
                    offset: const Offset(0, 48),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.language, color: Color(0xFF006948), size: 20),
                          SizedBox(width: 6),
                          Text('EN', style: TextStyle(color: Color(0xFF006948), fontWeight: FontWeight.bold, fontFamily: 'Inter')),
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
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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

  Widget _buildHeroSection(BuildContext context, {double? height, bool isCompact = false}) {
    return Container(
      height: height ?? double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF006948), // Emerald Teal
            Color(0xFF002366), // Navy Indigo
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Ambient blur circles can be added here if needed
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isCompact ? 24.0 : 48.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.emergency, color: Colors.white, size: isCompact ? 24 : 32),
                    const SizedBox(width: 8),
                    Text(
                      'PrimeCare V4',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontSize: isCompact ? 18 : 22,
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  widget.heroTitle,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isCompact ? 24 : null,
                    fontFamily: 'Outfit',
                  ),
                ),
                if (!isCompact) ...[
                  const SizedBox(height: 16),
                  Text(
                    widget.heroSubtitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white.withOpacity(0.8),
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 32),
                  GlassSurface(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        const Icon(Icons.verified_user, color: Colors.white),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'End-to-End Encrypted. Institutional Data Privacy Audited.',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AuthInputDecoration {
  static InputDecoration get(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.blueGrey, fontFamily: 'Inter'),
      prefixIcon: Icon(icon, color: Colors.blueGrey),
      filled: true,
      fillColor: const Color(0xFFF2F4F6), // surface-container-low
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
        borderSide: const BorderSide(color: Color(0xFF006948), width: 2), // Focus Primary
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    );
  }
}

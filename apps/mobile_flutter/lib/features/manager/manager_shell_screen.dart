import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

class ManagerShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ManagerShellScreen({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index, BuildContext context) {
    HapticFeedback.lightImpact();
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Lighter Slate backing to contrast Obsidian
      extendBody: true,
      body: Stack(
        children: [
          navigationShell,
          
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    height: 72,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xEE020617), // Dense Obsidian Black Glass
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0x33F59E0B), width: 1.5), // Subtle Gold Trim
                      boxShadow: const [BoxShadow(color: Color(0x44000000), blurRadius: 24, offset: Offset(0, 12))],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildAnimatedExecutiveButton(context, 0, Icons.stacked_bar_chart_rounded, 'Overview'),
                        _buildNavItem(context, 1, Icons.business_outlined, 'Directory'),
                        _buildNavItem(context, 2, Icons.settings_applications_outlined, 'System'),
                        _buildNavItem(context, 3, Icons.admin_panel_settings_outlined, 'Execute'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAnimatedExecutiveButton(BuildContext context, int index, IconData icon, String label) {
    final bool isSelected = navigationShell.currentIndex == index;
    
    return GestureDetector(
      onTap: () {
        HapticFeedback.heavyImpact();
        _onTap(index, context);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutExpo,
        padding: EdgeInsets.symmetric(horizontal: isSelected ? 24 : 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD97706) : Colors.transparent, // Rich Liquid Gold
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected ? [const BoxShadow(color: Color(0x88F59E0B), blurRadius: 16, offset: Offset(0, 4))] : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? Colors.white : const Color(0xFF64748B), size: isSelected ? 28 : 24),
            if (isSelected) ...[
              const SizedBox(width: 8),
              AnimatedOpacity(
                opacity: isSelected ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 0.5)),
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label) {
    final bool isSelected = navigationShell.currentIndex == index;

    return GestureDetector(
      onTap: () => _onTap(index, context),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? const Color(0xFFF59E0B) : const Color(0xFF64748B), size: 24), // Pure Amber
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 4,
              width: isSelected ? 16 : 0,
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B),
                borderRadius: BorderRadius.circular(2),
              ),
            )
          ],
        ),
      ),
    );
  }
}

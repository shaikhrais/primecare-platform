// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_ui/src/components/layouts/01_I_responsive_grid_layout.dart';

class PrimeCareResponsiveKpiGrid extends ConsumerStatefulWidget {
  final List<Widget> children;

  const PrimeCareResponsiveKpiGrid({super.key, required this.children});

  @override
  ConsumerState<PrimeCareResponsiveKpiGrid> createState() =>
      _PrimeCareResponsiveKpiGridState();
}

class _PrimeCareResponsiveKpiGridState
    extends ConsumerState<PrimeCareResponsiveKpiGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref
        .read(executionGateProvider)
        .passGate(
          ExecutionGateCategory.auraEngine,
          'Rendering KPI Grid (V2 Snapping Enabled)',
        );
    final auraActive = ref.watch(auraActiveVisualizationProvider);
    final layout = ref.watch(layoutProvider);

    if (auraActive) {
      if (!_pulseController.isAnimating) {
        _pulseController.repeat(reverse: true);
      }
    } else {
      if (_pulseController.isAnimating) {
        _pulseController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
        );
      }
    }

    final grid = ResponsiveGridRow(
      spacing: 16 * layout.scaleFactor,
      runSpacing: 16 * layout.scaleFactor,
      children: widget.children.map((child) {
        return ResponsiveGridCol(
          span: 4,
          child: AspectRatio(aspectRatio: 1.6, child: child),
        );
      }).toList(),
    );

    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        final glowValue = _glowAnimation.value;
        return Container(
          padding: EdgeInsets.all(auraActive ? 8.0 * glowValue : 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: auraActive
                ? [
                    BoxShadow(
                      color: const Color(
                        0xFF6366F1,
                      ).withValues(alpha: 0.2 * glowValue),
                      blurRadius: 20 * glowValue,
                      spreadRadius: 5 * glowValue,
                    ),
                  ]
                : [],
          ),
          child: child,
        );
      },
      child: grid,
    );
  }
}

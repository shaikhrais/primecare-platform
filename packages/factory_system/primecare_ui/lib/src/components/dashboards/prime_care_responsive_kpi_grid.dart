import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

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
    ref.read(executionGateProvider).passGate(
      ExecutionGateCategory.auraEngine,
      'Rendering KPI Grid (Children: ${widget.children.length})',
    );
    final auraActive = ref.watch(auraActiveVisualizationProvider);

    if (auraActive) {
      if (!_pulseController.isAnimating) {
        _pulseController.repeat(reverse: true);
      }
    } else {
      if (_pulseController.isAnimating) {
        _pulseController.animateTo(0, duration: const Duration(milliseconds: 300));
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint management: Mobile (1), Tablet (2), Desktop (4)
        int crossAxisCount = 1;
        if (constraints.maxWidth > 600) crossAxisCount = 2;
        if (constraints.maxWidth > 1024) crossAxisCount = 4;

        final grid = GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.4, // Lowered ratio to provide more vertical headroom for resilient stacking
          children: widget.children,
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
                          color: const Color(0xFF6366F1)
                              .withValues(alpha: 0.2 * glowValue),
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
      },
    );
  }
}

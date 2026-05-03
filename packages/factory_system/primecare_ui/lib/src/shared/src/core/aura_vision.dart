// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'primecare_components.dart';
import 'aura_vision_blueprints.dart';
import 'aura_models.dart';

/// Defines the rendering fidelity for Aura Vision (HDL Mode).
enum AuraVisionMode {
  /// Standard live application mode.
  live,
  /// High-fidelity mockup with dummy data (How Do I Look Mode).
  highFidelity,
  /// Structural blueprint (wireframe) showing component boundaries.
  blueprint,
  /// Aesthetic audit mode with intensified colors and gradients.
  auraAudit,
}

/// A "Screen Object" that holds visual instructions and mock data for HDL rendering.
class AuraScreenBlueprint {
  final String screenId;
  final String title;
  final String visualCategory;
  final Map<String, dynamic> mockData;
  final List<String> components;

  const AuraScreenBlueprint({
    required this.screenId,
    required this.title,
    required this.visualCategory,
    this.mockData = const {},
    this.components = const [],
  });

  /// Factory to generate dummy data for a "Clinical" category screen.
  factory AuraScreenBlueprint.mockClinical(String id, String title) {
    return AuraScreenBlueprint(
      screenId: id,
      title: title,
      visualCategory: 'Clinical',
      mockData: {
        'telemetryValue': '98.6',
        'status': 'Stable',
        'trend': 'Positive',
        'kpi': '4.2',
      },
      components: ['AuraDashboardHud', 'MetricCard', 'TrendGraph'],
    );
  }
}

/// A specialized widget that renders a screen in "How Do I Look" mode.
class AuraVisionRenderer extends ConsumerWidget {
  final Widget liveWidget;
  final AuraScreenBlueprint? blueprint;

  const AuraVisionRenderer({
    super.key,
    required this.liveWidget,
    this.blueprint,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch<AuraVisionMode>(auraVisionProvider);

    return switch (mode) {
      AuraVisionMode.highFidelity => _buildHdlPreview(context, ref),
      AuraVisionMode.blueprint => _buildBlueprint(context),
      AuraVisionMode.auraAudit => _buildAuraAudit(context),
      AuraVisionMode.live => _AuraLiveWrapper(child: liveWidget),
    };
  }

  Widget _buildHdlPreview(BuildContext context, WidgetRef ref) {
    // If no specific blueprint is provided, try to resolve one based on the context's role
    // This allows for "Zero-Config" HDL previews.
    final effectiveBlueprint = blueprint ?? AuraVisionBlueprints.resolveForRole('Standard User');

    return Stack(
      children: [
        liveWidget,
        Positioned.fill(
          child: Container(
            color: Colors.black.withValues(alpha: 0.1),
            child: Center(
              child: AuraDashboardHud(
                title: effectiveBlueprint.title,
                value: (effectiveBlueprint.mockData['telemetryValue'] as String?) ?? '--',
                auraLabel: '${effectiveBlueprint.visualCategory} PREVIEW',
              ),
            ),
          ),
        ),
        _buildWatermark('HDL MODE: HIGH-FIDELITY'),
      ],
    );
  }

  Widget _buildBlueprint(BuildContext context) {
    return Stack(
      children: [
        liveWidget,
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.5), width: 2),
            ),
            child: CustomPaint(
              painter: _BlueprintGridPainter(),
            ),
          ),
        ),
        _buildWatermark('BLUEPRINT MODE'),
      ],
    );
  }

  Widget _buildAuraAudit(BuildContext context) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix([
        1.2, 0, 0, 0, 0,
        0, 1.2, 0, 0, 0,
        0, 0, 1.2, 0, 0,
        0, 0, 0, 1, 0,
      ]),
      child: liveWidget,
    );
  }

  Widget _buildWatermark(String text) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.cyanAccent.withValues(alpha: 0.1)
      ..strokeWidth = 0.5;

    for (double i = 0; i < size.width; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 20) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Notifier for Aura Vision state management.
class AuraVisionNotifier extends Notifier<AuraVisionMode> {
  @override
  AuraVisionMode build() => AuraVisionMode.live;

  /// Updates the rendering mode.
  void setMode(AuraVisionMode mode) => state = mode;
}

/// Global provider for Aura Vision Mode.
final auraVisionProvider = NotifierProvider<AuraVisionNotifier, AuraVisionMode>(AuraVisionNotifier.new);

class _AuraLiveWrapper extends ConsumerWidget {
  final Widget child;
  const _AuraLiveWrapper({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pulseEvent = ref.watch<AuraEvent?>(auraPulseEventProvider);
    final hasActiveEvent = pulseEvent != null && pulseEvent.type != AuraEventType.stableheartbeat;

    return Stack(
      children: [
        child,
        if (hasActiveEvent)
          Positioned(
            top: 100, // Float below the app bar
            left: 20,
            right: 20,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, -20 * (1.0 - value)),
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                );
              },
              child: const AuraDashboardHud(),
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/prime_theme.dart';

/// Semantic status roles resolved from the inherited product theme.
enum PrimeStatusTone { error, muted, success, warning }

Color _statusColor(BuildContext context, PrimeStatusTone tone) => switch (tone) {
  PrimeStatusTone.success => context.theme.colors.success,
  PrimeStatusTone.warning => context.theme.colors.warning,
  PrimeStatusTone.error => context.theme.colors.error,
  PrimeStatusTone.muted => context.theme.colors.onSurfaceVariant,
};

/// Const-compatible icon whose status color follows the active theme.
class PrimeStatusIcon extends StatelessWidget {
  final IconData icon;
  final PrimeStatusTone tone;
  final double? size;

  const PrimeStatusIcon(this.icon, {
    super.key,
    required this.tone,
    this.size,
  });

  @override
  Widget build(BuildContext context) => Icon(icon,
    size: size,
    color: _statusColor(context, tone),
  );
}

/// Retains inherited typography and scaling while applying a semantic color.
class PrimeStatusText extends StatelessWidget {
  final String data;
  final PrimeStatusTone tone;

  const PrimeStatusText(this.data, {super.key, required this.tone});

  @override
  Widget build(BuildContext context) => Text(data,
    style: TextStyle(color: _statusColor(context, tone)),
  );
}

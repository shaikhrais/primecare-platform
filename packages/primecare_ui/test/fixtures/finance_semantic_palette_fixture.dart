import 'package:primecare_ui/primecare_ui.dart';

class FinancePaletteFixture0 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const FinancePaletteFixture0({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Card(
      color: theme.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(theme.radiusMd),
        side: BorderSide(color: theme.colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: PrimeActionPalette.tintSurface(context, iconColor, alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: PrimeActionPalette.onTint(context, iconColor, alpha: 0.1), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: theme.typography.h2.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FinancePaletteFixture1 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const FinancePaletteFixture1({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Card(
      color: theme.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(theme.radiusMd),
        side: BorderSide(color: theme.colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: PrimeActionPalette.tintSurface(context, iconColor, alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: PrimeActionPalette.onTint(context, iconColor, alpha: 0.1), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: theme.typography.h2.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FinancePaletteFixture2 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const FinancePaletteFixture2({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: PrimeActionPalette.tintSurface(context, color, alpha: 0.1),
            child: Icon(icon, color: PrimeActionPalette.onTint(context, color, alpha: 0.1)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.typography.h2.copyWith(
                  color: theme.colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FinancePaletteFixture3 extends StatelessWidget {
  final String label;
  final String value;
  final String activeFilter;
  final ValueChanged<String> onTap;

  const FinancePaletteFixture3({
    required this.label,
    required this.value,
    required this.activeFilter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isActive = value == activeFilter;

    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? theme.colors.primary : theme.colors.background,
          borderRadius: BorderRadius.circular(theme.radiusMd),
          border: Border.all(color: isActive ? theme.colors.primary : theme.colors.border),
        ),
        child: Text(
          label,
          style: theme.typography.bodyMedium.copyWith(
            color: isActive ? PrimeActionPalette.of(context, PrimeActionTone.primary).onAccent : theme.colors.onSurface,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class FinancePaletteFixture4 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const FinancePaletteFixture4({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: PrimeActionPalette.tintSurface(context, color, alpha: 0.1),
            child: Icon(icon, color: PrimeActionPalette.onTint(context, color, alpha: 0.1)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.typography.h2.copyWith(
                  color: theme.colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FinancePaletteFixture5 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const FinancePaletteFixture5({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Card(
      color: theme.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(theme.radiusMd),
        side: BorderSide(color: theme.colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: PrimeActionPalette.tintSurface(context, iconColor, alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: PrimeActionPalette.onTint(context, iconColor, alpha: 0.1), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: theme.typography.h2.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FinancePaletteFixture6 extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const FinancePaletteFixture6({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: PrimeActionPalette.tintSurface(context, color, alpha: 0.1),
            child: Icon(icon, color: PrimeActionPalette.onTint(context, color, alpha: 0.1), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.typography.bodySmall.copyWith(
                    color: theme.colors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.typography.h2.copyWith(
                    color: theme.colors.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.typography.bodySmall.copyWith(
                    color: theme.colors.onSurfaceVariant,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FinancePaletteFixture7 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const FinancePaletteFixture7({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: PrimeActionPalette.tintSurface(context, color, alpha: 0.1),
            child: Icon(icon, color: PrimeActionPalette.onTint(context, color, alpha: 0.1)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.typography.h2.copyWith(
                  color: theme.colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TaxLedgerPaletteFixture extends StatelessWidget {
  final Map<String,dynamic> entry;
  const TaxLedgerPaletteFixture(this.entry,{super.key});
  @override
  Widget build(BuildContext context) {
    final theme=context.theme;
    final isPending = entry['status'] == 'pending';
                              Color statusColor = isPending ? PrimeActionPalette.of(context, PrimeActionTone.warning).onBase : PrimeActionPalette.of(context, PrimeActionTone.success).onBase;
    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: PrimeActionPalette.tintSurface(context, statusColor, alpha: 0.1),
                                        borderRadius: BorderRadius.circular(theme.radiusSm),
                                      ),
                                      child: Text(
                                        isPending ? 'Pending Filing' : 'Settled',
                                        style: theme.typography.labelBold.copyWith(color: PrimeActionPalette.onTint(context, statusColor, alpha: 0.1)),
                                      ),
                                    );
  }
}

class FinancePaletteFixture9 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const FinancePaletteFixture9({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Card(
      color: theme.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(theme.radiusMd),
        side: BorderSide(color: theme.colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: PrimeActionPalette.tintSurface(context, iconColor, alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: PrimeActionPalette.onTint(context, iconColor, alpha: 0.1), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: theme.typography.h2.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FinancePaletteFixture10 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const FinancePaletteFixture10({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: PrimeActionPalette.tintSurface(context, color, alpha: 0.1),
            child: Icon(icon, color: PrimeActionPalette.onTint(context, color, alpha: 0.1)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.typography.h2.copyWith(
                  color: theme.colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FinancePaletteFixture11 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const FinancePaletteFixture11({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Card(
      color: theme.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(theme.radiusMd),
        side: BorderSide(color: theme.colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: PrimeActionPalette.tintSurface(context, iconColor, alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: PrimeActionPalette.onTint(context, iconColor, alpha: 0.1), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: theme.typography.h2.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

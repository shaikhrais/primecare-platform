import 'package:primecare_ui/primecare_ui.dart';

class OperationsPaletteFixture0 extends StatelessWidget {
  final String label;
  final String value;
  final String activeFilter;
  final ValueChanged<String> onTap;

  const OperationsPaletteFixture0({
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

class OperationsPaletteFixture1 extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const OperationsPaletteFixture1({
    required this.title,
    required this.value,
    required this.subtitle,
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
                color: PrimeActionPalette.tintSurface(context, iconColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: PrimeActionPalette.onTint(context, iconColor), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: theme.typography.h2.copyWith(
                      color: theme.colors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: theme.typography.bodySmall.copyWith(
                      color: theme.colors.onSurfaceVariant,
                      fontSize: 11,
                    ),
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

class OperationsPaletteFixture2 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const OperationsPaletteFixture2({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Card(
      color: theme.colors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: PrimeActionPalette.tintSurface(context, color),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: PrimeActionPalette.onTint(context, color), size: 20),
            ),
            const SizedBox(height: 14),
            Text(
              value,
              style: const TextStyle(),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}

class OperationsPaletteFixture3 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const OperationsPaletteFixture3({
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
            backgroundColor: PrimeActionPalette.tintSurface(context, color),
            child: Icon(icon, color: PrimeActionPalette.onTint(context, color)),
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

class OperationsPaletteFixture4 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const OperationsPaletteFixture4({
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
                color: PrimeActionPalette.tintSurface(context, iconColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: PrimeActionPalette.onTint(context, iconColor), size: 24),
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

class OperationsPaletteFixture5 extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const OperationsPaletteFixture5({
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
            backgroundColor: PrimeActionPalette.tintSurface(context, color),
            child: Icon(icon, color: PrimeActionPalette.onTint(context, color)),
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
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant, fontSize: 11),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class OperationsPaletteFixture6 extends StatelessWidget {
  final String label;
  final String value;
  final String activeValue;
  final ValueChanged<String> onTap;

  const OperationsPaletteFixture6({
    required this.label,
    required this.value,
    required this.activeValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isActive = value == activeValue;

    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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


class PendingAssessmentStatusFixture extends StatelessWidget {
 final Map<String,dynamic> item;
 const PendingAssessmentStatusFixture(this.item,{super.key});
 @override Widget build(BuildContext context) {
 final isPending = item['status'] == 'Pending';
                            final isCompleted = item['status'] == 'Completed';
 return Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: isCompleted
                                                      ? PrimeActionPalette.of(context, PrimeActionTone.success).surface
                                                      : isPending
                                                          ? PrimeActionPalette.of(context, PrimeActionTone.warning).surface
                                                          : PrimeActionPalette.of(context, PrimeActionTone.primary).surface,
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  (item['status'] as String).toUpperCase(),
                                                  style: TextStyle(
                                                    color: isCompleted
                                                        ? PrimeActionPalette.of(context, PrimeActionTone.success).onSurface
                                                        : isPending
                                                            ? PrimeActionPalette.of(context, PrimeActionTone.warning).onSurface
                                                            : PrimeActionPalette.of(context, PrimeActionTone.primary).onSurface,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              );
 }
}

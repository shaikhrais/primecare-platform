import 'package:primecare_ui/primecare_ui.dart';
// Governance - Category: view | Purpose: Core implementation file for the Governance Filter Bar platform logic.
import 'package:flutter_core/flutter_core.dart';

class GovernanceFilterBar extends StatelessWidget {
  final AuditSeverity? selectedSeverity;
  final GovernanceCategory? selectedCategory;
  final Function(AuditSeverity?) onSeverityChanged;
  final Function(GovernanceCategory?) onCategoryChanged;
  final VoidCallback onClear;

  const GovernanceFilterBar({
    super.key,
    this.selectedSeverity,
    this.selectedCategory,
    required this.onSeverityChanged,
    required this.onCategoryChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.theme.colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.theme.colors.outlineVariant),
      ),
      child: Wrap(
        spacing: 16,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          PrimeIcon(Icons.filter_list_rounded, color: context.theme.colors.onSurfaceVariant, size: 20),

          // Severity Filter
          _buildFilterChip<AuditSeverity>(
            context,
            'governance.filterBar.severityLabel'.tr(
              args: [
                selectedSeverity?.name.toUpperCase() ??
                    'governance.filterBar.all'.tr(),
              ],
            ),
            AuditSeverity.values,
            selectedSeverity,
            onSeverityChanged,
          ),

          // Category Filter
          _buildFilterChip<GovernanceCategory>(
            context,
            'governance.filterBar.categoryLabel'.tr(
              args: [
                selectedCategory?.name.toUpperCase() ??
                    'governance.filterBar.all'.tr(),
              ],
            ),
            GovernanceCategory.values,
            selectedCategory,
            onCategoryChanged,
          ),

          if (selectedSeverity != null || selectedCategory != null)
            PrimeTextButton.icon(
              onPressed: onClear,
              icon: const PrimeIcon(Icons.clear_all_rounded, size: 18),
              label: PrimeText(
                'governance.filterBar.clearFilters'.tr(),
                style: const TextStyle(fontSize: 12),
              ),
              style: PrimeTextButton.styleFrom(foregroundColor: PrimeActionPalette.of(context, PrimeActionTone.error).onBase),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterChip<T extends Enum>(
    BuildContext context,
    String label,
    List<T> values,
    T? selectedValue,
    Function(T?) onSelected,
  ) {
    return PopupMenuButton<T?>(
      onSelected: onSelected,
      itemBuilder: (context) => [
        PopupMenuItem<T?>(
          value: null,
          child: PrimeText('governance.filterBar.all'.tr()),
        ),
        ...values.map(
          (v) => PopupMenuItem<T?>(value: v, child: PrimeText(v.name.toUpperCase())),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selectedValue != null
              ? PrimeActionPalette.of(context, PrimeActionTone.primary).surface
              : context.theme.colors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selectedValue != null ? PrimeActionPalette.of(context, PrimeActionTone.primary).accent : context.theme.colors.surface.withValues(alpha: 0),
          ),
        ),
        child: Row(
          children: [
            PrimeText(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selectedValue != null
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: selectedValue != null ? PrimeActionPalette.of(context, PrimeActionTone.primary).onSurface : null,
              ),
            ),
            const PrimeIcon(Icons.arrow_drop_down, size: 18),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/governance_severity.dart';
import '../models/governance_category.dart';

class GovernanceFilterBar extends StatelessWidget {
  final GovernanceSeverity? selectedSeverity;
  final GovernanceCategory? selectedCategory;
  final Function(GovernanceSeverity?) onSeverityChanged;
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
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.filter_list_rounded, color: Colors.grey, size: 20),
          const SizedBox(width: 16),
          
          // Severity Filter
          _buildFilterChip<GovernanceSeverity>(
            context,
            'Severity: ${selectedSeverity?.name.toUpperCase() ?? "All"}',
            GovernanceSeverity.values,
            selectedSeverity,
            onSeverityChanged,
          ),
          
          const SizedBox(width: 12),
          
          // Category Filter
          _buildFilterChip<GovernanceCategory>(
            context,
            'Category: ${selectedCategory?.name.toUpperCase() ?? "All"}',
            GovernanceCategory.values,
            selectedCategory,
            onCategoryChanged,
          ),
          
          const Spacer(),
          
          if (selectedSeverity != null || selectedCategory != null)
            TextButton.icon(
              onPressed: onClear,
              icon: const Icon(Icons.clear_all_rounded, size: 18),
              label: const Text('Clear Filters', style: TextStyle(fontSize: 12)),
              style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
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
          child: const Text('All'),
        ),
        ...values.map((v) => PopupMenuItem<T?>(
          value: v,
          child: Text(v.name.toUpperCase()),
        )),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selectedValue != null 
            ? Colors.blue.withValues(alpha: 0.1) 
            : Colors.grey.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selectedValue != null ? Colors.blue : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selectedValue != null ? FontWeight.bold : FontWeight.normal,
                color: selectedValue != null ? Colors.blue : null,
              ),
            ),
            const Icon(Icons.arrow_drop_down, size: 18),
          ],
        ),
      ),
    );
  }
}

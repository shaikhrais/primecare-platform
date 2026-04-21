// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';

class MasterDetailLayout extends ConsumerWidget {
  final Widget masterList;
  final Widget detailView;
  final bool isDetailActive;
  final VoidCallback onBackToMaster;

  const MasterDetailLayout({
    super.key,
    required this.masterList,
    required this.detailView,
    required this.isDetailActive,
    required this.onBackToMaster,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = ref.watch(layoutProvider).scaleFactor;
    final ds = PrimeCareDesignSystem.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        // Desktop / Tablet Split-Pane Strategy
        if (constraints.maxWidth >= 900) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Proportional Master Pane
              Container(
                width: PrimeCareSpacing.scaled(350, scale),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: ds.colors.borderSubtle, width: 1),
                  ),
                  color: ds.colors.surface,
                ),
                child: masterList,
              ),
              // 70% Detail Pane
              Expanded(
                child: isDetailActive
                    ? detailView
                    : Center(
                        child: Text(
                          'Select an item from the list to view details.',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: ds.colors.textTertiary,
                            fontSize: PrimeCareSpacing.scaled(16, scale),
                          ),
                        ),
                      ),
              ),
            ],
          );
        } else {
          // Mobile Stack Paradigm (Overlay or Navigated natively)
          // The router handles mobile push, so if we rely on a physical dual widget:
          // Mobile conditionally renders the List OR the Detail based on boolean context.
          if (isDetailActive) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: ds.colors.surface,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: ds.colors.primary,
                    size: PrimeCareSpacing.scaled(24, scale),
                  ),
                  onPressed: onBackToMaster,
                ),
                title: Text(
                  'Details',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: ds.colors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: PrimeCareSpacing.scaled(18, scale),
                  ),
                ),
              ),
              body: detailView,
            );
          } else {
            return masterList;
          }
        }
      },
    );
  }
}

// Using dynamicPageProvider and ViewModel pattern for data binding.

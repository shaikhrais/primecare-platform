import 'package:flutter/material.dart';
import '../theme/colors.dart';

class MasterDetailLayout extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Desktop / Tablet Split-Pane Strategy
        if (constraints.maxWidth >= 900) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 30% Master Pane
              Container(
                width: 350, // Fixed width for comfortable reading or dynamic
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: PrimeCareColors.slate200,
                      width: 1,
                    ),
                  ),
                  color: Colors.white,
                ),
                child: masterList,
              ),
              // 70% Detail Pane
              Expanded(
                child: isDetailActive
                    ? detailView
                    : const Center(
                        child: Text(
                          'Select an item from the list to view details.',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: PrimeCareColors.slate400,
                            fontSize: 16,
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
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: PrimeCareColors.radarDark,
                  ),
                  onPressed: onBackToMaster,
                ),
                title: const Text(
                  'Details',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: PrimeCareColors.radarDark,
                    fontWeight: FontWeight.bold,
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

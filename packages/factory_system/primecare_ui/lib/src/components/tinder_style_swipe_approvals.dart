import 'package:flutter/material.dart';
import 'prime_card.dart';

class TinderStyleSwipeApprovals<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final void Function(T item)? onApprove;
  final void Function(T item)? onReject;
  final Widget? emptyState;

  const TinderStyleSwipeApprovals({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.onApprove,
    this.onReject,
    this.emptyState,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return emptyState ??
          const Center(
            child: Text(
              'No items left to approve.',
              style: TextStyle(color: Colors.grey),
            ),
          );
    }

    // Usually you'd use a Stack and a Card Swiper package for true tinder effects.
    // For now, we wrap a standard ListView with Dismissibles to handle the T-typed records.
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        // Unique key required for Dismissible. Using index as fallback if model has no id.
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Dismissible(
            key: ValueKey('swipe_card_${item.hashCode}_$index'),
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                onApprove?.call(item);
              } else {
                onReject?.call(item);
              }
            },
            background: Container(
              color: Colors.green,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Icon(Icons.check, color: Colors.white, size: 40),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.close, color: Colors.white, size: 40),
            ),
            child: PrimeCard(child: itemBuilder(context, item)),
          ),
        );
      },
    );
  }
}

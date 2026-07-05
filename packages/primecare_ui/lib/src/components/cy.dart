// Governance - Category: component | Purpose: Reusable Flutter Web E2E Testing Wrapper
import 'package:flutter/material.dart';

/// A reusable testing wrapper that injects custom accessibility semantics 
/// and keys for reliable headless Cypress testing on Flutter Web.
class Cy extends StatelessWidget {
  final String id;
  final Widget child;
  final bool container;

  const Cy({
    super.key,
    required this.id,
    required this.child,
    this.container = true,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'dy-data:$id data-cy:$id',
      container: container,
      child: KeyedSubtree(
        key: Key(id),
        child: child,
      ),
    );
  }
}

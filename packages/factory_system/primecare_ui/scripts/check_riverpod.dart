// Governance - Category: service | Purpose: Check for Family variants
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  print('Riverpod classes available:');
  try {
    print('AsyncNotifier: ${AsyncNotifier}');
    // Check for Family variants
  } catch (e) {
    print('Error checking classes: $e');
  }
}

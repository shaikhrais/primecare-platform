import 'package:flutter/widgets.dart';

/// Shared content spacing for dashboard cards and bounded record rows.
abstract final class PrimeContentInsets {
  static const card = EdgeInsets.all(16);
  static const row = EdgeInsets.symmetric(vertical: 8);
}

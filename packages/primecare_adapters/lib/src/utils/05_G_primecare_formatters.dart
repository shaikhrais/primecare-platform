// Layer: 05_REGISTRY_GOVERNANCE
import 'package:intl/intl.dart';

/// Centralized formatting utilities for the PrimeCare platform.
/// Ensures that currency, dates, and timestamps are consistent across all dashboards.
class PrimeCareFormatters {
  /// Formats a double into a currency string (e.g., $1,234.56).
  static String formatCurrency(double amount, {String symbol = '\$', bool isCompact = false}) {
    if (isCompact) {
      return NumberFormat.compactCurrency(symbol: symbol, decimalDigits: 1).format(amount);
    }
    return NumberFormat.currency(symbol: symbol, decimalDigits: 2).format(amount);
  }

  /// Formats a double into a percentage string (e.g., 99.9%).
  static String formatPercentage(double value) {
    return NumberFormat.decimalPercentPattern(decimalDigits: 1).format(value);
  }

  /// Formats a number into a compact value string (e.g., 1.2M).
  static String formatCompactValue(num value) {
    return NumberFormat.compact().format(value);
  }

  /// Formats a number with commas (e.g., 1,234).
  static String formatNumber(num value) {
    return NumberFormat.decimalPattern().format(value);
  }

  /// Formats a DateTime into a human-readable date (e.g., Apr 20, 2026).
  static String formatDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  /// Formats a DateTime into a full timestamp with time.
  static String formatDateTime(DateTime date) {
    return DateFormat.yMMMd().add_jm().format(date);
  }

  /// Generates a standardized ISO8601 timestamp for network requests.
  static String getIsoTimestamp() {
    return DateTime.now().toIso8601String();
  }

  /// Formats a DateTime into a relative time string (e.g., 2m ago).
  static String formatRelativeTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 365) return '${(difference.inDays / 365).floor()}y ago';
    if (difference.inDays > 30) return '${(difference.inDays / 30).floor()}mo ago';
    if (difference.inDays > 0) return '${difference.inDays}d ago';
    if (difference.inHours > 0) return '${difference.inHours}h ago';
    if (difference.inMinutes > 0) return '${difference.inMinutes}m ago';
    return 'just now';
  }
}

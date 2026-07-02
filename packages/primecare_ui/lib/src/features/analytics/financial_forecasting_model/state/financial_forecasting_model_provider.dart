// Governance - Category: state | Purpose: Riverpod state notifier for Financial Forecasting Model
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinancialForecastingModelNotifier extends StateNotifier<AsyncValue<void>> {
  FinancialForecastingModelNotifier() : super(const AsyncValue.data(null));
}

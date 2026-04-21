// Layer: 03_DATA_DOMAIN_LOGIC
import "package:flutter_riverpod/flutter_riverpod.dart";
final cooDashboardProvider = Provider<AsyncValue<Map<String, dynamic>>>((ref) => const AsyncValue.data({"active_incidents": 2, "compliance": "100%"}));

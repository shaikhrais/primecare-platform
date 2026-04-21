// Layer: 03_DATA_DOMAIN_LOGIC
import "package:flutter_riverpod/flutter_riverpod.dart";
final regionalBdmDashboardProvider = Provider<AsyncValue<Map<String, dynamic>>>((ref) => const AsyncValue.data({"region": "North America", "leads": 45}));

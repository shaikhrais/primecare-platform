// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:flutter_riverpod/flutter_riverpod.dart';
final ceoDashboardProvider = Provider<AsyncValue<Map<String, dynamic>>>((ref) => const AsyncValue.data({'revenue': '$1.2M', 'growth': '+12.5%'}));

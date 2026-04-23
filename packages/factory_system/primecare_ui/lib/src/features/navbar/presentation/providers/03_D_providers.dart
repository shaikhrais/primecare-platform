// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navbarContextProvider = Provider<AsyncValue<Map<String, dynamic>>>((ref) => const AsyncValue.data({}));

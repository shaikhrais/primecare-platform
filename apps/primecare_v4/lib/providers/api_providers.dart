import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/dio_client.dart';

final dioClientProvider = Provider<DioClient>((ref) => DioClient());

final dioProvider = Provider((ref) => ref.watch(dioClientProvider).dio);

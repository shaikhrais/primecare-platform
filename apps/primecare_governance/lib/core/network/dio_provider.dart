// Governance - Category: controller | Purpose: Core implementation file for the Dio Provider platform logic.
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'performance_interceptor.dart';
import 'audit_interceptor.dart';
import '../services/audit_service.dart';
import '../config/env_config.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: EnvConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  final auditService = ref.watch(auditServiceProvider);
  dio.interceptors.addAll([
    PerformanceInterceptor(),
    AuditInterceptor(auditService),
    LogInterceptor(requestBody: true, responseBody: true),
  ]);

  return dio;
});

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final systemVerificationAdapterProvider =
    FutureProvider<Result<SystemVerificationViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'system_verification_metrics';

      return Result.guardFuture<SystemVerificationViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<SystemVerificationViewModel>(
            fetchCall: () async {
              const edgeUrl =
                  'https://primecare-verification-service.itpro-mohammed.workers.dev';
              const endpoint = '/v1/database/report';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching System Verification Metrics: $edgeUrl$endpoint',
              );

              // Instantiate an isolated Dio client for the telemetry edge worker
              final edgeDio = Dio(
                BaseOptions(
                  baseUrl: edgeUrl,
                  connectTimeout: const Duration(seconds: 10),
                  receiveTimeout: const Duration(seconds: 10),
                ),
              );

              final response = await edgeDio.get(endpoint);

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'System Verification Hydrated successfully',
                );

                final metrics = response.data as Map<String, dynamic>;
                final viewModel = SystemVerificationViewModel.fromJson(metrics);

                // Save to LKG cache
                unawaited(
                  resilience.saveSnapshot(cacheKey, viewModel.toJson()),
                );

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Verification Metrics Error: ${response.statusCode}',
                  metadata: {'status': response.statusCode},
                );
                throw Exception(
                  'API error loading verification data: ${response.statusCode}',
                );
              }
            },
            fallbackBuilder: () {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'System Verification Fallback Triggered',
              );
              return SystemVerificationViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.metricsLayer,
            'Deterministic Failure in System Verification Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring System Verification from cache',
            );
            return SystemVerificationViewModel.fromJson(snapshot);
          }
          throw e;
        },
      );
    });

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'package:primecare_mobile/features/roles/client/models/client_care_team_model.dart';

final clientCareTeamProvider =
    FutureProvider.autoDispose<List<ClientCaregiverData>>((ref) async {
      try {
        final data = await apiClient.get('/v1/client/care-team');
        if (data is List) {
          return data.map((json) => ClientCaregiverData.fromJson(json)).toList();
        }
        return [];
      } catch (e) {
        throw Exception(
          'Failed to load roster dynamically safely seamlessly. Error: $e',
        );
      }
    });

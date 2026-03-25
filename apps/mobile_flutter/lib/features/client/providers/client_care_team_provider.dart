import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'package:primecare_mobile/features/client/models/client_care_team_model.dart';

final clientCareTeamProvider =
    FutureProvider.autoDispose<List<ClientCaregiverData>>((ref) async {
      final response = await apiClient.get('/api/client/team/roster');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => ClientCaregiverData.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load roster dynamically safely seamlessly. Status: ${response.statusCode}',
        );
      }
    });

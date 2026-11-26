// Governance - Category: controller | Purpose: Non-executable scaffold for ClientCareTeamScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final clientCareTeamScreenControllerProvider =
    NotifierProvider<
      ClientCareTeamScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClientCareTeamScreenController();
    });

class ClientCareTeamScreenController extends BaseScaffoldController {}

// Governance - Category: controller | Purpose: Non-executable scaffold for ClientCareTeamScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final clientCareTeamScreenControllerProvider =
    NotifierProvider<
      ClientCareTeamScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClientCareTeamScreenController();
    });

class ClientCareTeamScreenController extends BaseScaffoldController {}

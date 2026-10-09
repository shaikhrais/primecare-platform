// Governance - Category: controller | Purpose: Non-executable scaffold for ClientProfileScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final clientProfileScreenControllerProvider =
    NotifierProvider<
      ClientProfileScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return ClientProfileScreenController();
    });

class ClientProfileScreenController extends BaseScaffoldController {}

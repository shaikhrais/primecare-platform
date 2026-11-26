// Governance - Category: controller | Purpose: Non-executable scaffold for PswNotificationsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final pswNotificationsScreenControllerProvider =
    NotifierProvider<
      PswNotificationsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswNotificationsScreenController();
    });

class PswNotificationsScreenController extends BaseScaffoldController {}

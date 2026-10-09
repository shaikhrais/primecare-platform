// Governance - Category: controller | Purpose: Non-executable scaffold for SocialWorkerDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final socialWorkerDashboardScreenControllerProvider =
    NotifierProvider<
      SocialWorkerDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return SocialWorkerDashboardScreenController();
    });

class SocialWorkerDashboardScreenController extends BaseScaffoldController {}

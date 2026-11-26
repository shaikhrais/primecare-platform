// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingCoordinatorCertificationsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final trainingCoordinatorCertificationsScreenControllerProvider =
    NotifierProvider<
      TrainingCoordinatorCertificationsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingCoordinatorCertificationsScreenController();
    });

class TrainingCoordinatorCertificationsScreenController
    extends BaseScaffoldController {}

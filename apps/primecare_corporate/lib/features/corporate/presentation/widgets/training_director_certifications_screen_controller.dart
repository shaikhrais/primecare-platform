// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorCertificationsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final trainingDirectorCertificationsScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorCertificationsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorCertificationsScreenController();
    });

class TrainingDirectorCertificationsScreenController
    extends BaseScaffoldController {}

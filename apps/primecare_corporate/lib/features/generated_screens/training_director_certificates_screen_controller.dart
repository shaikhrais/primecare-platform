// Governance - Category: controller | Purpose: Non-executable scaffold for TrainingDirectorCertificatesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final trainingDirectorCertificatesScreenControllerProvider =
    NotifierProvider<
      TrainingDirectorCertificatesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return TrainingDirectorCertificatesScreenController();
    });

class TrainingDirectorCertificatesScreenController
    extends BaseScaffoldController {}
